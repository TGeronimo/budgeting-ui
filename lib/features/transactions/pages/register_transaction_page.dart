import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_test/features/transactions/widgets/temp/transaction_state_dev_panel.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

import '../../auth/pages/enum_transaction_page_state.dart';

class RegisterTransactionPage extends StatefulWidget {

  const RegisterTransactionPage({super.key});


  @override
  State createState() => _RegisterTransactionPageState();

}

class _RegisterTransactionPageState extends State<RegisterTransactionPage> {
  late AudioRecorder _audioRecorder;
  EnumTransactionPageState _currentState = EnumTransactionPageState.idle;
  Directory? _tempDirectory;
  String? _recordedFilePath;


  @override
  void initState() {
    super.initState();
    _audioRecorder = AudioRecorder();
  }

  Future<void> _checkPermission() async {
    debugPrint("Botão pressionado");
    final hasPermission = await _audioRecorder.hasPermission();
    debugPrint('Permissão: $hasPermission');

    if(hasPermission) {
      setState(() {
        _currentState = EnumTransactionPageState.recording;
      });
      await _startRecording();
      debugPrint('Mudando para estado: $_currentState');

    } else {
      setState(() {
        _currentState = EnumTransactionPageState.error;
      });
      debugPrint('Mudando para estado: $_currentState');
    }
  }

  Future<void> _startRecording() async {
    _tempDirectory = await getTemporaryDirectory();
    final tempDirPath = _tempDirectory!.path;
    final audioPath = '$tempDirPath/transaction.wav';

    await _audioRecorder.start(RecordConfig(encoder: AudioEncoder.wav), path: audioPath);
    debugPrint('Gravação iniciada...');
  }


  Future<void> _stopRecording() async {
    _recordedFilePath = await _audioRecorder.stop();
    debugPrint("Arquivo gravado em: $_recordedFilePath");
    setState(() {
      _currentState = EnumTransactionPageState.idle;
    });
    final file = File(_recordedFilePath!);

    debugPrint(
      'Tamanho: ${await file.length()} bytes',
    );
  }

  @override
  Widget build(BuildContext context) {
    return TransactionStateDevPanel(
        checkPermission: _checkPermission,
        stopRecording: _stopRecording,
        currentState:  _currentState);
  }

  @override
  void dispose() {
    super.dispose();
    _audioRecorder.dispose();
  }
}
