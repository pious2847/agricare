// ignore_for_file: deprecated_member_use

import 'dart:typed_data';

import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/forms/employee.dart';
import 'package:agricare/forms/supervisor.dart';
import 'package:agricare/models/employee.dart';
import 'package:agricare/models/farm.dart';
import 'package:agricare/models/machinery.dart';
import 'package:agricare/models/supervisor.dart';
import 'package:agricare/utils/employee.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/utils/machinery.dart';
import 'package:agricare/utils/supervisor.dart';
import 'package:agricare/widgets/tabels/employeetabel.dart';
import 'package:agricare/widgets/tabels/machinerytabels.dart';
import 'package:agricare/widgets/tabels/supervisorstabel.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart' as Material;
import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GenerateEmployeesPdf extends StatefulWidget {
  const GenerateEmployeesPdf({super.key});

  @override
  State<GenerateEmployeesPdf> createState() => _GenerateEmployeesPdfState();
}

class _GenerateEmployeesPdfState extends State<GenerateEmployeesPdf> {
late final EmployeeCrud _employeeCrud =
      DatabaseHelper.instance.employeeCrudInstance;
  late final FarmCrud _farmsCrud = DatabaseHelper.instance.farmCrudInstance;

  List<Employee> _employees = [];

  @override
  void initState() {
    loadSupervisors();
    super.initState();
  }

  Future<void> loadSupervisors() async {
    _employees = await _employeeCrud.getEmployees();
    setState(() {});
  }

  void _deleteSupervisor(int id) async {
    await _employeeCrud.deleteEmployee(id);
    loadSupervisors();
  }


  void _editSupervisor(Employee employee) {
    showDialog(
      context: context,
      builder: (context) => EmployeeModal(employee: employee),
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
                            SizedBox(height: 8),
                            Text('Northern Region ', style: TextStyle(fontSize: 15),),
                            SizedBox(height: 8),
                            Text('Tamale', style: TextStyle(fontSize: 15),),
                          ],
                        ),  
                        SizedBox(width: 20,),
                    Image(image: AssetImage('assets/images/logo.jpeg')),
                        SizedBox(width: 20,),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Email: example12"gmail.com', style: TextStyle(fontSize: 15),),
                            SizedBox(height: 8),
                            Text('Phone: +233 24xxxxxxx ', style: TextStyle(fontSize: 15),),
                          ],
                        ),  
                    ]
                  ),
                  
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'SUPERVISOR RECORDS',
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
            child: _employees.isNotEmpty
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
                                'Machinery Assigned',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                           
                          ],
                        ),
                        ..._employees.map(
                          (employee) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(employee.name),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(employee.contact),
                              ),
                               Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${employee.farmAssigned}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(employee.machineryAssigned),
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
                      GenerateEmployeesPdf(_employees);
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

 Future<void> GenerateEmployeesPdf(List<Employee> employees) async {
    final pdf = pw.Document();
    final ByteData img = await rootBundle.load('assets/images/logo.jpeg');
    final logo = img.buffer.asUint8List();

    final pages = employeesTablePages(employees, logo);
    for (var page in pages) {
      pdf.addPage(page);
    }
  // Get the current date and time
  final now = DateTime.now();
  // Format the date and time manually
  final formattedDate = '${now.year}_${_twoDigits(now.month)}_${_twoDigits(now.day)}_${_twoDigits(now.hour)}-${_twoDigits(now.minute)}';
  // Create the filename with the formatted date and time
  final filename = 'Kambang_Cooperative_employees_Records_$formattedDate.pdf';


  await Printing.sharePdf(
    bytes: await pdf.save(),
    filename: filename,
  );
  }
  String _twoDigits(int n) {
  return n.toString().padLeft(2, '0');
  }


}

