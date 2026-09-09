import 'package:flutter/material.dart';

class AuthFormHeader extends StatelessWidget {
  final String infoText;

  const AuthFormHeader({
    super.key,
    required this.infoText
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.account_balance_wallet,
          size: 56,
          color: Colors.blueAccent,
        ),
        const SizedBox(height: 16),
        Text("Budgeting",
            style: TextStyle(
                color: Colors.blueAccent,
              ),
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