import 'package:flutter/material.dart';
import 'package:flutter_app_test/services/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Fix an issue when using read() in Secure Storage.
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: Routes.routes,
        debugShowCheckedModeBanner: false,
      );
  }

}

