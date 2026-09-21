import 'package:flutter/material.dart';
import 'package:flutter_app_test/features/transactions/widgets/temp/transaction_state_dev_panel.dart';
import 'package:record/record.dart';

import '../../auth/pages/enum_transaction_page_state.dart';

class RegisterTransactionPage extends StatefulWidget {

  const RegisterTransactionPage({super.key});


  @override
  State createState() => _RegisterTransactionPageState();

}

class _RegisterTransactionPageState extends State<RegisterTransactionPage> {
  late AudioRecorder _audioRecorder;
  EnumTransactionPageState _currentState = EnumTransactionPageState.idle;



  @override
  void initState() {
    super.initState();
    _audioRecorder = AudioRecorder();
  }


  @override
  void dispose() {
    super.dispose();
    _audioRecorder.dispose();
  }

  Future<void> _checkPermission() async {
    debugPrint("Botão pressionado");
    final hasPermission = await _audioRecorder.hasPermission();
    debugPrint('Permissão: $hasPermission');

    if(hasPermission) {
      setState(() {
        _currentState = EnumTransactionPageState.recording;
      });
      debugPrint('Mudando para estado: $_currentState');
    } else {
      setState(() {
        _currentState = EnumTransactionPageState.error;
      });
      debugPrint('Mudando para estado: $_currentState');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TransactionStateDevPanel(
        checkPermission: _checkPermission,
        currentState:  _currentState);
  }
}
