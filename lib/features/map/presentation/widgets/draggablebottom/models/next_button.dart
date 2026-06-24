import 'package:flutter/material.dart';
import 'package:my_taxi/core/colors/app_colors.dart';

class NextButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const NextButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
        ),
        child: Text(label),
      ),
    );
  }
}
