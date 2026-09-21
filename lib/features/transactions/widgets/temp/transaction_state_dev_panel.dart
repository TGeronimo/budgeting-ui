import 'package:flutter/material.dart';

import '../../../auth/pages/enum_transaction_page_state.dart';
import '../error_state_widget.dart';
import '../idle_state_widget.dart';
import '../playing_state_widget.dart';
import '../processing_state_widget.dart';
import '../recording_state_widget.dart';

class TransactionStateDevPanel extends StatefulWidget {

  final VoidCallback checkPermission;
  EnumTransactionPageState currentState;

  TransactionStateDevPanel({
    required this.checkPermission,
    required this.currentState
  });

  @override
  State createState() => _TransactionStateDevPanelState();
}

class _TransactionStateDevPanelState extends State<TransactionStateDevPanel>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      switch (widget.currentState) {
        EnumTransactionPageState.idle => IdleStateWidget(checkPermission: widget.checkPermission),
        EnumTransactionPageState.recording => RecordingStateWidget(),
        EnumTransactionPageState.processing => ProcessingStateWidget(),
        EnumTransactionPageState.playing => PlayingStateWidget(),
        EnumTransactionPageState.error => ErrorStateWidget(),
      },
      persistentFooterButtons: [
        FloatingActionButton.small(
          onPressed: () {
            setState(() {
              widget.currentState = EnumTransactionPageState.recording;
            });
          },
          child: Icon(Icons.mic_rounded),
        ),
        FloatingActionButton.small(
          onPressed: () {
            setState(() {
              widget.currentState = EnumTransactionPageState.playing;
            });
          },
          child: Icon(Icons.play_arrow_rounded),
        ),
        FloatingActionButton.small(
          onPressed: () {
            setState(() {
              widget.currentState = EnumTransactionPageState.processing;
            });
          },
          child: Icon(Icons.check_rounded),
        ),
        FloatingActionButton.small(
          onPressed: () {
            setState(() {
              widget.currentState = EnumTransactionPageState.error;
            });
          },
          child: Icon(Icons.error_rounded),
        ),
        FloatingActionButton.small(
          onPressed: () {
            setState(() {
              widget.currentState = EnumTransactionPageState.idle;
            });
          },
          child: Icon(Icons.close_rounded),
        ),
      ],
    );

  }
}