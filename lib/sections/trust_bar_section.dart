import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class TrustBarSection extends StatelessWidget {
  const TrustBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      _TrustItem(
        icon: Icons.verified_outlined,
        title: 'Quality Installation',
        subtitle: 'Built with care',
      ),
      _TrustItem(
        icon: Icons.workspace_premium_outlined,
        title: 'Reliable Solutions',
        subtitle: 'Designed for needs',
      ),
      _TrustItem(
        icon: Icons.support_agent_outlined,
        title: 'Expert Support',
        subtitle: 'Guidance when needed',
      ),
      _TrustItem(
        icon: Icons.energy_savings_leaf_outlined,
        title: 'Energy Focused',
        subtitle: 'Cleaner power',
      ),
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 750;

          if (isMobile) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                children: items
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: _TrustCard(item: item),
                      ),
                    )
                    .toList(),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 55,
              vertical: 16,
            ),
            child: Row(
              children: items
                  .map(
                    (item) => Expanded(
                      child: _TrustCard(
                        item: item,
                        showDivider: item != items.last,
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}

// =====================================================================
// DATA
// =====================================================================

class _TrustItem {
  final IconData icon;
  final String title;
  final String subtitle;

  const _TrustItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

// =====================================================================
// TRUST CARD
// =====================================================================

class _TrustCard extends StatelessWidget {
  final _TrustItem item;
  final bool showDivider;

  const _TrustCard({
    required this.item,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: showDivider
            ? Border(
                right: BorderSide(
                  color: AppColors.navy.withOpacity(0.08),
                ),
              )
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: showDivider ? 35 : 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ICON
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.yellow.withOpacity(0.13),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                item.icon,
                color: AppColors.navy,
                size: 21,
              ),
            ),

            const SizedBox(width: 12),

            // TEXT
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
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