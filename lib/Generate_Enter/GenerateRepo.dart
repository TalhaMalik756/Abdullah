import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

class GenerateRepo extends StatelessWidget {
  final List<String> userValues;
  late final Uint8List logoImageBytes;

  GenerateRepo({Key? key, required this.userValues}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Report'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Press the button to generate PDF!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await generatePDF(context);
              },
              child: Text('Generate PDF'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> generatePDF(BuildContext context) async {
    // Fetch data from database
    List<List<String>> databaseRows = await fetchDataFromDatabase();

    // Create PDF document
    final pdf = pw.Document();

    // Add page to the PDF document
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            padding: pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                pw.SizedBox(height: 20),
                _buildSoilReportText(),
                pw.SizedBox(height: 20),
                _buildDataTable(databaseRows),
              ],
            ),
          );
        },
      ),
    );

    // Save the PDF document to the downloads directory
    await savePDF(pdf, context);
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Row(
      children: [
        pw.Image(
          pw.MemoryImage(logoImageBytes),
          height: 50,
          width: 50,
        ),
        pw.SizedBox(width: 10),
        pw.Text(
          'Soil Mate',
          style: pw.TextStyle(
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildSoilReportText() {
    return pw.Container(
      alignment: pw.Alignment.center,
      child: pw.Text(
        'Soil Report',
        style: pw.TextStyle(
          fontSize: 20,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  pw.Widget _buildDataTable(List<List<String>> databaseRows) {
    // Define table headers
    final headers = ['Title', 'Database Values'];

    // Combine userValues with databaseRows
    List<List<String>> rows = [];
    for (int i = 0; i < userValues.length; i++) {
      rows.add([userValues[i], databaseRows[i][0]]); // Assuming databaseRows is a list of lists with one value per row
    }

    // Create table
    final table = pw.Table.fromTextArray(
      headers: headers,
      cellAlignment: pw.Alignment.center,
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        color: PdfColor.fromInt(0xFFFFFFFF), // Set font color to white
      ),
      cellStyle: pw.TextStyle(),
      border: pw.TableBorder.all(),
      headerDecoration: pw.BoxDecoration(
        color: PdfColor.fromInt(0xFF006400), // Change color here
      ),
      data: rows,
      defaultColumnWidth: pw.FlexColumnWidth(), // Let the columns fill remaining space
    );

    return table;
  }

  Future<List<List<String>>> fetchDataFromDatabase() async {
    // Implement logic to fetch data from your MySQL database here
    // Example:
    // final results = await database.query('SELECT * FROM your_table');
    // return results.map((row) => [row['value1'], row['value2']]).toList();
    // Replace 'your_table', 'value1', 'value2' with your actual table name and column names

    // For now, return a dummy list
    return List.generate(6, (index) => ['DatabaseValue${index + 1}']);
  }

  Future<void> savePDF(pw.Document pdf, BuildContext context) async {
    // Pre-load assets before building the PDF document
    await loadAssets();

    final downloadsDirectory = await getExternalStorageDirectory();
    final pdfPath = '${downloadsDirectory!.path}/generated_report.pdf';

    final file = File(pdfPath);
    await file.writeAsBytes(await pdf.save());

    // Use ScaffoldMessenger to show the snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF saved successfully at: $pdfPath'),
        action: SnackBarAction(
          label: 'Open',
          onPressed: () {
            OpenFile.open(pdfPath);
          },
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    final byteData = await rootBundle.load('assets/Logo.png');
    logoImageBytes = byteData.buffer.asUint8List();
  }
}
