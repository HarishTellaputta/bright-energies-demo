import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/app_colors.dart';

class CtaSection extends StatelessWidget {
  final VoidCallback onContact;

  const CtaSection({super.key, required this.onContact});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.lightBackground,
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 90),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 900;

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: AppColors.navy.withOpacity(0.18),
                  blurRadius: 35,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // BACKGROUND IMAGE
                Positioned.fill(
                  child: Image.asset(
                    AppAssets.hero,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: AppColors.darkNavy);
                    },
                  ),
                ),

                // DARK OVERLAY
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.darkNavy.withOpacity(0.97),
                          AppColors.navy.withOpacity(0.88),
                          AppColors.navy.withOpacity(0.55),
                        ],
                      ),
                    ),
                  ),
                ),

                // CONTENT
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 28 : 55,
                    vertical: isMobile ? 45 : 55,
                  ),
                  child: isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildContent(),
                            const SizedBox(height: 35),
                            _buildButton(),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(child: _buildContent()),
                            const SizedBox(width: 50),
                            _buildButton(),
                          ],
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // BADGE
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.yellow.withOpacity(0.15),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.yellow.withOpacity(0.35)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wb_sunny_rounded, color: AppColors.yellow, size: 16),
              SizedBox(width: 8),
              Text(
                'POWER YOUR FUTURE WITH SOLAR',
                style: TextStyle(
                  color: AppColors.yellow,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.9,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          'Ready to Make the\nSwitch to Solar?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 42,
            height: 1.08,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),

        const SizedBox(height: 17),

        const Text(
          'Take the first step towards cleaner energy and a smarter '
          'way to manage your electricity costs.',
          style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.7),
        ),

        const SizedBox(height: 25),

        Row(
          children: [
            _miniBenefit(Icons.check_circle_outline_rounded, 'Expert Guidance'),
            const SizedBox(width: 22),
            _miniBenefit(
              Icons.check_circle_outline_rounded,
              'Custom Solutions',
            ),
          ],
        ),
      ],
    );
  }

  Widget _miniBenefit(IconData icon, String text) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.yellow, size: 17),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Column(
      children: [
        // FLOATING CARD
        Container(
          width: 245,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withOpacity(0.16)),
          ),
          child: Column(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.solar_power_rounded,
                  color: AppColors.navy,
                  size: 27,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Let’s Build Your Solar Plan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'Talk to our team about your requirements.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onContact,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellow,
                    foregroundColor: AppColors.navy,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Free Consultation',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 17),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
