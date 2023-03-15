import 'dart:async';
import 'package:flutter/material.dart';
import 'package:makeb/ui/homeScreen/home_screen.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    getHomeScreen();
  }
  void getHomeScreen() async {
      Timer(
          Duration(seconds: 3),
              () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
            child: Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                child: Image.asset("assets/splash.jpg",fit: BoxFit.fill,width: deviceWidth,),
              ),
            ));
  }
}
