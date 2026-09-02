import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 161, 195, 246).withValues(alpha: 0.8),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 200,
                child: ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/sign_up_page');}, 
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                      backgroundColor: Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),),
                    child: Text(
                      "Sign-up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight(600),
                      ),
                    ),
                  ),
              ),
              SizedBox(height: 12,),
              SizedBox(width: 200,
                child: ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/log_in_page');},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),),
                        child: Text(
                          "Log-in",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight(600),
                          ),
                        ),
                ),
              ),
            ],),
        ) 
      );
  }
  
  
}