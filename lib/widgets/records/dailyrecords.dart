// ignore_for_file: deprecated_member_use

import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/daily_work_record.dart';
import 'package:agricare/utils/daily_work_records.dart';
import 'package:agricare/widgets/tabels/dailyrecordstabel.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GenerateDailyRecordsPdf extends StatefulWidget {
  const GenerateDailyRecordsPdf({super.key});

  @override
  State<GenerateDailyRecordsPdf> createState() =>
      _GenerateDailyRecordsPdfState();
}

class _GenerateDailyRecordsPdfState extends State<GenerateDailyRecordsPdf> {
  late final DailyCrud _dailyrecordsCrud =
      DatabaseHelper.instance.dailyCrudInstance;

  List<DailyWorkRecord> _dailyrecords = [];
  late int _totalexpenditure;

  @override
  void initState() {
    loadrecords();
    super.initState();
  }

  Future<void> loadrecords() async {
    _dailyrecords = await _dailyrecordsCrud.getDailyRecords();
    _totalexpenditure = await _dailyrecordsCrud.getTotalDailyExpenses();
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
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'P.O Box 655',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              'Northern Region ',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              'Tamale',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Image(image: AssetImage('assets/images/logo.jpeg')),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email: cudjeoabimash@yahoo.com',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              'Phone: +233 24 346 1063 ',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ]),
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
              child: _dailyrecords.isNotEmpty
                  ? SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FractionColumnWidth(0.1), // worktype
                          1: FlexColumnWidth(), // EmployeeName
                          2: FractionColumnWidth(0.2), // farm
                          3: FractionColumnWidth(0.2), // suppliesUsed
                          4: FractionColumnWidth(0.2), // suppliesLeft
                          5: FractionColumnWidth(0.08), // dailyexpenses
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
                                  'Work Type',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Done By',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Farm',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Supplies Used',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Remaining Supplies',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Daily Expenses',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                             
                            ],
                          ),
                          ..._dailyrecords.map(
                            (records) => TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(records.worktype),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(records.employeeName),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(records.farm),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(records.suppliesUsed),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(records.suppliesLeft),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${records.dailyexpenses}'),
                                ),
                              ],
                            ),
                          ),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(''),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(''),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(''),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(''),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Total Expenditure',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${_totalexpenditure}',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ]),
                        
                        ],
                      ),
                    )
                  : const Center(
                      child: Text('No record added yet'),
                    ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: FilledButton(
                    onPressed: () {
                      GenerateDailyRecordsPdf(_dailyrecords, _totalexpenditure);
                    },
                    child: const Text('Print'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Button(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> GenerateDailyRecordsPdf(
      List<DailyWorkRecord> dailyworkrecords, int totalexpenditure) async {
    final pdf = pw.Document();
    final ByteData img = await rootBundle.load('assets/images/logo.jpeg');
    final logo = img.buffer.asUint8List();

    final pages = DailyRecordsTablePages(dailyworkrecords, logo, _totalexpenditure);
    for (var page in pages) {
      pdf.addPage(page);
    }

    // Get the current date and time
    final now = DateTime.now();
    // Format the date and time manually
    final formattedDate =
        '${now.year}_${_twoDigits(now.month)}_${_twoDigits(now.day)}_${_twoDigits(now.hour)}-${_twoDigits(now.minute)}';
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
