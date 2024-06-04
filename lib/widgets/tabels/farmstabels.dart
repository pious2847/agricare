import 'package:agricare/models/farm.dart';
import 'package:agricare/screens/farms.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

farmTabels(farms) => pw.Padding(
    padding: const pw.EdgeInsets.all(10.0),
    child: pw.Column(
      children: [
        pw.Container(
          alignment: pw.Alignment.center,
          child: pw.Header(
            child: pw.Text('Farm Records',
                style: pw.TextStyle(font: pw.Font.helvetica())),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
          ),
        ),
        pw.SizedBox(height: 20),
        pw.Table.fromTextArray(
          border: null,
          cellAlignment: pw.Alignment.centerLeft,
          headerDecoration: pw.BoxDecoration(
            border: pw.Border.all(),
            color: PdfColors.grey300,
          ),
          headerHeight: 25,
          cellHeight: 30,
          cellAlignments: {
            0: pw.Alignment.centerLeft,
            1: pw.Alignment.centerLeft,
            2: pw.Alignment.centerLeft,
            3: pw.Alignment.center,
          },
          headers: ['Name', 'Location', 'Farm Produce', 'Actions'],
          data: farms.map(
                (farm) => [
                  farm.name,
                  farm.location,
                  farm.farmproduce,
                  '', // Empty cell for actions
                ],
              )
        ),
      ],
    ));
