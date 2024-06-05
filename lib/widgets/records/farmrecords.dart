// ignore_for_file: deprecated_member_use

import 'dart:typed_data';

import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/farm.dart';
import 'package:agricare/screens/farms.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/widgets/tabels/farmstabels.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
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
    return SingleChildScrollView(
      child: ContentDialog(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8, minWidth: 700),
        content: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'KAMBANG CO-OPERATIVE FOOD FARMING AND',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 7,
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
                  const Image(image: AssetImage('assets/images/logo.jpeg')),
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
              ),
            ),
                     
                     SizedBox(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height ,
              child: farms.isNotEmpty
                  ? SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FractionColumnWidth(0.4), // Name
                          1: FractionColumnWidth(0.3), // Location
                          2: FractionColumnWidth(0.3), // Farm Produce
                        },
                        children: [
                          const TableRow(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(225, 116, 101, 204),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Location',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Farm Produce',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              
                            ],
                          ),
                          ...farms.map(
                            (farm) => TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(farm.name),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(farm.location),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(farm.farmproduce),
                                ),
                               
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Center(
                      child: Text('No farms added yet'),
                    ),
            ),
          SizedBox(height: 30,),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: FilledButton(
                    onPressed: () {
                      generatePdf(farms);
                    },
                    child: Text('Print'),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Button(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

 Future<void> generatePdf(List<Farm> farms) async {
  final pdf = pw.Document();
  final img = await rootBundle.load('assets/images/logo.jpg');
    final imageBytes = img.buffer.asUint8List();
    pw.Image logo = pw.Image(pw.MemoryImage(imageBytes));
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return [farmTabels(farms, logo)];
      },
    ),
  );

  await Printing.sharePdf(
    bytes: await pdf.save(),
    filename: 'Kambang-Cooperative-Farm-Records1.pdf',
  );
}
}
