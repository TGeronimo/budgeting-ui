import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app_test/features/transactions/cubit/audio_session_state.dart';
import 'package:flutter_app_test/features/transactions/services/transaction_ai_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioSessionCubit extends Cubit<AudioSessionState> {
  final AudioRecorder _audioRecorder;

  Directory? _tempDirectory;

  AudioSessionCubit({
    TransactionAiService? aiService,
    AudioRecorder? audioRecorder,
  }) :  _audioRecorder = audioRecorder ?? AudioRecorder(),
        super(AudioSessionIdle());


  Future<void> startRecording() async {
    try {
      final hasPermission = await _audioRecorder.hasPermission();
      debugPrint('Permissão: $hasPermission');

      if(!hasPermission) {
        emit(AudioSessionError(
            message: 'Permissão de microfone negada.',
            canRetry: false
        ));
        return;
      }

      _tempDirectory = await getTemporaryDirectory();
      final tempDirPath = _tempDirectory!.path;
      final audioPath = '$tempDirPath/transaction.wav';

      await _audioRecorder.start(
          RecordConfig(encoder: AudioEncoder.wav),
          path: audioPath,
      );
      debugPrint('Gravação iniciada no caminho: $audioPath');
      emit(AudioSessionRecording());

    } catch (e) {
      debugPrint('Erro ao iniciar gravação: $e');
      emit(AudioSessionError(
          message: 'Ocorreu um erro ao tentar iniciar a gravação',
          canRetry: true,
      ));
    }
  }

  @override
  Future<void> close() {
    _audioRecorder.dispose();
    return super.close();
  }


}