import 'package:flutter/material.dart';
import 'package:flutter_app_test/widgets/option_card.dart';

class MenuRowLayout extends StatelessWidget {
  final BoxConstraints constraints;

  MenuRowLayout({
    super.key,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedContainer(
        color: Color.fromARGB(255, 161, 195, 246).withValues(alpha: 0.8),
        duration: const Duration(milliseconds: 200
          ),
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight
          ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OptionCard(
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