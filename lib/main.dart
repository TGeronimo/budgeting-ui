import 'package:flutter/material.dart';
import 'package:flutter_app_test/app/routes.dart';
import 'package:flutter_app_test/app/session_manager.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Fix an issue when using read() in Secure Storage.
  runApp(MyApp());

  SessionManager.instance.onSessionExpired().listen((_) {
    final ctx = navigatorKey.currentContext;

    if (ctx != null) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
            content: Text('Sessão expirada! Faça login novamente.'),
            duration: Duration(seconds: 2,
              ),
        ),
      );

      navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/log_in_page',
          (route) => false,
      );
    }
  });
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        initialRoute: '/',
        routes: Routes.routes,
        debugShowCheckedModeBanner: false,
      );
  }

}

