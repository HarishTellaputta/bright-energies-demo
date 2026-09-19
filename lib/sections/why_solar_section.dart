import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/app_colors.dart';
import '../widgets/section_label.dart';

class WhySolarSection extends StatelessWidget {
  const WhySolarSection({super.key});

  @override
  Widget build(BuildContext context) {
    const benefits = [
      _Benefit(
        icon: Icons.savings_outlined,
        title: 'Lower Electricity Bills',
        description:
            'Generate your own clean electricity and reduce monthly power costs.',
      ),
      _Benefit(
        icon: Icons.eco_outlined,
        title: 'Clean Energy',
        description:
            'Use renewable solar energy while reducing dependence on conventional power.',
      ),
      _Benefit(
        icon: Icons.trending_up_outlined,
        title: 'Long-Term Value',
        description:
            'A well-designed solar system can deliver energy savings for many years.',
      ),
      _Benefit(
        icon: Icons.bolt_outlined,
        title: 'Energy Independence',
        description:
            'Take greater control of your electricity generation and energy usage.',
      ),
    ];

    return Container(
      width: double.infinity,
      color: AppColors.lightBackground,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 90,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 950;

          if (!isDesktop) {
            return _MobileLayout(
              benefits: benefits,
            );
          }

          return _DesktopLayout(
            benefits: benefits,
          );
        },
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final List<_Benefit> benefits;

  const _DesktopLayout({
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 1250,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: _VisualPanel(),
          ),

          const SizedBox(width: 75),

          Expanded(
            flex: 5,
            child: _ContentPanel(
              benefits: benefits,
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final List<_Benefit> benefits;

  const _MobileLayout({
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _VisualPanel(),

        const SizedBox(height: 55),

        _ContentPanel(
          benefits: benefits,
        ),
      ],
    );
  }
}

class _VisualPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.92,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  AppAssets.rooftopProject,
                  fit: BoxFit.cover,
                ),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.darkNavy.withOpacity(0.18),
                        AppColors.darkNavy.withOpacity(0.90),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  left: 28,
                  right: 28,
                  bottom: 28,
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: AppColors.darkNavy.withOpacity(0.88),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.wb_sunny_outlined,
                            color: AppColors.navy,
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SMART ENERGY',
                                style: TextStyle(
                                  color: AppColors.yellow,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.4,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Power your property with solar.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 28,
            right: -20,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.14),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.energy_savings_leaf_outlined,
                    color: AppColors.yellow,
                    size: 25,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'CLEAN ENERGY',
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
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
}

class _ContentPanel extends StatelessWidget {
  final List<_Benefit> benefits;

  const _ContentPanel({
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(
          text: 'WHY SOLAR',
        ),

        const SizedBox(height: 16),

        const Text(
          'A Smarter Way\nTo Power Your Future.',
          style: TextStyle(
            color: AppColors.navy,
            fontSize: 40,
            height: 1.08,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),

        const SizedBox(height: 18),

        const Text(
          'Solar energy is more than an alternative power source. '
          'It is a practical way to take greater control of your energy '
          'costs while moving towards cleaner power.',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 16,
            height: 1.7,
          ),
        ),

        const SizedBox(height: 30),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _MiniHighlight(
              icon: Icons.home_outlined,
              text: 'For Homes',
            ),
            _MiniHighlight(
              icon: Icons.business_outlined,
              text: 'For Businesses',
            ),
            _MiniHighlight(
              icon: Icons.factory_outlined,
              text: 'For Industries',
            ),
          ],
        ),

        const SizedBox(height: 35),

        Column(
          children: benefits.map(
            (benefit) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 14,
                ),
                child: _PremiumBenefitCard(
                  benefit: benefit,
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}

class _PremiumBenefitCard extends StatefulWidget {
  final _Benefit benefit;

  const _PremiumBenefitCard({
    required this.benefit,
  });

  @override
  State<_PremiumBenefitCard> createState() =>
      _PremiumBenefitCardState();
}

class _PremiumBenefitCardState extends State<_PremiumBenefitCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(
          0,
          isHovered ? -4 : 0,
          0,
        ),
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(
            color: isHovered
                ? AppColors.yellow.withOpacity(0.55)
                : AppColors.navy.withOpacity(0.06),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                isHovered ? 0.09 : 0.035,
              ),
              blurRadius: isHovered ? 24 : 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isHovered
                    ? AppColors.yellow
                    : AppColors.yellow.withOpacity(0.13),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                widget.benefit.icon,
                color: AppColors.navy,
                size: 23,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.benefit.title,
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    widget.benefit.description,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isHovered ? 1 : 0.35,
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.yellow,
                size: 21,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniHighlight extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MiniHighlight({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.navy.withOpacity(0.07),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.navy,
          ),
          const SizedBox(width: 7),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.navy,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _Benefit {
  final IconData icon;
  final String title;
  final String description;

  const _Benefit({
    required this.icon,
    required this.title,
    required this.description,
  });
}