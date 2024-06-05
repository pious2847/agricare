import 'package:agricare/models/machinery.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

const int machineryPerPage = 15;


List<pw.Page> machineryTablePages(List<Machinery> machinerys,  image) {
  List<pw.Page> pages = [];

  for (int i = 0; i < machinerys.length; i += machineryPerPage) {
    final chunk = machinerys.sublist(i, i + machineryPerPage > machinerys.length ? machinerys.length : i + machineryPerPage);
    pages.add(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => machineryTable(chunk, image),
      ),
    );
  }

  return pages;
}


pw.Widget machineryTable(List<Machinery> machinerys,  image) {
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
                  'FARM RECORDS',
                  style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
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
                    'ID',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
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
                    'Tag Number',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ],
            ),
            ...machinerys.map(
              (machinery) => pw.TableRow(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text('${machinery.id}'),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text(machinery.name),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text(machinery.tagNumber),
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