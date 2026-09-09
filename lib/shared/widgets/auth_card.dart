import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  final Widget child;


  const AuthCard({
    super.key,
    required this.child,

  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
            padding: const EdgeInsets.all(32),
            child: child,

        ),

    );
  }

}