import 'package:flutter/material.dart';
import 'package:flutter_app_test/shared/widgets/auth_banner.dart';
import 'package:flutter_app_test/shared/widgets/auth_card.dart';
import 'package:flutter_app_test/shared/widgets/auth_form_header.dart';
import 'package:flutter_app_test/shared/widgets/auth_layout.dart';

class LandingPage extends StatelessWidget {
  
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 161, 195, 246).withValues(alpha: 0.8),
        body: AuthLayout(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthBanner(), // TODO Fix Render overflow on mobile and desktop
                  SizedBox(
                    height: 48,
                  ),
                  SizedBox(
                    width: 200,
                    child: SizedBox(
                      width: 48.0,
                      height: 48.0,
                      child: ElevatedButton(
                        onPressed: () {Navigator.pushNamed(context, '/sign_up_page');},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(4),
                          backgroundColor: Color.fromARGB(255, 1, 35, 88),
                        ),
                        child: Text(
                          "Sign-up", // TODO fix text cover on mobile
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight(600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12,),
                  SizedBox(width: 200,
                    child: SizedBox(
                      width: 48.0,
                      height: 48.0,
                      child: ElevatedButton(
                        onPressed: () {Navigator.pushNamed(context, '/log_in_page');},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(4),
                          backgroundColor: Colors.blueAccent,
                        ),
                            child: Text(
                              "Log-in", // TODO fix text cover on mobile
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight(600),
                              ),
                            ),
                      ),
                    ),
                  ),
                ],),
        ) 
      );
  }
  
  
}