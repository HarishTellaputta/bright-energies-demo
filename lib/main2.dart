import 'dart:typed_data';

import 'package:excel/excel.dart' as ex;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const BrightEnergiesApp());
}

class BrightEnergiesApp extends StatelessWidget {
  const BrightEnergiesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bright Energies Quotation',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: const QuotationScreen(),
    );
  }
}

class QuotationScreen extends StatefulWidget {
  const QuotationScreen({super.key});

  @override
  State<QuotationScreen> createState() => _QuotationScreenState();
}

class _QuotationScreenState extends State<QuotationScreen> {
  final customerNameController = TextEditingController();
  final mobileController = TextEditingController();
  final locationController = TextEditingController();
  final capacityController = TextEditingController();

  Uint8List? excelBytes;

  String selectedFileName = '';

  String quotationNo = 'QUO-001';
  String quotationDate = 'DD-MM-YYYY';

  bool loading = false;

  @override
  void dispose() {
    customerNameController.dispose();
    mobileController.dispose();
    locationController.dispose();
    capacityController.dispose();

    super.dispose();
  }

  // ============================================================
  // SELECT EXCEL FILE
  // ============================================================

  Future<void> selectExcelFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
        withData: true,
      );

      if (result == null) {
        return;
      }

      final file = result.files.single;

      if (file.bytes == null) {
        showMessage('Excel file could not be loaded.');
        return;
      }

      setState(() {
        excelBytes = file.bytes;
        selectedFileName = file.name;
      });

      readExcel(file.bytes!);

      showMessage('Excel file loaded successfully.');
    } catch (e) {
      showMessage('Error loading Excel: $e');
    }
  }

  // ============================================================
  // READ EXCEL
  // ============================================================

  void readExcel(Uint8List bytes) {
    try {
      final ex.Excel excel = ex.Excel.decodeBytes(bytes);

      for (final String sheetName in excel.tables.keys) {
        final ex.Sheet? sheet = excel.tables[sheetName];

        if (sheet == null) {
          continue;
        }

        debugPrint('==============================');

        debugPrint('Sheet: $sheetName');

        debugPrint('==============================');

        for (final row in sheet.rows) {
          final values = row.map((cell) {
            return cell?.value?.toString() ?? '';
          }).toList();

          debugPrint(values.toString());
        }
      }
    } catch (e) {
      debugPrint('Excel read error: $e');
    }
  }

  // ============================================================
  // GENERATE PDF
  // ============================================================
  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,

        // IMPORTANT:
        // Flutter EdgeInsets kaadu.
        // PDF package EdgeInsets use cheyyali.
        margin: pw.EdgeInsets.zero,

        build: (context) {
          return pw.Container(
            width: double.infinity,
            height: double.infinity,

            // ============================================
            // COMPLETE A4 PAGE BORDER
            // ============================================
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black, width: 1.5),
            ),

            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                // ============================================
                // TOP YELLOW COMPANY HEADER
                // ============================================

                pw.Container(
                  width: double.infinity,
                  color: PdfColors.yellow,

                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,

                    children: [
                      // Top yellow space
                      pw.SizedBox(height: 18),

                      // Company Name
                      pw.Text(
                        'BRIGHT ENERGIES SOLUTIONS',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 23,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                        ),
                      ),

                      pw.SizedBox(height: 5),

                      // Subtitle
                      pw.Text(
                        'Solar Energy Solutions',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                        ),
                      ),

                      // Bottom yellow space
                      pw.SizedBox(height: 18),
                    ],
                  ),
                ),

                // ============================================
                // BLACK LINE IMMEDIATELY BELOW YELLOW
                // ============================================
                pw.Container(
                  width: double.infinity,
                  height: 1.5,
                  color: PdfColors.black,
                ),

                // ============================================
                // WHITE CONTENT AREA
                // ============================================
                pw.Expanded(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(15),

                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.stretch,

                      children: [
                        // ======================================
                        // COMPANY CONTACT DETAILS
                        // ======================================

                        pw.Text(
                          'Address: Khammam, Telangana',
                          style: const pw.TextStyle(fontSize: 10),
                        ),

                        pw.SizedBox(height: 3),

                        pw.Text(
                          'Phone: +91 XXXXX XXXXX',
                          style: const pw.TextStyle(fontSize: 10),
                        ),

                        pw.SizedBox(height: 3),

                        pw.Text(
                          'Email: info@brightenergies.in',
                          style: const pw.TextStyle(fontSize: 10),
                        ),

                        pw.SizedBox(height: 12),

                        // ======================================
                        // HORIZONTAL LINE
                        // ======================================
                        pw.Container(
                          width: double.infinity,
                          height: 1,
                          color: PdfColors.black,
                        ),

                        pw.SizedBox(height: 10),

                        // ======================================
                        // QUOTATION HEADER
                        // ======================================
                        pw.Container(
                          padding: const pw.EdgeInsets.all(10),

                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                              color: PdfColors.black,
                              width: 1,
                            ),
                          ),

                          child: pw.Column(
                            children: [
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,

                                children: [
                                  pw.Text(
                                    'QUOTATION',
                                    style: pw.TextStyle(
                                      fontSize: 18,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),

                                  pw.Text(
                                    'Quotation No: $quotationNo',
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),

                              pw.SizedBox(height: 5),

                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,

                                children: [
                                  pw.Text(''),

                                  pw.Text(
                                    'Date: $quotationDate',
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        pw.SizedBox(height: 18),

                        // ======================================
                        // CUSTOMER DETAILS
                        // ======================================
                        pw.Text(
                          'CUSTOMER DETAILS',
                          style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),

                        pw.SizedBox(height: 8),

                        buildDetailsTable([
                          ['Customer Name', customerNameController.text],
                          ['Mobile Number', mobileController.text],
                          ['Location', locationController.text],
                        ]),

                        pw.SizedBox(height: 18),

                        // ======================================
                        // SYSTEM DETAILS
                        // ======================================
                        pw.Text(
                          'SYSTEM DETAILS',
                          style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),

                        pw.SizedBox(height: 8),

                        buildDetailsTable([
                          ['Solar System Capacity', capacityController.text],
                        ]),

                        pw.SizedBox(height: 20),

                        // ======================================
                        // TERMS & CONDITIONS
                        // ======================================
                        pw.Text(
                          'TERMS & CONDITIONS',
                          style: pw.TextStyle(
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),

                        pw.SizedBox(height: 8),

                        pw.Text(
                          '1. Prices are subject to change based on final requirements.',
                          style: const pw.TextStyle(fontSize: 9),
                        ),

                        pw.SizedBox(height: 5),

                        pw.Text(
                          '2. Installation will be completed as per the agreed schedule.',
                          style: const pw.TextStyle(fontSize: 9),
                        ),

                        pw.SizedBox(height: 5),

                        pw.Text(
                          '3. Customer shall provide required installation space and electrical access.',
                          style: const pw.TextStyle(fontSize: 9),
                        ),

                        pw.SizedBox(height: 5),

                        pw.Text(
                          '4. Warranty will be provided as per manufacturer terms.',
                          style: const pw.TextStyle(fontSize: 9),
                        ),

                        pw.SizedBox(height: 5),

                        pw.Text(
                          '5. Payment terms will be mutually agreed upon.',
                          style: const pw.TextStyle(fontSize: 9),
                        ),

                        pw.SizedBox(height: 20),

                        // ======================================
                        // THANK YOU
                        // ======================================
                        pw.Center(
                          child: pw.Text(
                            'Thank you for choosing Bright Energies Solutions!',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              fontSize: 11,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),

                        pw.SizedBox(height: 5),

                        pw.Center(
                          child: pw.Text(
                            'We look forward to serving you.',
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(fontSize: 9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
  // ============================================================
  // DETAILS TABLE
  // ============================================================

  pw.Widget buildDetailsTable(List<List<String>> data) {
    return pw.Table(
      border: pw.TableBorder.all(),
      columnWidths: {
        0: const pw.FlexColumnWidth(2),
        1: const pw.FlexColumnWidth(3),
      },
      children: data.map((row) {
        return pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(
                row[0],
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ),

            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(row[1]),
            ),
          ],
        );
      }).toList(),
    );
  }

  // ============================================================
  // VALIDATE FIELDS
  // ============================================================

  bool validateFields() {
    if (customerNameController.text.trim().isEmpty) {
      showMessage('Please enter Customer Name.');
      return false;
    }

    if (mobileController.text.trim().isEmpty) {
      showMessage('Please enter Mobile Number.');
      return false;
    }

    if (locationController.text.trim().isEmpty) {
      showMessage('Please enter Location.');
      return false;
    }

    if (capacityController.text.trim().isEmpty) {
      showMessage('Please enter Solar System Capacity.');
      return false;
    }

    return true;
  }

  // ============================================================
  // PREVIEW PDF
  // ============================================================

  Future<void> previewPdf() async {
    if (!validateFields()) {
      return;
    }

    try {
      final Uint8List pdfBytes = await generatePdf();

      if (!mounted) {
        return;
      }

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return PdfPreviewScreen(pdfBytes: pdfBytes);
          },
        ),
      );
    } catch (e) {
      showMessage('PDF generation failed: $e');
    }
  }

  // ============================================================
  // SHARE PDF
  // ============================================================

  Future<void> generateAndShare() async {
    if (!validateFields()) {
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final Uint8List pdfBytes = await generatePdf();

      await Printing.sharePdf(
        bytes: pdfBytes,
        filename:
            'Bright_Energies_Quotation_${customerNameController.text.trim()}.pdf',
      );
    } catch (e) {
      showMessage('PDF sharing failed: $e');
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  // ============================================================
  // SHOW MESSAGE
  // ============================================================

  void showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // ============================================================
  // UI
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ========================================================
      // YELLOW TOP HEADER
      // ========================================================

      appBar: AppBar(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        elevation: 2,
        centerTitle: true,

        title: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'BRIGHT ENERGIES SOLUTIONS',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Text(
              'Quotation Generator',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            // ====================================================
            // SELECT EXCEL
            // ====================================================

            ElevatedButton.icon(
              onPressed: selectExcelFile,

              icon: const Icon(Icons.upload_file),

              label: const Text('Select Excel Template'),
            ),

            const SizedBox(height: 10),

            // ====================================================
            // SELECTED FILE
            // ====================================================
            if (selectedFileName.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),

                child: Row(
                  children: [
                    const Icon(Icons.description),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        selectedFileName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 25),

            // ====================================================
            // CUSTOMER DETAILS
            // ====================================================
            const Text(
              'Customer Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // Customer Name
            TextField(
              controller: customerNameController,

              decoration: const InputDecoration(
                labelText: 'Customer Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // Mobile Number
            TextField(
              controller: mobileController,

              keyboardType: TextInputType.phone,

              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // Location
            TextField(
              controller: locationController,

              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // Solar Capacity
            TextField(
              controller: capacityController,

              decoration: const InputDecoration(
                labelText: 'Solar System Capacity',

                hintText: 'Example: 5 kW',

                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            // ====================================================
            // PREVIEW BUTTON
            // ====================================================
            OutlinedButton.icon(
              onPressed: previewPdf,

              icon: const Icon(Icons.picture_as_pdf),

              label: const Text('Preview Quotation'),
            ),

            const SizedBox(height: 12),

            // ====================================================
            // SHARE BUTTON
            // ====================================================
            ElevatedButton.icon(
              onPressed: loading ? null : generateAndShare,

              icon: loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,

                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.share),

              label: Text(loading ? 'Generating...' : 'Generate & Share PDF'),
            ),
          ],
        ),
      ),
    );
  }
}

// =================================================================
// PDF PREVIEW SCREEN
// =================================================================

class PdfPreviewScreen extends StatelessWidget {
  final Uint8List pdfBytes;

  const PdfPreviewScreen({super.key, required this.pdfBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,

        title: const Text('Quotation Preview'),
      ),

      body: PdfPreview(
        build: (format) async {
          return pdfBytes;
        },

        allowPrinting: true,
        allowSharing: true,

        canChangePageFormat: false,
        canChangeOrientation: false,
      ),
    );
  }
}
