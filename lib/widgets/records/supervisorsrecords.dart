// ignore_for_file: deprecated_member_use

import 'dart:typed_data';

import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/forms/supervisor.dart';
import 'package:agricare/models/farm.dart';
import 'package:agricare/models/machinery.dart';
import 'package:agricare/models/supervisor.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/utils/machinery.dart';
import 'package:agricare/utils/supervisor.dart';
import 'package:agricare/widgets/tabels/machinerytabels.dart';
import 'package:agricare/widgets/tabels/supervisorstabel.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart' as Material;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GenerateSupervisorsPdf extends StatefulWidget {
  const GenerateSupervisorsPdf({super.key});

  @override
  State<GenerateSupervisorsPdf> createState() => _GenerateSupervisorsPdfState();
}

class _GenerateSupervisorsPdfState extends State<GenerateSupervisorsPdf> {
late final SupervisorCrud _supervisorCrud =
      DatabaseHelper.instance.supervisorCrudInstance;
  late final FarmCrud _farmsCrud = DatabaseHelper.instance.farmCrudInstance;

  List<Supervisor> _supervisors = [];

  @override
  void initState() {
    loadSupervisors();
    super.initState();
  }

  Future<void> loadSupervisors() async {
    _supervisors = await _supervisorCrud.getSupervisors();
    setState(() {});
  }

  void _deleteSupervisor(int id) async {
    await _supervisorCrud.deleteSupervisor(id);
    loadSupervisors();
  }

  Future<String> _getFarmName(int? id) async {
    final farm = await _farmsCrud.getFarmById(id!);
    return farm.isNotEmpty ? farm.first.name : 'Unknown Farm';
  }

  void _editSupervisor(Supervisor supervisor) {
    showDialog(
      context: context,
      builder: (context) => SupervisorModal(supervisor: supervisor),
    ).then((value) => loadSupervisors());
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
                    'SUPERVISORS RECORDS',
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
            child: _supervisors.isNotEmpty
                ? SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: const {
                        0: FractionColumnWidth(0.3), // Name
                        1: FractionColumnWidth(0.2), // Contact
                        2: FractionColumnWidth(0.2), // Assigned Farm
                        3: FractionColumnWidth(0.2), // Notes
                        4: FractionColumnWidth(0.1), // Action
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
                                'Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Contact',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Assigned Farm',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Notes',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                           
                          ],
                        ),
                        ..._supervisors.map(
                          (supervisor) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(supervisor.name),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(supervisor.contact),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FutureBuilder<String>(
                                  future: _getFarmName(supervisor.farmsAssigned),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Material.CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return const Text('Error');
                                    } else {
                                      return Text(snapshot.data ?? 'Unknown Farm');
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(supervisor.notes),
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
                      generateSupervisorsPdf(_supervisors);
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

 Future<void> generateSupervisorsPdf(List<Supervisor> supervisors) async {
    final pdf = pw.Document();
    final ByteData img = await rootBundle.load('assets/images/logo.jpeg');
    final logo = img.buffer.asUint8List();

    final pages = supervisorsTablePages(supervisors, logo);
    for (var page in pages) {
      pdf.addPage(page);
    }
  // Get the current date and time
  final now = DateTime.now();
  // Format the date and time manually
  final formattedDate = '${now.year}_${_twoDigits(now.month)}_${_twoDigits(now.day)}_${_twoDigits(now.hour)}-${_twoDigits(now.minute)}';
  // Create the filename with the formatted date and time
  final filename = 'Kambang_Cooperative_Farm_Records_$formattedDate.pdf';


  await Printing.sharePdf(
    bytes: await pdf.save(),
    filename: filename,
  );
  }
  String _twoDigits(int n) {
  return n.toString().padLeft(2, '0');
  }


}

