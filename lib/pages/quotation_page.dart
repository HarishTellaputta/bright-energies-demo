import 'package:flutter/material.dart';

import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';
import 'package:excel/excel.dart' as ex;
import 'package:file_picker/file_picker.dart';
import 'package:printing/printing.dart';

import '../core/app_colors.dart';
import '../core/company_info.dart';
import '../services/quotation_pdf_service.dart';

class QuotationPage extends StatefulWidget {
  const QuotationPage({super.key});

  @override
  State<QuotationPage> createState() => _QuotationPageState();
}

class _QuotationPageState extends State<QuotationPage> {
  final customerNameController = TextEditingController();
  final mobileController = TextEditingController();
  final locationController = TextEditingController();
  final capacityController = TextEditingController();

  Uint8List? excelBytes;

  String selectedFileName = '';

  List<List<String>> importedExcelRows = [];

  String selectedCapacity = '5 kW';

  @override
  void dispose() {
    customerNameController.dispose();
    mobileController.dispose();
    locationController.dispose();
    capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,

      appBar: AppBar(
        backgroundColor: AppColors.yellow,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            const Icon(Icons.solar_power, size: 28),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  CompanyInfo.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Quotation Generator',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPageHeader(),

                const SizedBox(height: 28),

                _buildCustomerAndQuotationSection(),

                const SizedBox(height: 24),

                _buildExcelSection(),

                const SizedBox(height: 24),

                _buildActionSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.yellow, Colors.amber.shade300],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Solar Quotation',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Create a professional quotation for your solar customers.',
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerAndQuotationSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 750;

        if (isMobile) {
          return Column(
            children: [
              _buildCustomerCard(),
              const SizedBox(height: 20),
              _buildQuotationCard(),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCustomerCard()),
            const SizedBox(width: 20),
            Expanded(child: _buildQuotationCard()),
          ],
        );
      },
    );
  }

  Widget _buildCustomerCard() {
    return _buildCard(
      title: 'Customer Details',
      icon: Icons.person_outline,
      children: [
        _buildTextField(
          controller: customerNameController,
          label: 'Customer Name',
          hint: 'Enter customer name',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: mobileController,
          label: 'Mobile Number',
          hint: 'Enter mobile number',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: locationController,
          label: 'Location',
          hint: 'Enter customer location',
          icon: Icons.location_on_outlined,
        ),
      ],
    );
  }

  Widget _buildQuotationCard() {
    return _buildCard(
      title: 'Quotation Details',
      icon: Icons.receipt_long_outlined,
      children: [
        _buildReadOnlyField(
          label: 'Quotation Number',
          value: 'QUO-001',
          icon: Icons.tag,
        ),
        const SizedBox(height: 16),
        _buildReadOnlyField(
          label: 'Quotation Date',
          value: _currentDate(),
          icon: Icons.calendar_today_outlined,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          initialValue: selectedCapacity,
          decoration: InputDecoration(
            labelText: 'Solar System Capacity',
            hintText: 'Select capacity',
            prefixIcon: const Icon(Icons.solar_power),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: const [
            DropdownMenuItem(value: '2 kW', child: Text('2 kW')),
            DropdownMenuItem(value: '3 kW', child: Text('3 kW')),
            DropdownMenuItem(value: '5 kW', child: Text('5 kW')),
            DropdownMenuItem(value: '6 kW', child: Text('6 kW')),
            DropdownMenuItem(value: '10 kW', child: Text('10 kW')),
          ],
          onChanged: (value) {
            if (value == null) return;

            setState(() {
              selectedCapacity = value;
              capacityController.text = value;
            });
          },
        ),
      ],
    );
  }

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
        _showMessage('Excel file could not be loaded.');
        return;
      }

      final bytes = file.bytes!;

      final excel = ex.Excel.decodeBytes(bytes);

      final List<List<String>> rows = [];

      for (final sheetName in excel.tables.keys) {
        final sheet = excel.tables[sheetName];

        if (sheet == null) {
          continue;
        }

        for (final row in sheet.rows) {
          rows.add(
            row.map((cell) {
              return cell?.value?.toString() ?? '';
            }).toList(),
          );
        }

        // First sheet only
        break;
      }

      setState(() {
        excelBytes = bytes;
        selectedFileName = file.name;
        importedExcelRows = rows;
      });

      _showMessage('Excel imported successfully. ${rows.length} rows loaded.');
    } catch (e) {
      _showMessage('Excel import failed: $e');
    }
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildExcelSection() {
    return _buildCard(
      title: 'Quotation Template',
      icon: Icons.table_chart_outlined,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Icon(
                Icons.upload_file_outlined,
                size: 46,
                color: AppColors.yellow,
              ),
              const SizedBox(height: 12),
              const Text(
                'Import Excel Template',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                'Upload your Excel quotation template and use it for the quotation.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 18),
              OutlinedButton.icon(
                onPressed: selectExcelFile,
                icon: const Icon(Icons.upload_file),
                label: const Text('Import Excel'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionSection() {
    return _buildCard(
      title: 'Quotation Actions',
      icon: Icons.picture_as_pdf_outlined,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 650;

            final buttons = [
              OutlinedButton.icon(
                onPressed: _previewQuotation,
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('Preview Quotation'),
              ),
              ElevatedButton.icon(
                onPressed: _generatePdf,
                icon: const Icon(Icons.picture_as_pdf_outlined),
                label: const Text('Generate PDF'),
              ),
              ElevatedButton.icon(
                onPressed: _shareQuotation,
                icon: const Icon(Icons.share_outlined),
                label: const Text('Share / WhatsApp'),
              ),
            ];

            if (isMobile) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buttons
                    .map(
                      (button) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: button,
                      ),
                    )
                    .toList(),
              );
            }

            return Row(
              children: buttons
                  .map(
                    (button) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: SizedBox(height: 52, child: button),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.yellow.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.black87),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildReadOnlyField({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  String _currentDate() {
    final now = DateTime.now();

    return '${now.day.toString().padLeft(2, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.year}';
  }

  Future<void> _previewQuotation() async {
    if (!_validateQuotation()) {
      return;
    }

    final pdfBytes = await _generateQuotationBytes();

    if (!mounted) {
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Quotation Preview'),
            backgroundColor: AppColors.yellow,
            foregroundColor: Colors.black,
          ),
          body: PdfPreview(
            build: (format) async => pdfBytes,
            allowPrinting: true,
            allowSharing: true,
            canChangePageFormat: false,
            canChangeOrientation: false,
          ),
        ),
      ),
    );
  }

  bool _validateQuotation() {
    if (customerNameController.text.trim().isEmpty) {
      _showMessage('Please enter customer name.');
      return false;
    }

    if (mobileController.text.trim().isEmpty) {
      _showMessage('Please enter mobile number.');
      return false;
    }

    if (locationController.text.trim().isEmpty) {
      _showMessage('Please enter customer location.');
      return false;
    }

    return true;
  }

  Future<Uint8List> _generateQuotationBytes() async {
    return QuotationPdfService.generatePdf(
      customerName: customerNameController.text.trim(),
      mobile: mobileController.text.trim(),
      location: locationController.text.trim(),
      capacity: selectedCapacity,
      quotationNumber: 'QUO-${DateTime.now().millisecondsSinceEpoch}',
      quotationDate: _currentDate(),
      excelRows: importedExcelRows,
    );
  }

  Future<void> _generatePdf() async {
    if (!_validateQuotation()) {
      return;
    }

    try {
      _showMessage('Generating quotation PDF...');

      final pdfBytes = await _generateQuotationBytes();

      await Printing.sharePdf(bytes: pdfBytes, filename: _quotationFileName());
    } catch (e) {
      _showMessage('PDF generation failed: $e');
    }
  }

  String _quotationFileName() {
    final customerName = customerNameController.text.trim();

    final safeName = customerName.isEmpty
        ? 'Customer'
        : customerName.replaceAll(RegExp(r'[^a-zA-Z0-9]+'), '_');

    return 'Quotation_$safeName.pdf';
  }

  Future<void> _shareQuotation() async {
    if (!_validateQuotation()) {
      return;
    }

    try {
      _showMessage('Preparing quotation...');

      final pdfBytes = await _generateQuotationBytes();

      final customerName = customerNameController.text.trim();
      final capacity = selectedCapacity;

      final result = await SharePlus.instance.share(
        ShareParams(
          title: 'Solar Quotation',
          subject: 'Solar Quotation - $customerName',
          text:
              'Hello $customerName,\n\n'
              'Please find your solar quotation attached.\n\n'
              'System Capacity: $capacity\n'
              'Quotation Date: ${_currentDate()}\n\n'
              'Thank you,\n'
              '${CompanyInfo.name}',
          files: [
            XFile.fromData(
              pdfBytes,
              name: _quotationFileName(),
              mimeType: 'application/pdf',
            ),
          ],
        ),
      );

      if (result.status == ShareResultStatus.success) {
        _showMessage('Quotation shared successfully.');
      }
    } catch (e) {
      _showMessage('Sharing failed: $e');
    }
  }
}
