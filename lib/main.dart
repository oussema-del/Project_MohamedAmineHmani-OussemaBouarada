import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:ihm/controllers/auth_controller.dart';
import 'package:ihm/screens/signup.dart';

import 'constants/fire_base_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization.then((value) => Get.put(AuthController()));
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}
/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization;
  Get.put(AuthController());

  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}*/

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignUp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
