// ignore_for_file: deprecated_member_use

import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/farm.dart';
import 'package:agricare/models/supplies.dart';
import 'package:agricare/utils/supplies.dart';
import 'package:agricare/widgets/tabels/suppliestabel.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GenerateSuppliesPdf extends StatefulWidget {
  const GenerateSuppliesPdf({super.key});

  @override
  State<GenerateSuppliesPdf> createState() => _GenerateSuppliesPdfState();
}

class _GenerateSuppliesPdfState extends State<GenerateSuppliesPdf> {
  late final SuppliesCrud _suppliesCrud = DatabaseHelper.instance.suppliesCrudInstance;
  List<Farm> farms = [];
  List<Supplies> supplies = [];

  @override
  void initState() {
    loadSupplies();
    super.initState();
  }

  Future<void> loadSupplies() async {
    supplies = await _suppliesCrud.getSupplies();
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
                    'CUDJOE ABIMASH FARMS',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    'COMPANY LIMITED',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('P.O Box 655', style: TextStyle(fontSize: 15),),
                            Text('Northern Region ', style: TextStyle(fontSize: 15),),
                            Text('Tamale', style: TextStyle(fontSize: 15),),
                          ],
                        ),  
                        SizedBox(width: 20,),
                    Image(image: AssetImage('assets/images/logo.jpeg')),
                        SizedBox(width: 20,),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email: cudjeoabimash@yahoo.com', style: TextStyle(fontSize: 15),),
                            Text('Phone: +233 24 346 1063 ', style: TextStyle(fontSize: 15),),
                          ],
                        ),  
                    ]
                  ),
                  
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'SUPPLIES RECORDS',
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
              child: supplies.isNotEmpty
                  ? SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FractionColumnWidth(0.2), // ID
                          1: FractionColumnWidth(0.4), // Product
                          2: FractionColumnWidth(0.4), // Stock
                        },
                        children: [
                          const TableRow(
                            decoration: BoxDecoration(
                            color: Color.fromARGB(213, 21, 131, 196),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'ID',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'PRODUCT',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'STOCK',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ...supplies.map(
                            (supply) => TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${supply.id}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(supply.product),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${supply.stock}'),
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
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: FilledButton(
                    onPressed: () {
                      GenerateSuppliesPdf(supplies);
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

 Future<void> GenerateSuppliesPdf(List<Supplies> supplies) async {
    final pdf = pw.Document();
    final ByteData img = await rootBundle.load('assets/images/logo.jpeg');
    final logo = img.buffer.asUint8List();

    final pages = SupplyTablePages(supplies, logo);
    for (var page in pages) {
      pdf.addPage(page);
    }

  // Get the current date and time
  final now = DateTime.now();
  // Format the date and time manually
  final formattedDate = '${now.year}_${_twoDigits(now.month)}_${_twoDigits(now.day)}_${_twoDigits(now.hour)}-${_twoDigits(now.minute)}';
  // Create the filename with the formatted date and time
  final filename = 'Kambang_Cooperative_Supplies_Records_$formattedDate.pdf';

  
  await Printing.sharePdf(
    bytes: await pdf.save(),
    filename: filename,
  );
  }
  String _twoDigits(int n) {
  return n.toString().padLeft(2, '0');
}
}
