import 'package:flutter/material.dart';
import 'package:flutter_app_test/core/dio/dio_client.dart';
import 'package:flutter_app_test/features/auth/services/token_storage.dart';
import 'package:flutter_app_test/features/transactions/cubit/get_category_cubit.dart';
import 'package:flutter_app_test/features/transactions/cubit/get_category_state.dart';
import 'package:flutter_app_test/features/transactions/pages/register_transaction_page.dart';
import 'package:flutter_app_test/features/transactions/widgets/get_transaction_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetTransactionsPage extends StatelessWidget {
  const GetTransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: ((didPop, result) {
        // Força o fechamento do teclado no gesto de voltar
        FocusManager.instance.primaryFocus?.unfocus();
      }),
      child: BlocProvider(
        create: (context) {
          final dioClient = DioClient(TokenStorage());
          final dio = dioClient.dio;
          return GetCategoryCubit();
        },
        child: _GetTransactionView(),
      ),
    );
  }
}

class _GetTransactionView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetCategoryCubit, GetCategoryState>(
        listener: (context, state) {
          // O Listener trata apenas EFEITOS COLATERAIS (SnackBars, Alertas, Navegação)
          if (state is GetCategoryError) {
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
  Widget _buildBodyByState(GetCategoryState state) {
    return switch (state) {
      GetCategoryIdle() => GetTransactionLayout(),
      // GetCategoryLoading() => const RecordingStateWidget(),
      // GetCategoryError(message: final msg) => ErrorStateWidget(errorMessage: msg),
      _ => const SizedBox.shrink(),
    };
  }
}