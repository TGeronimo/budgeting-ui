import 'package:flutter/material.dart';

class ErrorStateWidget extends StatefulWidget {
  @override
  State createState() => _ErrorStateWidgetState();

}

class _ErrorStateWidgetState extends State<ErrorStateWidget> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Error state"),
          SizedBox(height: 24,),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/register_transaction_page'),
              child: Text("BACK")),
        ],
      ),
    );
  }
}