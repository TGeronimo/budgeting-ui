// mapeamento de rotas para as telas
import 'package:flutter/material.dart';
import 'package:flutter_app_test/app/landing_page.dart';
import 'package:flutter_app_test/features/auth/pages/log_in_page.dart';
import 'package:flutter_app_test/features/transactions/pages/menu_page.dart';
import 'package:flutter_app_test/features/auth/pages/sign_up_page.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/':              (context) => LandingPage(),
    '/sign_up_page':  (context) => SignUpPage(),
    '/log_in_page':    (context) => LogInPage(),
    '/menu_page':(context) => MenuPage(),
    // '/register_transaction_page':(context) => RegisterTransactionPage(),
    // '/get_transactions_page':(context) => GetTransactionsPage(),

    // TODO routing for the new transaction screens.
  };
}
