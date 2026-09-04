import 'package:flutter/material.dart';
import 'package:flutter_app_test/shared/widgets/menu_row_layout.dart';
import 'package:flutter_app_test/shared/widgets/menu_column_layout.dart';

class MenuPage extends StatelessWidget {
  MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return MenuColumnLayout(constraints: constraints);
              } else {
                return MenuRowLayout(constraints: constraints);
              }
            },
          ),
        ),
    );
    
  }

}