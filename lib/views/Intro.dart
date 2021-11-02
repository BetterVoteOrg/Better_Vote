import 'package:better_vote/views/Login.dart';
import 'package:better_vote/views/Signup.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset('images/intro_bg.png',
              fit: BoxFit.cover),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 200,
                    child:
                      TextButton(
                        child: Text('Sign Up'),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          onSurface: Colors.grey,
                          shape: StadiumBorder(),
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'BebasNeue',
                            fontSize: 40,
                            letterSpacing: 8.0
                          ),
                        ),
                        onPressed: () {
                          //print('Pressed');
                          _navigateToSignUp(context);
                        }

                      )
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    height: 60,
                    width: 170,
                    child:
                      TextButton(
                        child: Text('Log In'),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          onSurface: Colors.grey,
                          shape: StadiumBorder(),
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'BebasNeue',
                            fontSize: 40,
                            letterSpacing: 8.0
                          ),
                        ),
                        onPressed: () {
                          //print('Pressed');
                          _navigateToNextScreen(context);
                          
                        }

                      )
                  )
                ],
              )
            )
          ],

        )
      )
    );
  }
}

void _navigateToNextScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
}

void _navigateToSignUp(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupPage()));
}