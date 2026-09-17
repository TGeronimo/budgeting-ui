import 'package:flutter/material.dart';

class ProcessingStateWidget extends StatefulWidget{
  @override
  State createState() => _ProcessingStateWidgetState();

}

class _ProcessingStateWidgetState extends State<ProcessingStateWidget> {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Processing state"),
          SizedBox(height: 24,),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/register_transaction_page'),
              child: Text("BACK")),
        ],
      ),
    );
  }
}