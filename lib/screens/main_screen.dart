import 'package:flutter/material.dart';
import 'package:ihm/constants/fire_base_constants.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main screen")),
      body: ElevatedButton(
        onPressed: () async {
          authController.signOut();
        },
        child: Text("signout"),
      ),
    );
  }
}
