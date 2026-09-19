import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../widgets/section_label.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const reviews = [
      _ReviewData(
        name: 'Sample Customer',
        role: 'Residential Customer',
        review:
            'The installation process was smooth and the team explained the system clearly.',
        rating: 5,
      ),
      _ReviewData(
        name: 'Sample Customer',
        role: 'Business Owner',
        review:
            'Professional communication and a clear approach from consultation to installation.',
        rating: 5,
      ),
      _ReviewData(
        name: 'Sample Customer',
        role: 'Residential Customer',
        review:
            'The team helped us understand our solar requirements and guided us through the process.',
        rating: 5,
      ),
    ];

    return Container(
      width: double.infinity,
      color: AppColors.lightBackground,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 105,
      ),
      child: Column(
        children: [
          const SectionLabel(
            text: 'CUSTOMER FEEDBACK',
          ),

          const SizedBox(height: 16),

          const Text(
            'Trusted Experiences.',
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
            'See what customers value about their solar journey.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.text,
              fontSize: 16,
              height: 1.7,
            ),
          ),

          const SizedBox(height: 14),

          // DEMO NOTICE
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.yellow.withOpacity(0.12),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AppColors.yellow.withOpacity(0.35),
              ),
            ),
            child: const Text(
              'DEMO • REPLACE WITH ACTUAL CUSTOMER REVIEWS',
              style: TextStyle(
                color: AppColors.navy,
                fontSize: 9,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.7,
              ),
            ),
          ),

          const SizedBox(height: 50),

          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 750;

              if (isMobile) {
                return Column(
                  children: reviews
                      .map(
                        (review) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: _ReviewCard(
                            review: review,
                          ),
                        ),
                      )
                      .toList(),
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: reviews
                    .map(
                      (review) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: review == reviews.last ? 0 : 22,
                          ),
                          child: _ReviewCard(
                            review: review,
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
// REVIEW DATA
// =====================================================================

class _ReviewData {
  final String name;
  final String role;
  final String review;
  final int rating;

  const _ReviewData({
    required this.name,
    required this.role,
    required this.review,
    required this.rating,
  });
}

// =====================================================================
// REVIEW CARD
// =====================================================================

class _ReviewCard extends StatefulWidget {
  final _ReviewData review;

  const _ReviewCard({
    required this.review,
  });

  @override
  State<_ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<_ReviewCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final review = widget.review;

    return MouseRegion(
      cursor: SystemMouseCursors.basic,
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
          _hovered ? -6 : 0,
          0,
        ),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _hovered
                ? AppColors.yellow.withOpacity(0.35)
                : Colors.black.withOpacity(0.045),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy.withOpacity(
                _hovered ? 0.11 : 0.055,
              ),
              blurRadius: _hovered ? 28 : 20,
              offset: Offset(
                0,
                _hovered ? 14 : 8,
              ),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP ROW
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.yellow.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.format_quote_rounded,
                    color: AppColors.navy,
                    size: 25,
                  ),
                ),

                const Spacer(),

                Row(
                  children: List.generate(
                    review.rating,
                    (index) => const Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: Icon(
                        Icons.star_rounded,
                        color: AppColors.yellow,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // REVIEW
            Text(
              '"${review.review}"',
              style: const TextStyle(
                color: AppColors.navy,
                fontSize: 15,
                height: 1.7,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 25),

            Container(
              height: 1,
              color: AppColors.navy.withOpacity(0.07),
            ),

            const SizedBox(height: 20),

            // CUSTOMER
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.navy,
                        AppColors.darkNavy,
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.yellow,
                    size: 22,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.name,
                        style: const TextStyle(
                          color: AppColors.navy,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        review.role,
                        style: const TextStyle(
                          color: AppColors.text,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.verified_outlined,
                  color: AppColors.yellow,
                  size: 19,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}