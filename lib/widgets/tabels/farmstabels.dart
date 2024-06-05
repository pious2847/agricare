import 'package:agricare/models/farm.dart';
import 'package:agricare/screens/farms.dart';
import 'package:fluent_ui/fluent_ui.dart';
// import 'package:fluent_ui/fluent_ui.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

farmTabels(List<Farm> farms, image) =>  pw.Column(
      children: [
        pw.Container(
          alignment: pw.Alignment.center,
          child: pw.Header(
            child: pw.SizedBox(
              // width: pw.MediaQuery.of(context).size.width * 0.6,
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                   pw.SizedBox(
                    height: 25,
                  ),
                  pw.Text(
                    'KAMBANG CO-OPERATIVE FOOD FARMING AND',
                    style: pw.TextStyle(
                        fontSize: 30,
                        color: PdfColor.fromHex('#89b6ed'),
                        fontWeight: pw.FontWeight.bold),
                  ),
                   pw.SizedBox(
                    height: 7,
                  ),
                  pw.Text(
                    'MARKETING SOCIETY LIMITED',
                    style: pw.TextStyle(
                        fontSize: 20,
                        color: PdfColor.fromHex('#89b6ed'),
                        fontWeight: pw.FontWeight.bold),
                  ),
                   pw.SizedBox(
                    height: 15,
                  ),
                  pw.Container(
   alignment: pw.Alignment.center,
   height: 200,
   child: image,
),
                   pw.SizedBox(
                    height: 20,
                  ),
                  pw.Text(
                    'FARM RECORDS',
                    style: pw.TextStyle(
                        fontSize: 14,
                        color: PdfColor.fromHex('#89b6ed'),
                        fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(
                    height: 20,
                  ),
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
              decoration: pw.BoxDecoration(),
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'Name',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'Location',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    'Name',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            ...farms.map(
              (farm) => pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text(farm.name),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text(farm.location),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
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
