import 'package:flutter/material.dart';

import 'auth_background.dart';
import 'auth_card.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout ({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: AuthCard(
        child: child,
      ),
    );//
  }
}