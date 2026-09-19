import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class WhatsAppButton extends StatelessWidget {
  final VoidCallback onPressed;

  const WhatsAppButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColors.yellow,
      child: const Icon(
        Icons.chat,
        color: AppColors.darkNavy,
      ),
    );
  }
}