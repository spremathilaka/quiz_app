import 'package:flutter/material.dart';
import './quiz_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.greenAccent,
      child: InkWell(
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => QuizPage())),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                 "Lets quizz",style: TextStyle(color: Colors.white,fontSize: 50.0,fontWeight: FontWeight.bold),
              ),
              Text(
                "Tap to Start!",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
