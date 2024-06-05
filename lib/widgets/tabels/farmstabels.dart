import 'package:agricare/models/farm.dart';
import 'package:agricare/screens/farms.dart';
import 'package:fluent_ui/fluent_ui.dart';
// import 'package:fluent_ui/fluent_ui.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

const int farmsPerPage = 15;


List<pw.Page> farmTablePages(List<Farm> farms,  image) {
  List<pw.Page> pages = [];

  for (int i = 0; i < farms.length; i += farmsPerPage) {
    final chunk = farms.sublist(i, i + farmsPerPage > farms.length ? farms.length : i + farmsPerPage);
    pages.add(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => farmTable(chunk, image),
      ),
    );
  }

  return pages;
}


pw.Widget farmTable(List<Farm> farms,  image) {
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
                    'Name',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'Location',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'Farm Produce',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ],
            ),
            ...farms.map(
              (farm) => pw.TableRow(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text(farm.name),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text(farm.location),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text(farm.farmproduce),
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