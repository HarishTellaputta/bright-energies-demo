
import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/company_info.dart';
import '../admin/admin_page.dart';

class AppNavbar extends StatelessWidget {
  final VoidCallback onHome;
  final VoidCallback onSolutions;
  final VoidCallback onProjects;
  final VoidCallback onAbout;
  final VoidCallback onContact;
  final VoidCallback onAdmin;

  const AppNavbar({
    super.key,
    required this.onHome,
    required this.onSolutions,
    required this.onProjects,
    required this.onAbout,
    required this.onContact,
    required this.onAdmin,
  });

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 25),

                _mobileItem(
                  context,
                  Icons.home_outlined,
                  'Home',
                  onHome,
                ),

                _mobileItem(
                  context,
                  Icons.bolt_outlined,
                  'Solutions',
                  onSolutions,
                ),

                _mobileItem(
                  context,
                  Icons.solar_power_outlined,
                  'Projects',
                  onProjects,
                ),

                _mobileItem(
                  context,
                  Icons.business_outlined,
                  'About Us',
                  onAbout,
                ),

                _mobileItem(
                  context,
                  Icons.phone_outlined,
                  'Contact',
                  onContact,
                ),

                // =========================================================
                // ADMIN
                // =========================================================
                _mobileItem(
                  context,
                  Icons.admin_panel_settings_outlined,
                  'Admin',
                  onAdmin,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _mobileItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.yellow.withOpacity(0.14),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: AppColors.navy,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.navy,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  Widget _navItem(
    String title,
    VoidCallback onTap,
  ) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.navy,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.navy,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.08),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 850;

          return Container(
            height: 82,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 55,
            ),
            child: Row(
              children: [
                // =========================================================
                // LOGO
                // =========================================================
                InkWell(
                  onTap: onHome,
                  borderRadius: BorderRadius.circular(12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.yellow,
                              Color(0xFFFFD45A),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.yellow.withOpacity(0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.wb_sunny_rounded,
                          color: AppColors.navy,
                          size: 27,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BRIGHT ENERGIES',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontSize: isMobile ? 13 : 15,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.7,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'SOLUTIONS',
                            style: TextStyle(
                              color: AppColors.navy.withOpacity(0.58),
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // =========================================================
                // DESKTOP NAVIGATION
                // =========================================================
                if (!isMobile) ...[
                  _navItem('Home', onHome),
                  _navItem('Solutions', onSolutions),
                  _navItem('Projects', onProjects),
                  _navItem('About', onAbout),
                  _navItem('Contact', onContact),

                  const SizedBox(width: 18),

                  // =======================================================
                  // ADMIN BUTTON
                  // =======================================================
                  ElevatedButton.icon(
                    onPressed: onAdmin,
                    icon: const Icon(
                      Icons.admin_panel_settings_outlined,
                      size: 17,
                    ),
                    label: const Text(
                      'Admin',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellow,
                      foregroundColor: AppColors.navy,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 19,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ] else
                  IconButton(
                    onPressed: () => _showMobileMenu(context),
                    icon: const Icon(
                      Icons.menu_rounded,
                      color: AppColors.navy,
                      size: 29,
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

