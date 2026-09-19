import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/app_colors.dart';
import '../widgets/section_label.dart';

class ProjectsSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const ProjectsSection({
    super.key,
    required this.sectionKey,
  });

  @override
  Widget build(BuildContext context) {
    const projects = [
      _ProjectData(
        category: 'RESIDENTIAL',
        title: 'Residential Rooftop',
        location: 'Khammam, Telangana',
        description:
            'A rooftop solar solution designed for residential energy requirements.',
        image: AppAssets.rooftopProject,
        icon: Icons.home_outlined,
      ),
      _ProjectData(
        category: 'COMMERCIAL',
        title: 'Commercial Solar',
        location: 'Telangana',
        description:
            'A solar solution designed to support commercial energy requirements.',
        image: AppAssets.commercial,
        icon: Icons.business_outlined,
      ),
      _ProjectData(
        category: 'UTILITY SCALE',
        title: 'Solar Power Plant',
        location: 'Telangana',
        description:
            'A larger-scale solar solution focused on clean and efficient power generation.',
        image: AppAssets.solarPlantProject,
        icon: Icons.solar_power_outlined,
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
            text: 'PROJECT EXAMPLES',
          ),

          const SizedBox(height: 16),

          const Text(
            'Solar Solutions in Action',
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
            'Explore different types of solar installations for homes, '
            'businesses and larger energy requirements.',
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
              final isMobile = constraints.maxWidth < 750;

              if (isMobile) {
                return Column(
                  children: projects
                      .map(
                        (project) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: 22,
                          ),
                          child: _ProjectCard(
                            project: project,
                          ),
                        ),
                      )
                      .toList(),
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: projects
                    .map(
                      (project) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: project == projects.last ? 0 : 22,
                          ),
                          child: _ProjectCard(
                            project: project,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// PROJECT DATA
// =====================================================================

class _ProjectData {
  final String category;
  final String title;
  final String location;
  final String description;
  final String image;
  final IconData icon;

  const _ProjectData({
    required this.category,
    required this.title,
    required this.location,
    required this.description,
    required this.image,
    required this.icon,
  });
}

// =====================================================================
// PROJECT CARD
// =====================================================================

class _ProjectCard extends StatefulWidget {
  final _ProjectData project;

  const _ProjectCard({
    required this.project,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

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
                ? AppColors.yellow.withOpacity(0.45)
                : Colors.black.withOpacity(0.045),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy.withOpacity(
                _hovered ? 0.13 : 0.06,
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
              height: 245,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedScale(
                      scale: _hovered ? 1.04 : 1.0,
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      curve: Curves.easeOut,
                      child: Image.asset(
                        project.image,
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
                                project.icon,
                                color: AppColors.yellow,
                                size: 70,
                              ),
                            ),
                          );
                        },
                      ),
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
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.60),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // CATEGORY
                  Positioned(
                    top: 18,
                    left: 18,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.navy.withOpacity(0.88),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        project.category,
                        style: const TextStyle(
                          color: AppColors.yellow,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),

                  // ICON
                  Positioned(
                    right: 18,
                    bottom: 18,
                    child: Container(
                      width: 43,
                      height: 43,
                      decoration: BoxDecoration(
                        color: AppColors.yellow,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(
                        project.icon,
                        color: AppColors.navy,
                        size: 21,
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
                    project.title,
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppColors.yellow,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          project.location,
                          style: const TextStyle(
                            color: AppColors.text,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 13),

                  Text(
                    project.description,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 13,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // BOTTOM ACTION
                  Row(
                    children: [
                      Text(
                        'VIEW SOLUTION',
                        style: TextStyle(
                          color: AppColors.navy,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(width: 7),
                      AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 250,
                        ),
                        width: _hovered ? 30 : 22,
                        height: 2,
                        color: AppColors.yellow,
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