import 'package:flutter/material.dart';

class PlayingStateWidget extends StatefulWidget {
  @override
  State createState() => _PlayingStateWidgetState();
}

class _PlayingStateWidgetState extends State<PlayingStateWidget>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Playing state"),
          SizedBox(height: 24,),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/register_transaction_page'),
              child: Text("BACK")),
        ],
      ),
    );
  }
}