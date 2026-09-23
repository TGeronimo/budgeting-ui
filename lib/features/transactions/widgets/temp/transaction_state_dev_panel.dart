import 'package:flutter/material.dart';
import 'package:flutter_app_test/features/transactions/cubit/audio_session_state.dart';

import '../../../auth/pages/enum_transaction_page_state.dart';
import '../states/error_state_widget.dart';
import '../idle_state_widget.dart';
import '../playing_state_widget.dart';
import '../states/processing_state_widget.dart';
import '../recording_state_widget.dart';

class TransactionStateDevPanel extends StatefulWidget {

  final VoidCallback? checkPermission;
  final VoidCallback? stopRecording;
  AudioSessionState currentState;

  TransactionStateDevPanel({
    this.checkPermission,
    this.stopRecording,
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
        AudioSessionIdle() => IdleStateWidget(checkPermission: widget.checkPermission),
        AudioSessionRecording() => RecordingStateWidget(stopRecording: widget.stopRecording),
        AudioSessionProcessing() => ProcessingStateWidget(),
        AudioSessionPlaying(responseAudio: responseAudio) => PlayingStateWidget(),
        AudioSessionError(message: message) => ErrorStateWidget(),
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