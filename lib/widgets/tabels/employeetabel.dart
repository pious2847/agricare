import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/employee.dart';
import 'package:agricare/models/supervisor.dart';
import 'package:agricare/utils/employee.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/utils/supervisor.dart';
import 'package:flutter/material.dart' as Material;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

const int employeesPerPage = 15;

List<pw.Page> employeesTablePages(List<Employee> employees, image) {
  List<pw.Page> pages = [];

  for (int i = 0; i < employees.length; i += employeesPerPage) {
    final chunk = employees.sublist(
        i,
        i + employeesPerPage > employees.length
            ? employees.length
            : i + employeesPerPage);
    pages.add(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => machineryTable(chunk, image),
      ),
    );
  }

  return pages;
}

pw.Widget machineryTable(List<Employee> employees, image) {
  late final EmployeeCrud _employeeCrud =
      DatabaseHelper.instance.employeeCrudInstance;

  List<Employee> _employees = [];


  return pw.Column(
    children: [
      pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Header(
          child: pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                 'CUDJOE ABIMASH FARMS',
                  style: pw.TextStyle(
                      fontSize: 28,
                      color: PdfColor.fromHex('#89b6ed'),
                      fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 7),
                pw.Text(
                  'COMPANY LIMITED',
                  style: pw.TextStyle(
                      fontSize: 20,
                      color: PdfColor.fromHex('#89b6ed'),
                      fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 15),
                 pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children:[
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('P.O Box 655', style: const pw.TextStyle(fontSize: 10),),
                            pw.Text('Northern Region ', style: const pw.TextStyle(fontSize: 10),),
                            pw.Text('Tamale', style: const pw.TextStyle(fontSize: 10),),
                          ],
                        ),  
                        pw.SizedBox(width: 20,),
                    pw.Container(
                  width: 50.0,
                  height: 50.0,
                  child: pw.Image(pw.MemoryImage(image), height: 100, width: 100),
                ),
                        pw.SizedBox(width: 20,),
                         pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('Email: cudjeoabimash@yahoo.com', style: const pw.TextStyle(fontSize: 10),),
                            pw.SizedBox(height: 8),
                            pw.Text('Phone: +233 24 346 1063 ', style: const pw.TextStyle(fontSize: 10),),
                          ],
                        ),  
                    ]
                  ),
                  
                
                pw.SizedBox(height: 20),
                pw.Text(
                  'EMPLOYEES RECORDS',
                  style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 9),
              ],
            ),
          ),
        ),
      
      ),
      pw.SizedBox(height: 20),
      pw.SizedBox(
        child: pw.Table(
          border: pw.TableBorder.all(),
          children: [
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColor.fromHex('#89b6ed')),
              children: [
                 pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'ID',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#ffffff')),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'Name',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'Contact',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'Assigned Farm',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8),
                  ),
                ),
                  pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'Assigned Machinery',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8),
                  ),
                ),
              ],
            ),
            ...employees.map(
              (employee) => pw.TableRow(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text('${employee.id}', style: pw.TextStyle(fontSize: 8)),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text(employee.name, style: pw.TextStyle(fontSize: 8)),
                  ),
                                    pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text(employee.contact, style: pw.TextStyle(fontSize: 8)),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text('${employee.farmAssigned}', style: pw.TextStyle(fontSize: 8)),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text('${employee.machineryAssigned}', style: pw.TextStyle(fontSize: 8)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
