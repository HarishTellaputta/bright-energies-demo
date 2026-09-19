import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/company_info.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback onHome;
  final VoidCallback onSolutions;
  final VoidCallback onProjects;
  final VoidCallback onAbout;
  final VoidCallback onContact;

  const FooterSection({
    super.key,
    required this.onHome,
    required this.onSolutions,
    required this.onProjects,
    required this.onAbout,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.darkNavy,
      child: Column(
        children: [
          // =========================================================
          // MAIN FOOTER
          // =========================================================
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 70,
              vertical: 70,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 850;

                if (isMobile) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCompany(),
                      const SizedBox(height: 45),
                      _buildLinks(),
                      const SizedBox(height: 45),
                      _buildContact(),
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: _buildCompany(),
                    ),
                    const SizedBox(width: 70),
                    Expanded(
                      flex: 3,
                      child: _buildLinks(),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                      flex: 4,
                      child: _buildContact(),
                    ),
                  ],
                );
              },
            ),
          ),

          // =========================================================
          // BOTTOM BAR
          // =========================================================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 70,
              vertical: 22,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.14),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 700;

                if (isMobile) {
                  return Column(
                    children: [
                      _copyright(),
                      const SizedBox(height: 10),
                      _poweredBy(),
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _copyright(),
                    _poweredBy(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // COMPANY
  // ===============================================================

  Widget _buildCompany() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onHome,
          borderRadius: BorderRadius.circular(14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.yellow,
                      Color(0xFFFFD85C),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.yellow.withOpacity(0.20),
                      blurRadius: 18,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.wb_sunny_rounded,
                  color: AppColors.navy,
                  size: 28,
                ),
              ),

              const SizedBox(width: 14),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BRIGHT ENERGIES',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'SOLUTIONS',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.45),
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        const Text(
          'Powering homes, businesses and industries '
          'with cleaner and smarter solar energy solutions.',
          style: TextStyle(
            color: Colors.white60,
            fontSize: 14,
            height: 1.7,
          ),
        ),

        const SizedBox(height: 25),

        // SMALL BRAND BADGE
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            color: AppColors.yellow.withOpacity(0.08),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.yellow.withOpacity(0.18),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.bolt_rounded,
                color: AppColors.yellow,
                size: 16,
              ),
              SizedBox(width: 7),
              Text(
                'CLEAN ENERGY • SMART FUTURE',
                style: TextStyle(
                  color: AppColors.yellow,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===============================================================
  // QUICK LINKS
  // ===============================================================

  Widget _buildLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Explore',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 20),

        _footerLink(
          Icons.home_outlined,
          'Home',
          onHome,
        ),

        _footerLink(
          Icons.bolt_outlined,
          'Solutions',
          onSolutions,
        ),

        _footerLink(
          Icons.solar_power_outlined,
          'Projects',
          onProjects,
        ),

        _footerLink(
          Icons.business_outlined,
          'About Us',
          onAbout,
        ),

        _footerLink(
          Icons.phone_outlined,
          'Contact',
          onContact,
        ),
      ],
    );
  }

  Widget _footerLink(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 7,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: Colors.white38,
            ),
            const SizedBox(width: 9),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // CONTACT
  // ===============================================================

  Widget _buildContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Get in Touch',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 20),

        _contactRow(
          Icons.phone_outlined,
          CompanyInfo.phone,
        ),

        const SizedBox(height: 14),

        _contactRow(
          Icons.chat_outlined,
          CompanyInfo.whatsapp,
        ),

        const SizedBox(height: 14),

        _contactRow(
          Icons.email_outlined,
          CompanyInfo.email,
        ),

        const SizedBox(height: 14),

        _contactRow(
          Icons.location_on_outlined,
          CompanyInfo.location,
        ),

        const SizedBox(height: 25),

        SizedBox(
          width: 180,
          child: ElevatedButton(
            onPressed: onContact,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.yellow,
              foregroundColor: AppColors.navy,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                vertical: 13,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Get a Quote',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(width: 7),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _contactRow(
    IconData icon,
    String text,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.yellow.withOpacity(0.10),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(
            icon,
            size: 16,
            color: AppColors.yellow,
          ),
        ),

        const SizedBox(width: 11),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ===============================================================
  // COPYRIGHT
  // ===============================================================

  Widget _copyright() {
    return const Text(
      '© 2026 Bright Energies Solutions. All rights reserved.',
      style: TextStyle(
        color: Colors.white38,
        fontSize: 12,
      ),
    );
  }

  // ===============================================================
  // POWERED BY
  // ===============================================================

  Widget _poweredBy() {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.bolt_rounded,
          color: AppColors.yellow,
          size: 14,
        ),
        SizedBox(width: 5),
        Text(
          'Clean Energy • Smart Solutions • Better Future',
          style: TextStyle(
            color: Colors.white38,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}