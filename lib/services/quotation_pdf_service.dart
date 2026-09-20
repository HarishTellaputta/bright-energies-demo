import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../core/company_info.dart';

class QuotationPdfService {
  static Future<Uint8List> generatePdf({
    required String customerName,
    required String mobile,
    required String location,
    required String capacity,
    required String quotationNumber,
    required String quotationDate,
    List<List<String>> excelRows = const [],
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          return [
            // ============================================================
            // COMPANY HEADER
            // ============================================================
            pw.Container(
              padding: const pw.EdgeInsets.all(20),
              decoration: pw.BoxDecoration(
                color: PdfColors.amber,
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        CompanyInfo.name,
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'Solar Energy Solutions',
                        style: const pw.TextStyle(
                          fontSize: 11,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.white,
                      borderRadius: pw.BorderRadius.circular(6),
                    ),
                    child: pw.Text(
                      'QUOTATION',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 25),

            // ============================================================
            // QUOTATION INFO
            // ============================================================
            // ============================================================
            // QUOTATION INFO
            // ============================================================
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(14),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey300, width: 0.8),
                borderRadius: pw.BorderRadius.circular(6),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Quotation No.',
                        style: pw.TextStyle(
                          fontSize: 9,
                          color: PdfColors.grey700,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        quotationNumber,
                        style: pw.TextStyle(
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        'Date',
                        style: pw.TextStyle(
                          fontSize: 9,
                          color: PdfColors.grey700,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        quotationDate,
                        style: pw.TextStyle(
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  pw.Text(
                    'SOLAR QUOTATION',
                    style: pw.TextStyle(
                      fontSize: 11,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.amber800,
                    ),
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 25),

            // ============================================================
            // CUSTOMER DETAILS
            // ============================================================
            _sectionTitle('Customer Details'),

            pw.SizedBox(height: 10),

            _detailsTable([
              ['Customer Name', customerName],
              ['Mobile Number', mobile],
              ['Location', location],
            ]),

            pw.SizedBox(height: 25),

            // ============================================================
            // SOLAR SYSTEM DETAILS
            // ============================================================
            _sectionTitle('Solar System Details'),

            pw.SizedBox(height: 10),

            _detailsTable([
              ['System Capacity', capacity],
              ['System Type', 'On-Grid Solar Power System'],
              ['Installation', 'Complete Solar Installation'],
            ]),

            // ============================================================
            // EXCEL DATA
            // ============================================================
            if (excelRows.isNotEmpty) ...[
              pw.SizedBox(height: 25),
              _sectionTitle('Quotation Items'),
              pw.SizedBox(height: 10),
              _excelTable(excelRows),
            ],

            pw.SizedBox(height: 30),

            // ============================================================
            // TERMS
            // ============================================================
            _sectionTitle('Terms & Conditions'),

            pw.SizedBox(height: 10),

            pw.Bullet(text: 'Quotation validity is subject to confirmation.'),
            pw.Bullet(
              text: 'Final pricing may vary based on site requirements.',
            ),
            pw.Bullet(
              text:
                  'Installation will be carried out after order confirmation.',
            ),
            pw.Bullet(
              text: 'Any additional civil or electrical work will be discussed separately.',
            ),

            pw.SizedBox(height: 35),

            // ============================================================
            // THANK YOU
            // ============================================================
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(18),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey100,
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Column(
                children: [
                  pw.Text(
                    'Thank You',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 6),
                  pw.Text(
                    'We appreciate the opportunity to provide our solar solution.',
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey700,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  // ========================================================================
  // SECTION TITLE
  // ========================================================================

  static pw.Widget _sectionTitle(String title) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const pw.BoxDecoration(color: PdfColors.amber),
      child: pw.Text(
        title,
        style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  // ========================================================================
  // DETAILS TABLE
  // ========================================================================

  static pw.Widget _detailsTable(List<List<String>> rows) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.7),
      columnWidths: const {
        0: pw.FlexColumnWidth(1.2),
        1: pw.FlexColumnWidth(2),
      },
      children: rows.map((row) {
        return pw.TableRow(
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.all(9),
              color: PdfColors.grey100,
              child: pw.Text(
                row[0],
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(9),
              child: pw.Text(
                row.length > 1 ? row[1] : '',
                style: const pw.TextStyle(fontSize: 10),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  // ========================================================================
  // EXCEL TABLE
  // ========================================================================

  static pw.Widget _excelTable(List<List<String>> rows) {
    if (rows.isEmpty) {
      return pw.SizedBox();
    }

    final maxColumns = rows.fold<int>(
      0,
      (maximum, row) => row.length > maximum ? row.length : maximum,
    );

    if (maxColumns == 0) {
      return pw.SizedBox();
    }

    final tableRows = <pw.TableRow>[];

    for (int rowIndex = 0; rowIndex < rows.length; rowIndex++) {
      final row = rows[rowIndex];

      tableRows.add(
        pw.TableRow(
          children: List.generate(maxColumns, (columnIndex) {
            final value = columnIndex < row.length ? row[columnIndex] : '';

            return pw.Container(
              padding: const pw.EdgeInsets.all(7),
              color: rowIndex == 0 ? PdfColors.amber : PdfColors.white,
              child: pw.Text(
                value,
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: rowIndex == 0
                      ? pw.FontWeight.bold
                      : pw.FontWeight.normal,
                ),
              ),
            );
          }),
        ),
      );
    }

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.6),
      children: tableRows,
    );
  }
}
