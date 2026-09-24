import 'package:flutter/material.dart';

class BaseTransactionLayout extends StatelessWidget {
  final String message;
  final IconData iconData;
  final VoidCallback? onPressed;
  final Widget? secondaryButton;

  const BaseTransactionLayout({
    super.key,
    required this.message,
    required this.iconData,
    required this.onPressed,
    required this.secondaryButton,
});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 161, 195, 246),
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 48, vertical: 48),
            child: Column(
              children: [
                Text(message),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Color.fromARGB(255, 1, 10, 73)
                    ),
                    onPressed: onPressed,
                    child: Icon(iconData),
                ),
                if (secondaryButton != null) ...[
                  const SizedBox(height: 24),
                  secondaryButton!,
                ]
              ],
            ),
          ),
      ),
    );
  }
}