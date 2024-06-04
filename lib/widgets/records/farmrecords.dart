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
        maxWidth: MediaQuery.of(context).size.width * 0.8,
        minWidth: MediaQuery.of(context).size.width * 0.6,
      ),
      content: Column(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Text(
                'KAMBANG CO-OPERATIVE FOOD FARMING AND',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'MARKETING SOCIETY LIMITED',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              const Image(image: AssetImage('assets/images/logo.jpeg'), height: 100,),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'FARM RECORDS',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),

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
