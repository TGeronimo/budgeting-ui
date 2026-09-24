import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_test/features/transactions/cubit/audio_session_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../base_transaction_layout.dart';

class PlayingStateWidget extends StatelessWidget {
  final File audioFile;

  const PlayingStateWidget({
    super.key,
    required this.audioFile
  });

  @override
  Widget build(BuildContext context) {
    return BaseTransactionLayout(
      message: 'Clique para reproduzir',
      iconData: Icons.play_arrow_rounded,
      onPressed: () => context.read<AudioSessionCubit>().play(audioFile), // TBD play()
      secondaryButton: Text('Reproduzindo...'),
    );
  }
}