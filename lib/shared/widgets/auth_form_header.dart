import 'package:flutter/material.dart';
import 'package:flutter_app_test/shared/widgets/auth_banner.dart';

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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AuthBanner(),
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