import 'package:flutter/material.dart';
import 'package:flutter_app_test/features/auth/pages/enum_transaction_page_state.dart';

import 'package:record/record.dart';

class RegisterTransactionPage extends StatefulWidget {

  const RegisterTransactionPage({super.key});


  @override
  State createState() => _RegisterTransactionPageState();

}

class _RegisterTransactionPageState extends State<RegisterTransactionPage> {
  EnumTransactionPageState currentState = EnumTransactionPageState.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.mic_rounded),
          SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {

              },
              child: Text('Gravar'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {},
              child: Text('Parar'))
          ],
      ),
    );

  }
}
