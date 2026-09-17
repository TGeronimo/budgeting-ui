import 'package:flutter/material.dart';

class IdleStateWidget extends StatefulWidget {

  @override
  State createState() => _IdleStateWidgetState();
}

class _IdleStateWidgetState extends State<IdleStateWidget> {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Idle state"),
    );
  }
}