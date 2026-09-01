// mapeamento de rotas para as telas
import 'package:flutter/material.dart';
import 'package:flutter_app_test/pages/landing_page.dart';
import 'package:flutter_app_test/pages/log_in_page.dart';
import 'package:flutter_app_test/pages/sign_up_page.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/':              (context) => LandingPage(),
    '/sign_up_page':  (context) => SignUpPage(),
    '/log_in_page':    (context) => LogInPage(),
  };
}
