import 'package:flutter/material.dart';

import '../base_transaction_layout.dart';

class ProcessingStateWidget extends StatelessWidget {

  const ProcessingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseTransactionLayout(
      message: 'Registrando despesa...',
      iconData: Icons.account_balance_wallet_rounded,
      onPressed: null,
      secondaryButton: null,
    );
  }
}
