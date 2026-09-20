import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../pages/quotation_page.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Logout',
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Admin',
              style: TextStyle(
                color: AppColors.navy,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Manage your solar business from here.',
              style: TextStyle(
                color: AppColors.navy.withOpacity(0.60),
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 30),

            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 700;

                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: isMobile ? 1 : 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: isMobile ? 2.8 : 2.2,
                  children: [
                    _DashboardCard(
                      icon: Icons.request_quote_outlined,
                      title: 'Generate Quotation',
                      subtitle: 'Create a new solar quotation',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuotationPage(),
                          ),
                        );
                      },
                    ),

                    _DashboardCard(
                      icon: Icons.receipt_long_outlined,
                      title: 'Quotations',
                      subtitle: 'View generated quotations',
                      onTap: () {
                        // Quotations page will be added later
                      },
                    ),

                    _DashboardCard(
                      icon: Icons.people_outline_rounded,
                      title: 'Customers',
                      subtitle: 'Manage customer details',
                      onTap: () {
                        // Customers page will be added later
                      },
                    ),

                    _DashboardCard(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      subtitle: 'Manage admin settings',
                      onTap: () {
                        // Settings page will be added later
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: AppColors.yellow.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: AppColors.navy, size: 28),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      subtitle,
                      style: TextStyle(
                        color: AppColors.navy.withOpacity(0.55),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
