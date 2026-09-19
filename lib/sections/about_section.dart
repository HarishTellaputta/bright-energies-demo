import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/app_colors.dart';
import '../core/company_info.dart';
import '../widgets/section_label.dart';

class AboutSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const AboutSection({
    super.key,
    required this.sectionKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 110,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 900;

          if (isMobile) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildVisual(context),
                const SizedBox(height: 55),
                _buildText(context),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 11,
                child: _buildVisual(context),
              ),
              const SizedBox(width: 85),
              Expanded(
                flex: 10,
                child: _buildText(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildVisual(BuildContext context) {
    return SizedBox(
      height: 510,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // IMAGE
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.navy.withOpacity(0.12),
                    blurRadius: 35,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                AppAssets.installation,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.darkNavy,
                    child: const Center(
                      child: Icon(
                        Icons.solar_power_rounded,
                        color: AppColors.yellow,
                        size: 100,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // IMAGE GRADIENT
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    AppColors.darkNavy.withOpacity(0.78),
                  ],
                ),
              ),
            ),
          ),

          // TOP LEFT LABEL
          Positioned(
            left: 24,
            top: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.93),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified_rounded,
                    color: AppColors.navy,
                    size: 17,
                  ),
                  SizedBox(width: 7),
                  Text(
                    'TRUSTED SOLAR SOLUTIONS',
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // BOTTOM TEXT
          const Positioned(
            left: 28,
            bottom: 28,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Clean Energy.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Smarter Investment.',
                  style: TextStyle(
                    color: AppColors.yellow,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),

          // EXPERIENCE CARD
          Positioned(
            right: -25,
            bottom: 32,
            child: Container(
              width: 145,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 18,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.13),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.yellow.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.workspace_premium_rounded,
                      color: AppColors.navy,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    CompanyInfo.experience,
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Text(
                    'Experience',
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(
          text: 'ABOUT US',
        ),

        const SizedBox(height: 15),

        const Text(
          'Powering a Cleaner,\nSmarter Future.',
          style: TextStyle(
            color: AppColors.navy,
            fontSize: 43,
            height: 1.08,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),

        const SizedBox(height: 24),

        Text(
          '${CompanyInfo.name} provides reliable solar energy solutions '
          'designed for homes, businesses and industries.',
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 17,
            height: 1.75,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 18),

        const Text(
          'From consultation and system design to installation and ongoing '
          'support, our focus is on delivering dependable solar solutions '
          'that help customers move towards cleaner energy.',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 15,
            height: 1.75,
          ),
        ),

        const SizedBox(height: 30),

        _feature(
          Icons.check_circle_rounded,
          'Quality-focused installation',
        ),

        const SizedBox(height: 15),

        _feature(
          Icons.bolt_rounded,
          'Solutions designed around your energy needs',
        ),

        const SizedBox(height: 15),

        _feature(
          Icons.support_agent_rounded,
          'Reliable support after installation',
        ),

        const SizedBox(height: 34),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            color: AppColors.lightBackground,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black.withOpacity(0.05),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.solar_power_rounded,
                  color: AppColors.navy,
                  size: 22,
                ),
              ),
              const SizedBox(width: 13),
              const Expanded(
                child: Text(
                  'A smarter way to generate clean energy.',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _feature(
    IconData icon,
    String text,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.yellow.withOpacity(0.14),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColors.navy,
            size: 17,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.navy,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}