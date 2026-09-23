import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/audio_session_cubit.dart';
import '../base_transaction_layout.dart';

class RecordingStateWidget extends StatelessWidget{

  const RecordingStateWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return BaseTransactionLayout(
      message: 'Clique novamente para finalizar',
      iconData: Icons.multitrack_audio,
      onPressed: () => context.read<AudioSessionCubit>().stopAndUpload(),
      secondaryButton: Column(
        children: [
          FloatingActionButton(
              onPressed: () => context.read<AudioSessionCubit>().reset(), // TBD reset()
          ),
          SizedBox(height: 16),
          Text('Cancelar'),
        ],
      ),
    );
  }
}
