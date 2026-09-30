import 'package:flutter/material.dart';
import 'package:flutter_app_test/features/transactions/cubit/audio_session_cubit.dart';
import 'package:flutter_app_test/features/transactions/widgets/base_transaction_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorStateWidget extends StatelessWidget {
  final String _errorMessage;

  const ErrorStateWidget({
    super.key,
    required this._errorMessage
  });

  @override
  Widget build(BuildContext context) {
    return BaseTransactionLayout(
      message: _errorMessage,
      iconData: Icons.cancel_rounded,
      onPressed: null,
      secondaryButton: Column(
        children: [
          FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () => context.read<AudioSessionCubit>().reset(), // TBD reset()),
            child: Icon(Icons.cancel_rounded),
          ),
          SizedBox(height: 16),
          Text('Descartar despesa'),
        ],
      ),
    );
  }
}