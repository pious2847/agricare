// ignore_for_file: deprecated_member_use

import 'dart:typed_data';

import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/farm.dart';
import 'package:agricare/screens/farms.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/widgets/tabels/farmstabels.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GeneratePdf extends StatefulWidget {
  const GeneratePdf({super.key});

  @override
  State<GeneratePdf> createState() => _GeneratePdfState();
}

class _GeneratePdfState extends State<GeneratePdf> {
  late final FarmCrud _farmCrud = DatabaseHelper.instance.farmCrudInstance;
  List<Farm> farms = [];
  @override
  void initState() {
    loadFarms();
    super.initState();
  }

  Future<void> loadFarms() async {
    farms = await _farmCrud.getFarms();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.6,
      ),
      content: Column(
        children: [
          Column(
            children: [
              Text('KAMBANG CO-OPERATIVE FOOD FARMING AND', style: TextStyle(fontSize: 35, color: Colors.blue, fontWeight: FontWeight.bold),),
              Text('MARKETING SOCIETY LIMITED',style: TextStyle(fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold),)
            ],
          )
        ],
      ),
    );
  }

  Future<void> generatePdf(Farm farms) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return farmTabels(farms);
        },
      ),
    );

    await Printing.sharePdf(
        bytes: await pdf.save(),
        filename: 'Kambang-Cooperative-Farm-Records.pdf');
    ;
  }
}
