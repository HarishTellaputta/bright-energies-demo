import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/app_colors.dart';
import '../core/company_info.dart';
import '../widgets/section_label.dart';

class InstallationSection extends StatelessWidget {
  const InstallationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 100,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.darkNavy,
            AppColors.navy,
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 900;

          return Column(
            children: [
              if (isMobile)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIntro(),
                    const SizedBox(height: 40),
                    _buildImage(),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 10,
                      child: _buildIntro(),
                    ),
                    const SizedBox(width: 70),
                    Expanded(
                      flex: 9,
                      child: _buildImage(),
                    ),
                  ],
                ),

              const SizedBox(height: 55),

              _buildStats(constraints.maxWidth),
            ],
          );
        },
      ),
    );
  }

  // ===============================================================
  // INTRO
  // ===============================================================

  Widget _buildIntro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(
          text: 'INSTALLATION EXPERIENCE',
        ),

        const SizedBox(height: 18),

        const Text(
          'Built Around Quality.\nDesigned for Performance.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 42,
            height: 1.1,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          'Professional solar installation with a focus on '
          'quality workmanship, reliable solutions and long-term performance.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            height: 1.75,
          ),
        ),

        const SizedBox(height: 28),

        // BENEFITS
        _benefit(
          Icons.verified_outlined,
          'Quality-focused installation',
        ),

        const SizedBox(height: 13),

        _benefit(
          Icons.engineering_outlined,
          'Professional installation approach',
        ),

        const SizedBox(height: 13),

        _benefit(
          Icons.support_agent_outlined,
          'Ongoing support and guidance',
        ),
      ],
    );
  }

  Widget _benefit(
    IconData icon,
    String text,
  ) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.yellow.withOpacity(0.13),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.yellow,
            size: 18,
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  // ===============================================================
  // IMAGE
  // ===============================================================

  Widget _buildImage() {
    return Container(
      height: 390,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 35,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.installation,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.navy,
                  child: const Center(
                    child: Icon(
                      Icons.solar_power_rounded,
                      color: AppColors.yellow,
                      size: 75,
                    ),
                  ),
                );
              },
            ),
          ),

          // IMAGE OVERLAY
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.darkNavy.withOpacity(0.72),
                  ],
                ),
              ),
            ),
          ),

          // BOTTOM LABEL
          Positioned(
            left: 22,
            right: 22,
            bottom: 22,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.32),
                borderRadius: BorderRadius.circular(17),
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.solar_power_rounded,
                    color: AppColors.yellow,
                    size: 25,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Professional Solar Installation',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
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

  // ===============================================================
  // STATS
  // ===============================================================

  Widget _buildStats(double maxWidth) {
    final isMobile = maxWidth < 700;

    final cards = [
      _StatData(
        CompanyInfo.experience,
        'Years Experience',
        Icons.workspace_premium_outlined,
      ),
      _StatData(
        CompanyInfo.installations,
        'Installations',
        Icons.solar_power_outlined,
      ),
      _StatData(
        CompanyInfo.capacity,
        'Installed Capacity',
        Icons.bolt_outlined,
      ),
      _StatData(
        CompanyInfo.rating,
        'Customer Rating',
        Icons.star_outline_rounded,
      ),
    ];

    if (isMobile) {
      return Column(
        children: cards
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: _statCard(item),
              ),
            )
            .toList(),
      );
    }

    return Row(
      children: cards
          .map(
            (item) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: item == cards.last ? 0 : 14,
                ),
                child: _statCard(item),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _statCard(_StatData item) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.065),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(0.10),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.yellow.withOpacity(0.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              item.icon,
              color: AppColors.yellow,
              size: 22,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatData {
  final String value;
  final String title;
  final IconData icon;

  const _StatData(
    this.value,
    this.title,
    this.icon,
  );
}