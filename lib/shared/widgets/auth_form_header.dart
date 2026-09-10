import 'package:flutter/material.dart';

class AuthFormHeader extends StatelessWidget {
  final String infoText;
  final IconData icon;

  const AuthFormHeader({
    super.key,
    required this.infoText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.account_balance_wallet_rounded,
              size: 36,
              color: Colors.blueAccent,
            ),
            const SizedBox(width: 8),
            const Text("Budgeting",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 32,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Icon(
          icon,
          size: 48,
          color: Colors.blueAccent,
        ),
        SizedBox(height: 8),
        Text(
          infoText,
          style: TextStyle(
            color: Colors.black54,
            ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}