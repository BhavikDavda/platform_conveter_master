import 'dart:async';

import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5),(){
      Navigator.of(context).pushReplacementNamed("HomeScreen");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  "https://cdn.dribbble.com/users/2426801/screenshots/5914622/media/fc61cb35d90a3d89b6367690966ba38b.jpg?resize=400x300&vertical=center",
                  height: 800,
                  width: 700,
                ),
              ),
              CircularProgressIndicator(),
              Text("Contacts App",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),)
            ],
          ),
        )

    );
  }
}
