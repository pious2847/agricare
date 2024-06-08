import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/forms/daily_works.dart';
import 'package:agricare/models/daily_work_record.dart';
import 'package:agricare/utils/daily_work_records.dart';
import 'package:agricare/widgets/records/dailyrecords.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DailyWorkRecordsScreen extends StatefulWidget {
  const DailyWorkRecordsScreen({super.key});

  @override
  State<DailyWorkRecordsScreen> createState() => _DailyWorkRecordsScreenState();
}

class _DailyWorkRecordsScreenState extends State<DailyWorkRecordsScreen> {
  late final DailyCrud _dailyrecordsCrud =
      DatabaseHelper.instance.dailyCrudInstance;

  List<DailyWorkRecord> _dailyrecords = [];

  @override
  void initState() {
    loadrecords();
    super.initState();
  }

  Future<void> loadrecords() async {
    _dailyrecords = await _dailyrecordsCrud.getDailyRecords();
    setState(() {});
  }

  void _deletedailyrecords(int id) async {
    await _dailyrecordsCrud.deleteDailyRecords(id);
    loadrecords();
  }

  void _editDailyRecord(DailyWorkRecord dailyrecords) {
    showDialog(
      context: context,
      builder: (context) => DailyRecordsModal(dailyrecords: dailyrecords),
    ).then((value) => loadrecords());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Button(
                  child: const Text('Add Daily Records'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const DailyRecordsModal(),
                    ).then((value) => loadrecords());
                  },
                ),
                Button(
                  child: const Text('Print Preview'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const GenerateDailyRecordsPdf(),
                    ).then((value) => loadrecords());
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: _dailyrecords.isNotEmpty
                ? SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: const {
                        0: FractionColumnWidth(0.05), // ID
                        1: FractionColumnWidth(0.1), // worktype
                        2: FractionColumnWidth(0.08), // farm
                        3: FractionColumnWidth(0.1), // suppliesUsed
                        4: FractionColumnWidth(0.2), // suppliesLeft
                        5: FractionColumnWidth(0.08), // dailyexpenses
                        6: FlexColumnWidth(), // notes
                        7: FractionColumnWidth(0.1), // Actions
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
                             Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Note',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Actions',
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
                                child: Text('${records.id}'),
                              ),
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(records.notes),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Tooltip(
                                      message: 'Edit',
                                      displayHorizontally: true,
                                      useMousePosition: false,
                                      child: IconButton(
                                        icon: const Icon(Iconsax.edit_2_copy),
                                        onPressed: () =>
                                            _editDailyRecord(records),
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Delete',
                                      displayHorizontally: true,
                                      useMousePosition: false,
                                      child: IconButton(
                                        icon: const Icon(Iconsax.trash_copy),
                                        onPressed: () => showContentDialog(
                                            context, records.id!),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: Text('No record added yet'),
                  ),
          ),
        
        ],
      ),
    );
  }

  void showContentDialog(BuildContext context, int id) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Delete permanently?'),
        content: const Text(
          'If you delete this file, you won\'t be able to recover it. Do you want to delete it?',
        ),
        actions: [
          Button(
            child: const Text('Delete'),
            onPressed: () {
              _deletedailyrecords(id);
              Navigator.pop(
                context,
              );
              // Delete file here
            },
          ),
          FilledButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
        ],
      ),
    );
    setState(() {});
  }

}
