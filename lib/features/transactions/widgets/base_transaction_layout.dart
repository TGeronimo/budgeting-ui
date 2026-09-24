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
          child: Center(
            child: SizedBox(
              width: 230,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(message,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 48,),
                  SizedBox(
                    height: 230,
                    width: 230,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.black12,
                            width: 6,
                            strokeAlign: -1,
                          ),
                          shadowColor: Colors.black,
                          elevation: 8,
                          shape: CircleBorder(),
                          backgroundColor: Color.fromARGB(255, 1, 10, 73),
                          // iconSize: 50,
                        ),
                        onPressed: onPressed,
                          child: Icon(
                            iconData,
                            size: 120,
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 100,
                              )
                            ],
                          ),
                        ),
                  ),
                  if (secondaryButton != null) ...[
                    const SizedBox(height: 24),
                    secondaryButton!,
                  ]
                ],
              ),
            ),
          ),
      ),
    );
  }
}