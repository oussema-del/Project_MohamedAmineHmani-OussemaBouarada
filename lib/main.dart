import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:ihm/controllers/auth_controller.dart';
import 'package:ihm/controllers/cart_controller.dart';
import 'package:ihm/controllers/map_controller.dart';
import 'package:ihm/controllers/paymentcontroller.dart';
import 'package:ihm/controllers/product_controller.dart';
import 'package:ihm/screens/authentification/login.dart';
import 'package:ihm/screens/spalsh.dart';

import 'constants/fire_base_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await firebaseInitialization.then((value) => Get.put(AuthController()) =>Get.put( ProducsController()));
  await firebaseInitialization.then((value) {
    Get.put(AuthController());
    Get.put(CartController());
    Get.put(ProducsController());
    Get.put(PaymentsController());
    Get.put(MapController());
  });
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
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
