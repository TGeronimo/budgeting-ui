import 'package:flutter/material.dart';
import 'package:flutter_app_test/widgets/option_card.dart';

class MenuColumnLayout extends StatelessWidget {
  final BoxConstraints constraints;

  MenuColumnLayout({
    super.key,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200
          ),
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight
          ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              children: [
                OptionCard( //TODO OptionCard variando de tamanho, conforme o texto.
                  onTap: () {
                    Navigator.pushNamed(context, '/register-transaction-page');
                  },
                  icon: Icons.mic,
                  title: 'Registrar transação',
                ),
                OptionCard(
                  onTap: () {
                    Navigator.pushNamed(context, '/get-transactions-page');
                  },
                  icon: Icons.list,
                  title: 'Consultar transações')
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}