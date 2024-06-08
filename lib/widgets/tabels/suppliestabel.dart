import 'package:agricare/models/supplies.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

const int suppliesPerPage = 15;


List<pw.Page> SupplyTablePages(List<Supplies> supplies,  image) {
  List<pw.Page> pages = [];

  for (int i = 0; i < supplies.length; i += suppliesPerPage) {
    final chunk = supplies.sublist(i, i + suppliesPerPage > supplies.length ? supplies.length : i + suppliesPerPage);
    pages.add(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => supplyTable(chunk, image),
      ),
    );
  }

  return pages;
}


pw.Widget supplyTable(List<Supplies> supplies,  image) {
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
                            pw.Text('Phone: +233 24 346 1063 ', style: const pw.TextStyle(fontSize: 10),),
                          ],
                        ),  
                    ]
                  ),  
                pw.SizedBox(height: 20),
                pw.Text(
                  'SUPPLIES RECORDS',
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
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'Product',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'Stock',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ],
            ),
            ...supplies.map(
              (supply) => pw.TableRow(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text('${supply.id}'),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text(supply.product),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(8.0),
                    child: pw.Text('${supply.stock}'),
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