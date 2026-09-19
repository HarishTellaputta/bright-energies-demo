import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../widgets/section_label.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    const steps = [
      _ProcessStep(
        number: '01',
        icon: Icons.phone_in_talk_outlined,
        title: 'Consultation',
        description:
            'We understand your electricity requirements and discuss a suitable solar solution.',
      ),
      _ProcessStep(
        number: '02',
        icon: Icons.analytics_outlined,
        title: 'Site Assessment',
        description:
            'We evaluate the site, available space and energy requirements.',
      ),
      _ProcessStep(
        number: '03',
        icon: Icons.design_services_outlined,
        title: 'System Design',
        description:
            'We plan a solar system based on your requirements and site conditions.',
      ),
      _ProcessStep(
        number: '04',
        icon: Icons.solar_power_outlined,
        title: 'Installation',
        description:
            'The system is professionally installed and prepared for operation.',
      ),
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 105,
      ),
      child: Column(
        children: [
          const SectionLabel(
            text: 'OUR PROCESS',
          ),

          const SizedBox(height: 16),

          const Text(
            'From Idea to Solar Power.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.navy,
              fontSize: 44,
              height: 1.1,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'A clear and structured process designed to make your solar journey simple.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.text,
              fontSize: 16,
              height: 1.7,
            ),
          ),

          const SizedBox(height: 60),

          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 850;

              if (isMobile) {
                return Column(
                  children: steps
                      .map(
                        (step) => Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: _ProcessCard(
                            step: step,
                            isMobile: true,
                          ),
                        ),
                      )
                      .toList(),
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: steps
                    .map(
                      (step) => Expanded(
                        child: _ProcessCard(
                          step: step,
                          isMobile: false,
                          isLast: step == steps.last,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),

          const SizedBox(height: 45),

          // BOTTOM TRUST STRIP
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: AppColors.lightBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.navy.withOpacity(0.05),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  color: AppColors.yellow,
                  size: 20,
                ),
                SizedBox(width: 9),
                Flexible(
                  child: Text(
                    'Clear communication at every stage of the project',
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
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
}

// =====================================================================
// DATA
// =====================================================================

class _ProcessStep {
  final String number;
  final IconData icon;
  final String title;
  final String description;

  const _ProcessStep({
    required this.number,
    required this.icon,
    required this.title,
    required this.description,
  });
}

// =====================================================================
// CARD
// =====================================================================

class _ProcessCard extends StatelessWidget {
  final _ProcessStep step;
  final bool isMobile;
  final bool isLast;

  const _ProcessCard({
    required this.step,
    required this.isMobile,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return _buildMobileCard();
    }

    return _buildDesktopCard();
  }

  // ===================================================================
  // DESKTOP
  // ===================================================================

  Widget _buildDesktopCard() {
    return Stack(
      children: [
        // CONNECTING LINE
        if (!isLast)
          Positioned(
            top: 31,
            left: 62,
            right: 0,
            child: Container(
              height: 2,
              color: AppColors.yellow.withOpacity(0.35),
            ),
          ),

        Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(
              24,
              24,
              24,
              26,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: AppColors.navy.withOpacity(0.07),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.navy.withOpacity(0.06),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NUMBER + ICON
                Row(
                  children: [
                    Container(
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                        color: AppColors.yellow,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.yellow.withOpacity(0.22),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Icon(
                        step.icon,
                        color: AppColors.navy,
                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 13),

                    Text(
                      step.number,
                      style: TextStyle(
                        color: AppColors.navy.withOpacity(0.10),
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                Text(
                  step.title,
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  step.description,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 13,
                    height: 1.65,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ===================================================================
  // MOBILE
  // ===================================================================

  Widget _buildMobileCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: AppColors.yellow,
                borderRadius: BorderRadius.circular(17),
              ),
              child: Icon(
                step.icon,
                color: AppColors.navy,
                size: 25,
              ),
            ),
          ],
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.lightBackground,
              borderRadius: BorderRadius.circular(19),
              border: Border.all(
                color: AppColors.navy.withOpacity(0.06),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      step.number,
                      style: TextStyle(
                        color: AppColors.yellow,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.navy,
                      size: 17,
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  step.title,
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  step.description,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}