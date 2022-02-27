import 'package:flutter/material.dart';
import 'package:ihm/widgets/global_widgets/Loading.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo.png", width: 50),
          SizedBox(
            height: 10,
          ),
          Loading()
        ],
      ),
    );
  }
}
