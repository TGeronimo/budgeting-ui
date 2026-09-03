import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icon;

  const OptionCard({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 180,
        width: 180,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 41, 55, 210),
          border: Border.all(
            color: const Color.fromARGB(255, 161, 195, 246).withValues(alpha: 0.8),
            width: 1.5,
          ),
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 28, 101, 227),
              const Color.fromARGB(255, 15, 51, 147),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.7),
              offset: Offset(-6, -6),
              blurRadius: 12,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              offset: Offset(8, 8),
              blurRadius: 25,
              spreadRadius: 2,
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.25),
              offset: Offset(-2, -2),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(42),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 48,
              color: const Color.fromARGB(220, 255, 255, 255),
              shadows: [
                BoxShadow(
                  color: const Color.fromARGB(255, 251, 253, 255),
                  blurRadius: 12,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!
                .copyWith(color: Colors.white,
                  fontWeight: FontWeight.w500),
                ),
          ],
        ),
      ),
    );
  }

}