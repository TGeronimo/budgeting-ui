import 'package:flutter/material.dart';

class RecordingStateWidget extends StatelessWidget{
  final VoidCallback? _stopRecording;

  const RecordingStateWidget({
    super.key,
    this._stopRecording
  });


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Recording state"),
          SizedBox(height: 24,),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/register_transaction_page'),
              child: Text("BACK"),
          ),
          SizedBox(height: 24,),
          FloatingActionButton(
            onPressed: _stopRecording,
            child: Icon(Icons.mic_rounded),
          )
        ],
      ),
    );
  }
}
