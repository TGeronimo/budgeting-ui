import 'package:flutter/material.dart';

class AuthBanner extends StatelessWidget{

  const AuthBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
      );
  }


}