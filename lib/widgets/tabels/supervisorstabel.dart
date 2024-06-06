import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/supervisor.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/utils/supervisor.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

const int supervisorsPerPage = 15;

List<pw.Page> supervisorsTablePages(List<Supervisor> supervisors, image) {
  List<pw.Page> pages = [];

  for (int i = 0; i < supervisors.length; i += supervisorsPerPage) {
    final chunk = supervisors.sublist(
        i,
        i + supervisorsPerPage > supervisors.length
            ? supervisors.length
            : i + supervisorsPerPage);
    pages.add(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => machineryTable(chunk, image),
      ),
    );
  }

  return pages;
}

pw.Widget machineryTable(List<Supervisor> supervisors, image) {
  late final SupervisorCrud _supervisorCrud =
      DatabaseHelper.instance.supervisorCrudInstance;
  late final FarmCrud _farmsCrud = DatabaseHelper.instance.farmCrudInstance;

  List<Supervisor> _supervisors = [];

  Future<String> _getFarmName(int? id) async {
    final farm = await _farmsCrud.getFarmById(id!);
    return farm.isNotEmpty ? farm.first.name : 'Unknown Farm';
  }

  return pw.Column(
    children: [
      pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Header(
          child: pw.SizedBox(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'KAMBANG CO-OPERATIVE FOOD FARMING AND',
                  style: pw.TextStyle(
                      fontSize: 19,
                      color: PdfColor.fromHex('#89b6ed'),
                      fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 7),
                pw.Text(
                  'MARKETING SOCIETY LIMITED',
                  style: pw.TextStyle(
                      fontSize: 16,
                      color: PdfColor.fromHex('#89b6ed'),
                      fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 15),
                pw.Container(
                  width: 50.0,
                  height: 50.0,
                  child: pw.Image(pw.MemoryImage(image)),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'MACHINERY RECORDS',
                  style: pw.TextStyle(
                    fontSize: 14,
                  ),
                ),
                pw.SizedBox(height: 20),
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
                    'Name',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'Contact',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'Assigned Farm',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ],
            ),
            ...supervisors.map(
              (supervisor) => pw.TableRow(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text('${supervisor.id}'),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text(supervisor.name),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text(supervisor.contact),
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
