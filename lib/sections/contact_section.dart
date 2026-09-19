import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/company_info.dart';
import '../widgets/section_label.dart';

class ContactSection extends StatefulWidget {
  final GlobalKey sectionKey;

  const ContactSection({
    super.key,
    required this.sectionKey,
  });

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Thank you! We will contact you shortly.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.sectionKey,
      width: double.infinity,
      color: AppColors.lightBackground,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 110,
      ),
      child: Column(
        children: [
          const SectionLabel(
            text: 'CONTACT US',
          ),

          const SizedBox(height: 15),

          const Text(
            'Let’s Start Your Solar Journey',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.navy,
              fontSize: 44,
              height: 1.1,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),

          const SizedBox(height: 17),

          const Text(
            'Tell us about your energy requirements and our team can help '
            'you explore a suitable solar solution.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.text,
              fontSize: 16,
              height: 1.7,
            ),
          ),

          const SizedBox(height: 55),

          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 900;

              if (isMobile) {
                return Column(
                  children: [
                    _buildContactInfo(),
                    const SizedBox(height: 28),
                    _buildContactForm(),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 9,
                    child: _buildContactInfo(),
                  ),
                  const SizedBox(width: 28),
                  Expanded(
                    flex: 11,
                    child: _buildContactForm(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      padding: const EdgeInsets.all(38),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.navy,
            AppColors.darkNavy,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withOpacity(0.18),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOP ICON
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: AppColors.yellow,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.solar_power_rounded,
              color: AppColors.navy,
              size: 29,
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'Let’s Talk Solar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 13),

          const Text(
            'Have questions about solar installation, system sizing '
            'or your electricity requirements? Our team is ready to help.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.7,
            ),
          ),

          const SizedBox(height: 32),

          _contactItem(
            Icons.phone_outlined,
            'Phone',
            CompanyInfo.phone,
          ),

          const SizedBox(height: 13),

          _contactItem(
            Icons.chat_outlined,
            'WhatsApp',
            CompanyInfo.whatsapp,
          ),

          const SizedBox(height: 13),

          _contactItem(
            Icons.email_outlined,
            'Email',
            CompanyInfo.email,
          ),

          const SizedBox(height: 13),

          _contactItem(
            Icons.location_on_outlined,
            'Location',
            CompanyInfo.location,
          ),

          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.10),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.verified_outlined,
                  color: AppColors.yellow,
                  size: 22,
                ),
                const SizedBox(width: 11),
                const Expanded(
                  child: Text(
                    'Professional guidance from consultation '
                    'through installation and support.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
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

  Widget _contactItem(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.065),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 41,
            height: 41,
            decoration: BoxDecoration(
              color: AppColors.yellow,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              color: AppColors.navy,
              size: 20,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(38),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.black.withOpacity(0.045),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withOpacity(0.09),
            blurRadius: 35,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Request a Free Consultation',
              style: TextStyle(
                color: AppColors.navy,
                fontSize: 27,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 9),

            const Text(
              'Share your details and tell us what you need.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 28),

            _fieldLabel('YOUR NAME'),

            const SizedBox(height: 8),

            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: _inputDecoration(
                'Enter your name',
                Icons.person_outline_rounded,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            _fieldLabel('PHONE NUMBER'),

            const SizedBox(height: 8),

            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: _inputDecoration(
                'Enter your phone number',
                Icons.phone_outlined,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your phone number';
                }

                if (value.trim().length < 10) {
                  return 'Please enter a valid phone number';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            _fieldLabel('YOUR REQUIREMENT'),

            const SizedBox(height: 8),

            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: _inputDecoration(
                'Tell us about your solar requirement',
                Icons.message_outlined,
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellow,
                  foregroundColor: AppColors.navy,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Send Enquiry',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 17),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_outline_rounded,
                  size: 14,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 6),
                Text(
                  'Your information is kept private.',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.navy,
        fontSize: 10,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.8,
      ),
    );
  }

  InputDecoration _inputDecoration(
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 13,
      ),
      prefixIcon: Icon(
        icon,
        color: AppColors.navy,
        size: 20,
      ),
      filled: true,
      fillColor: AppColors.lightBackground,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.04),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.yellow,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 2,
        ),
      ),
    );
  }
}