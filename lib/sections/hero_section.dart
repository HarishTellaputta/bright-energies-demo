import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/app_colors.dart';
import '../core/company_info.dart';

class HeroSection extends StatelessWidget {
  final GlobalKey sectionKey;
  final VoidCallback onContact;
  final VoidCallback onSolutions;
  final VoidCallback onQuote;

  const HeroSection({
    super.key,
    required this.sectionKey,
    required this.onContact,
    required this.onSolutions,
    required this.onQuote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      width: double.infinity,
      color: AppColors.darkNavy,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 800;

          final heroHeight = isMobile ? 760.0 : 700.0;

          return SizedBox(
            width: double.infinity,
            height: heroHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // =========================================================
                // BACKGROUND IMAGE
                // =========================================================
                Positioned.fill(
                  child: Image.asset(
                    AppAssets.hero,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: AppColors.darkNavy);
                    },
                  ),
                ),

                // =========================================================
                // CORPORATE DARK OVERLAY
                // =========================================================
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.darkNavy.withOpacity(0.98),
                          AppColors.darkNavy.withOpacity(0.88),
                          AppColors.darkNavy.withOpacity(0.62),
                          AppColors.darkNavy.withOpacity(0.30),
                        ],
                        stops: const [0.0, 0.38, 0.70, 1.0],
                      ),
                    ),
                  ),
                ),

                // =========================================================
                // YELLOW GLOW
                // =========================================================
                Positioned(
                  right: -140,
                  top: -150,
                  child: IgnorePointer(
                    child: Container(
                      width: 430,
                      height: 430,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.yellow.withOpacity(0.075),
                      ),
                    ),
                  ),
                ),

                // =========================================================
                // SECONDARY GLOW
                // =========================================================
                Positioned(
                  right: 100,
                  bottom: -220,
                  child: IgnorePointer(
                    child: Container(
                      width: 420,
                      height: 420,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.025),
                      ),
                    ),
                  ),
                ),

                // =========================================================
                // CONTENT
                // =========================================================
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 70,
                      vertical: isMobile ? 45 : 70,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: isMobile ? 650 : 780,
                        ),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // =================================================
                              // BADGE
                              // =================================================
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 9,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.yellow.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: AppColors.yellow.withOpacity(0.42),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.bolt_rounded,
                                      color: AppColors.yellow,
                                      size: 17,
                                    ),
                                    SizedBox(width: 7),
                                    Text(
                                      'CLEAN ENERGY • SMART INVESTMENT',
                                      style: TextStyle(
                                        color: AppColors.yellow,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1.05,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 22),

                              // =================================================
                              // MAIN HEADING
                              // =================================================
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Powering a Brighter\n',
                                    ),
                                    TextSpan(
                                      text: 'Future With Solar',
                                      style: TextStyle(
                                        color: AppColors.yellow,
                                        shadows: [
                                          Shadow(
                                            color: AppColors.yellow.withOpacity(
                                              0.18,
                                            ),
                                            blurRadius: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isMobile ? 40 : 62,
                                  height: 1.08,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -1.8,
                                ),
                              ),

                              const SizedBox(height: 20),

                              // =================================================
                              // DESCRIPTION
                              // =================================================
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 650,
                                ),
                                child: Text(
                                  'Reliable solar energy solutions for homes, '
                                  'businesses and industries — designed to help '
                                  'you move towards cleaner and smarter energy.',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.78),
                                    fontSize: isMobile ? 14 : 17,
                                    height: 1.65,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 30),

                              // =================================================
                              // CTA BUTTONS
                              // =================================================
                              Wrap(
                                spacing: 14,
                                runSpacing: 12,
                                children: [
                                  ElevatedButton(
                                    onPressed: onQuote,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.yellow,
                                      foregroundColor: AppColors.navy,
                                      elevation: 8,
                                      shadowColor: AppColors.yellow.withOpacity(
                                        0.25,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 17,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Get Free Quote',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
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

                                  OutlinedButton(
                                    onPressed: onSolutions,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      side: BorderSide(
                                        color: Colors.white.withOpacity(0.40),
                                        width: 1.2,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 17,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Explore Solutions',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(width: 9),
                                        Icon(
                                          Icons.arrow_downward_rounded,
                                          size: 17,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 28),

                              // =================================================
                              // TRUST LINE
                              // =================================================
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: AppColors.yellow,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 9),
                                  Flexible(
                                    child: Text(
                                      'Residential • Commercial • Industrial',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.55),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 18),

                              // =================================================
                              // TRUST METRICS
                              // =================================================
                              Wrap(
                                spacing: 12,
                                runSpacing: 10,
                                children: [
                                  _Metric(
                                    value: CompanyInfo.experience,
                                    label: 'Years Experience',
                                  ),
                                  _Metric(
                                    value: CompanyInfo.installations,
                                    label: 'Installations',
                                  ),
                                  _Metric(
                                    value: CompanyInfo.capacity,
                                    label: 'Installed Capacity',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // =========================================================
                // SCROLL INDICATOR
                // =========================================================
                if (!isMobile)
                  Positioned(
                    bottom: 18,
                    left: 0,
                    right: 0,
                    child: IgnorePointer(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'SCROLL TO EXPLORE',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.45),
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white.withOpacity(0.55),
                              size: 21,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// =====================================================================
// METRIC CARD
// =====================================================================

class _Metric extends StatelessWidget {
  final String value;
  final String label;

  const _Metric({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.075),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.yellow,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.70),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
