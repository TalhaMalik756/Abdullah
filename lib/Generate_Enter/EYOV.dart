import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import '../SuitableBest/SuitableBest.dart';
import 'package:soilmate/Generate_Enter/GenerateRepo.dart';

class EYOV extends StatelessWidget {
  late Uint8List _logoImageBytes; // No initialization here

  EYOV({Key? key}) : super(key: key); // Non-const constructor

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Your Own Values'),
        backgroundColor: Color(0xFFECFFDC),
      ),
      backgroundColor: Color(0xFFECFFDC),
      body: Stack(
        children: [
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.82,
            padding: EdgeInsets.all(8),
            children: [
              buildCell('assets/Icons/Temperature.png', 'Temperature', _controllers[0]),
              buildCell('assets/Icons/PH.png', 'PH', _controllers[1]),
              buildCell('assets/Icons/Voltage.png', 'Electrical', _controllers[2]),
              buildCell('assets/Icons/Potassium.png', 'Potassium', _controllers[3]),
              buildCell('assets/Icons/Nitrogen.png', 'Nitrogen', _controllers[4]),
              buildCell('assets/Icons/Phosphorus.png', 'Phosphorus', _controllers[5]),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Collect user-entered data
                    List<String> userValues = _controllers.map((controller) => controller.text).toList();
                    // Generate PDF and show snackbar
                    await generatePDFAndShowSnackbar(context, userValues);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF006400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Text(
                      'Generate Report',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 80),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SuitableBest()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF006400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21, vertical: 0),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCell(String imagePath, String title, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFF4F7942),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 120,
          ),
          SizedBox(height: 0),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 7),
          TextField(
            controller: controller,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: 'Enter your value here',
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> generatePDFAndShowSnackbar(BuildContext context, List<String> userValues) async {
    // Pre-load assets before building the PDF document
    await loadAssets();

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
                _buildDataTable(userValues),
              ],
            ),
          );
        },
      ),
    );

    // Save the PDF document to the downloads directory
    final pdfPath = await savePDF(pdf);

    // Show snackbar with PDF location and open button
    showSnackbarWithPDF(context, pdfPath);
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Row(
      children: [
        pw.Image(
          pw.MemoryImage(_logoImageBytes),
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

  pw.Widget _buildDataTable(List<String> userValues) {
    // Define table headers
    final headers = ['Title', 'User Entered Values'];

    // Define table rows
    final List<List<String>> rows = [
      ['Temperature', userValues[0]], // Directly access the values by index
      ['PH', userValues[1]],
      ['Electrical', userValues[2]],
      ['Potassium', userValues[3]],
      ['Nitrogen', userValues[4]],
      ['Phosphorus', userValues[5]],
    ];

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

  Future<String> savePDF(pw.Document pdf) async {
    final downloadsDirectory = await getExternalStorageDirectory();
    final pdfPath = '${downloadsDirectory!.path}/generated_report.pdf';

    final file = File(pdfPath);
    await file.writeAsBytes(await pdf.save());

    return pdfPath;
  }

  void showSnackbarWithPDF(BuildContext context, String pdfPath) {
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
    _logoImageBytes = byteData.buffer.asUint8List();
  }
}
