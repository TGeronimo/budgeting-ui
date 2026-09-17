import 'package:flutter/material.dart';

class IdleStateWidget extends StatefulWidget {

  @override
  State createState() => _IdleStateWidgetState();
}

class _IdleStateWidgetState extends State<IdleStateWidget> {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Idle state"),
          SizedBox(height: 24,),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/register_transaction_page'),
              child: Text("BACK")),
        ],
      ),
    );
  }
}