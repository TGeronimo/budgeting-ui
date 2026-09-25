import 'package:flutter/material.dart';
import 'package:flutter_app_test/core/dio/dio_client.dart';
import 'package:flutter_app_test/features/auth/services/token_storage.dart';
import 'package:flutter_app_test/features/transactions/cubit/audio_session_cubit.dart';
import 'package:flutter_app_test/features/transactions/cubit/audio_session_state.dart';
import 'package:flutter_app_test/features/transactions/services/transaction_ai_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/states/error_state_widget.dart';
import '../widgets/states/idle_state_widget.dart';
import '../widgets/states/playing_state_widget.dart';
import '../widgets/states/processing_state_widget.dart';
import '../widgets/states/recording_state_widget.dart';

class RegisterTransactionPage extends StatelessWidget {

  const RegisterTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final dioClient = DioClient(TokenStorage());
        final dio = dioClient.dio;
        final aiService = TransactionAiService(dio: dio);
        return AudioSessionCubit(aiService: aiService);
      },
      child: _RegisterTransactionView(),
    );
  }
}

class _RegisterTransactionView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AudioSessionCubit, AudioSessionState>(
        listener: (context, state) {
          // O Listener trata apenas EFEITOS COLATERAIS (SnackBars, Alertas, Navegação)
          if (state is AudioSessionError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                )
            );
          }
        },
        builder: (context, state) {
          // O Builder trata APENAS a construção visual baseada no estado atual
          return Scaffold(
            body: _buildBodyByState(state),
          );
        }
    );
  }

  /// Méthodo auxiliar para retornar o Widget correto com base no estado imutável do Cubit
  Widget _buildBodyByState(AudioSessionState state) {
    return switch (state) {
      AudioSessionIdle() => const IdleStateWidget(),
      AudioSessionRecording() => const RecordingStateWidget(),
      AudioSessionProcessing() => const ProcessingStateWidget(),
      AudioSessionPlaying(responseAudio: final audioFile) => PlayingStateWidget(audioFile: audioFile),
      AudioSessionError(message: final msg) => ErrorStateWidget(errorMessage: msg),
      _ => const SizedBox.shrink(),
    };
  }
}