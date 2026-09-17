import 'package:flutter/material.dart';

class RegisterTransactionPage extends StatefulWidget {

  @override
  State createState() => _RegisterTransactionPageState();

}

class _RegisterTransactionPageState extends State<RegisterTransactionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
