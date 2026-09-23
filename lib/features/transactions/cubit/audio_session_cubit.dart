import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_test/features/transactions/cubit/audio_session_state.dart';
import 'package:flutter_app_test/features/transactions/services/transaction_ai_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioSessionCubit extends Cubit<AudioSessionState> {
  final AudioRecorder _audioRecorder;
  final TransactionAiService _aiService;

  late File _responseAudio;

  AudioSessionCubit({
    AudioRecorder? audioRecorder,
    TransactionAiService? aiService,
  }) :  _audioRecorder = audioRecorder ?? AudioRecorder(),
        _aiService = aiService ?? TransactionAiService(),
        super(AudioSessionIdle()); // define o estado inicial chamando o construtor de Cubit


  Future<void> startRecording() async {
    try {
      // Apaga o arquivo temporário de resposta do servidor
      _safeDeleteFile(_responseAudio);

      final hasPermission = await _audioRecorder.hasPermission();
      debugPrint('Permissão: $hasPermission');

      if(!hasPermission) {
        emit(AudioSessionError(
            message: 'Permissão de microfone negada.',
            canRetry: false
        ));
        return;
      }

      final Directory tempDirectory = await getTemporaryDirectory();
      final audioPath = '${tempDirectory.path}/transaction.wav';

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

  Future<void> stopAndUpload() async {
    try {
      final String? outputAudioPath = await _audioRecorder.stop();
      debugPrint("Arquivo gravado em: $outputAudioPath.");

      if(outputAudioPath == null) {
        emit(AudioSessionError(
            message: 'Não foi possível recuperar o caminho do áudio gravado.',
            canRetry: true,
        ));
        return;
      }

      final audioInput = File(outputAudioPath);
      debugPrint('Tamanho: ${await audioInput.length()} bytes.');

      if (!audioInput.existsSync()) {
        emit(AudioSessionError(
            message: 'Arquivo de áudio gravado não foi localizado no dispositivo.',
            canRetry: true,
        ));
        return;
      }

      emit(AudioSessionProcessing());

      _responseAudio = await _aiService.processAudio(audioInput);
      debugPrint('Áudio de resposta salvo em ${_responseAudio.path}.');

      // Apaga o arquivo temporário de envio do áudio da transação que acaba de ser registrada
      _safeDeleteFile(audioInput);

      emit(AudioSessionPlaying(
          responseAudio: _responseAudio));

    } catch (e) {
      debugPrint('Erro ao finalizar e enviar a gravação: $e');
      emit(AudioSessionError(
        message: 'Ocorreu um erro ao tentar processar seu áudio.',
        canRetry: true,
      ));
    }
  }

  Future<void> _safeDeleteFile(File? file) async {
    if (file != null && await file.exists()) {
      try {
        await file.delete();
        debugPrint('Arquivo temporário removido: ${file.path}');
      } catch (e) {
        debugPrint('Erro ao deletar arquivo temporário: $e');
      }
    }
  }

  @override
  Future<void> close() {
    _audioRecorder.dispose();
    return super.close();
  }

  Widget reset() { // TODO
    throw UnimplementedError();
  }

  VoidCallback? play(File audioFile) { // TODO
    throw UnimplementedError();

  }


}