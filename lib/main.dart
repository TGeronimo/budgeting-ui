import 'package:flutter/material.dart';
import 'package:flutter_app_test/routes.dart';

void main() {
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

