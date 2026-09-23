import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/transaction_ai_service.dart';
import 'audio_session_state.dart';

class AudioSessionCubit extends Cubit<AudioSessionState> {
  final TransactionAiService _aiService;
  // Aqui futuramente injetaremos o AudioRecorderService e AudioPlayerService

  AudioSessionCubit({
    required TransactionAiService aiService,
  })  : _aiService = aiService,
        super(AudioSessionIdle());

  /// Inicia a gravação de áudio
  Future<void> startRecording() async {
    try {
      // 1. Verificar/solicitar permissão de áudio via Service
      // 2. Iniciar gravação física do arquivo
      emit(AudioSessionRecording());
    } catch (e) {
      emit(AudioSessionError(
        message: 'Falha ao iniciar gravação. Verifique as permissões de microfone.',
      ));
    }
  }

  /// Interrompe a gravação e envia ao backend
  Future<void> stopAndUpload(String path) async {
    emit(AudioSessionProcessing());

    try {
      final audioFile = File(path);
      if (!await audioFile.exists()) {
        emit(AudioSessionError(message: 'Arquivo de áudio não encontrado.'));
        return;
      }

      // Envia o áudio multipart via Dio para o backend Spring
      final File responseAudio = await _aiService.sendAudioTransaction(audioFile);

      // Transiciona para o estado de reprodução
      emit(AudioSessionPlaying(responseAudio));
    } catch (e) {
      emit(AudioSessionError(
        message: 'Erro ao processar áudio no servidor. Deseja tentar novamente?',
        canRetry: true,
      ));
    }
  }

  /// Cancela o fluxo atual e volta para o estado inicial
  void reset() {
    emit(AudioSessionIdle());
  }
}