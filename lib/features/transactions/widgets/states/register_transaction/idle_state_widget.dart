import 'package:flutter/material.dart';
import 'package:flutter_app_test/features/transactions/cubit/audio_session_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../base_transaction_layout.dart';

class IdleStateWidget extends StatelessWidget {

  const IdleStateWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return BaseTransactionLayout(
      message: 'Clique no microfone para registrar uma nova despesa',
      iconData: Icons.mic_rounded,
      onPressed: () => context.read<AudioSessionCubit>().startRecording(),

      secondaryButton: null,
    );
  }
}
