import 'package:flutter/material.dart';
import 'package:flutter_app_test/features/auth/pages/enum_transaction_page_state.dart';

import 'package:record/record.dart';

import '../widgets/error_state_widget.dart';
import '../widgets/idle_state_widget.dart';
import '../widgets/playing_state_widget.dart';
import '../widgets/processing_state_widget.dart';
import '../widgets/recording_state_widget.dart';

class RegisterTransactionPage extends StatefulWidget {

  const RegisterTransactionPage({super.key});


  @override
  State createState() => _RegisterTransactionPageState();

}

class _RegisterTransactionPageState extends State<RegisterTransactionPage> {
  EnumTransactionPageState _currentState = EnumTransactionPageState.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      switch (_currentState) {
        EnumTransactionPageState.idle => IdleStateWidget(),
        EnumTransactionPageState.recording => RecordingStateWidget(),
        EnumTransactionPageState.processing => ProcessingStateWidget(),
        EnumTransactionPageState.playing => PlayingStateWidget(),
        EnumTransactionPageState.error => ErrorStateWidget(),
      },
      persistentFooterButtons: [
        FloatingActionButton.small(
            onPressed: () {
                setState(() {
                  _currentState = EnumTransactionPageState.recording;
                });
        },
        child: Icon(Icons.mic_rounded),
        ),
        FloatingActionButton.small(
            onPressed: () {
                setState(() {
                  _currentState = EnumTransactionPageState.playing;
                });
        },
        child: Icon(Icons.play_arrow_rounded),
        ),
        FloatingActionButton.small(
            onPressed: () {
                setState(() {
                  _currentState = EnumTransactionPageState.processing;
                });
        },
        child: Icon(Icons.check_rounded),
        ),
        FloatingActionButton.small(
            onPressed: () {
                setState(() {
                  _currentState = EnumTransactionPageState.error;
                });
        },
        child: Icon(Icons.error_rounded),
        ),
        FloatingActionButton.small(
            onPressed: () {
                setState(() {
                  _currentState = EnumTransactionPageState.idle;
                });
        },
        child: Icon(Icons.close_rounded),
        ),
      ],
    );
  }
}
