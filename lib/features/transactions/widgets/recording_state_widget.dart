import 'package:flutter/material.dart';

class RecordingStateWidget extends StatefulWidget{


  @override
  State createState() => _RecordingStateWidgetState();

}

  class _RecordingStateWidgetState extends State<RecordingStateWidget>{
    @override
    Widget build(BuildContext context) {
      return Center(
        child: Column(
          children: [
            Text("Recording state"),
            SizedBox(height: 24,),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/register_transaction_page'),
                child: Text("BACK")),
          ],
        ),
      );
    }
  }
