import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/app_colors.dart';
import '../widgets/section_label.dart';

class SolutionsSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const SolutionsSection({
    super.key,
    required this.sectionKey,
  });

  @override
  Widget build(BuildContext context) {
    const solutions = [
      _SolutionData(
        category: 'FOR HOMES',
        title: 'Residential Solar',
        description:
            'Efficient rooftop solar solutions designed for homes and families.',
        icon: Icons.home_outlined,
        image: AppAssets.residential,
      ),
      _SolutionData(
        category: 'FOR BUSINESSES',
        title: 'Commercial Solar',
        description:
            'Reliable solar solutions designed to help businesses manage energy costs.',
        icon: Icons.business_outlined,
        image: AppAssets.commercial,
      ),
      _SolutionData(
        category: 'FOR INDUSTRIES',
        title: 'Industrial Solar',
        description:
            'High-capacity solar solutions for larger industrial energy requirements.',
        icon: Icons.factory_outlined,
        image: AppAssets.industrial,
      ),
      _SolutionData(
        category: 'ROOFTOP SOLUTIONS',
        title: 'Rooftop Solar',
        description:
            'Smart rooftop systems designed around available space and energy needs.',
        icon: Icons.roofing_outlined,
        image: AppAssets.rooftopProject,
      ),
      _SolutionData(
        category: 'EXPERT GUIDANCE',
        title: 'Solar Consultation',
        description:
            'Understand your energy requirements and explore a suitable solar system.',
        icon: Icons.support_agent_outlined,
        image: AppAssets.team,
      ),
      _SolutionData(
        category: 'LONG-TERM SUPPORT',
        title: 'Maintenance & Support',
        description:
            'Ongoing support and guidance to help your solar system perform reliably.',
        icon: Icons.build_outlined,
        image: AppAssets.installation,
      ),
    ];

    return Container(
      key: sectionKey,
      width: double.infinity,
      color: AppColors.lightBackground,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 105,
      ),
      child: Column(
        children: [
          const SectionLabel(
            text: 'OUR SOLUTIONS',
          ),

          const SizedBox(height: 16),

          const Text(
            'Solar Solutions for Every Need',
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
            'From residential rooftops to larger energy requirements, '
            'explore solutions designed around your needs.',
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
              int columns;

              if (constraints.maxWidth >= 1150) {
                columns = 3;
              } else if (constraints.maxWidth >= 700) {
                columns = 2;
              } else {
                columns = 1;
              }

              final width =
                  (constraints.maxWidth - ((columns - 1) * 22)) /
                      columns;

              return Wrap(
                spacing: 22,
                runSpacing: 22,
                children: solutions.map(
                  (solution) {
                    return SizedBox(
                      width: width,
                      child: _SolutionCard(
                        solution: solution,
                      ),
                    );
                  },
                ).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// DATA
// =====================================================================

class _SolutionData {
  final String category;
  final String title;
  final String description;
  final IconData icon;
  final String image;

  const _SolutionData({
    required this.category,
    required this.title,
    required this.description,
    required this.icon,
    required this.image,
  });
}

// =====================================================================
// CARD
// =====================================================================

class _SolutionCard extends StatefulWidget {
  final _SolutionData solution;

  const _SolutionCard({
    required this.solution,
  });

  @override
  State<_SolutionCard> createState() => _SolutionCardState();
}

class _SolutionCardState extends State<_SolutionCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final solution = widget.solution;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _hovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _hovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(
          0,
          _hovered ? -7 : 0,
          0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: _hovered
                ? AppColors.yellow.withOpacity(0.40)
                : Colors.black.withOpacity(0.045),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy.withOpacity(
                _hovered ? 0.13 : 0.055,
              ),
              blurRadius: _hovered ? 30 : 20,
              offset: Offset(
                0,
                _hovered ? 16 : 8,
              ),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // IMAGE
            // =========================================================
            SizedBox(
              height: 220,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedScale(
                      scale: _hovered ? 1.05 : 1.0,
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      curve: Curves.easeOut,
                      child: Image.asset(
                        solution.image,
                        fit: BoxFit.cover,
                        errorBuilder: (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return Container(
                            color: AppColors.darkNavy,
                            child: Center(
                              child: Icon(
                                solution.icon,
                                color: AppColors.yellow,
                                size: 68,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // DARK OVERLAY
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.08),
                            Colors.black.withOpacity(0.55),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // CATEGORY BADGE
                  Positioned(
                    left: 18,
                    top: 18,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.navy.withOpacity(0.90),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        solution.category,
                        style: const TextStyle(
                          color: AppColors.yellow,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                  ),

                  // ICON
                  Positioned(
                    right: 18,
                    bottom: 18,
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 250,
                      ),
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.yellow,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.yellow.withOpacity(
                              0.25,
                            ),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Icon(
                        solution.icon,
                        color: AppColors.navy,
                        size: 23,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // =========================================================
            // CONTENT
            // =========================================================
            Padding(
              padding: const EdgeInsets.fromLTRB(
                23,
                22,
                23,
                23,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    solution.title,
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    solution.description,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 13,
                      height: 1.65,
                    ),
                  ),

                  const SizedBox(height: 19),

                  Container(
                    height: 1,
                    color: AppColors.navy.withOpacity(0.07),
                  ),

                  const SizedBox(height: 17),

                  // BOTTOM ACTION
                  Row(
                    children: [
                      Text(
                        'EXPLORE SOLUTION',
                        style: const TextStyle(
                          color: AppColors.navy,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.75,
                        ),
                      ),

                      const SizedBox(width: 8),

                      AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 250,
                        ),
                        width: _hovered ? 30 : 22,
                        height: 2,
                        color: AppColors.yellow,
                      ),

                      const Spacer(),

                      AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 250,
                        ),
                        transform: Matrix4.translationValues(
                          _hovered ? 3 : 0,
                          0,
                          0,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.navy,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}