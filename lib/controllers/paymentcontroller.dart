import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ihm/constants/app_constants.dart';
import 'package:ihm/constants/controllers.dart';
import 'package:ihm/constants/fire_base_constants.dart';
import 'package:ihm/models/payment.dart';
import 'package:ihm/screens/payments/payment.dart';
import 'package:ihm/widgets/global_widgets/custom_text.dart';
import 'package:stripe_payment/stripe_payment.dart';

import 'package:uuid/uuid.dart';

class PaymentsController extends GetxController {
  static PaymentsController instance = Get.find();

  String collection = "payments";
  List<PaymentsModel> payments = [];
  //String url = 'example://stripe-redirect';

  @override
  void onReady() {
    super.onReady();
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51KXDEkFHzmJTFbQozobUDppH2UrCaB5ZisIoR5HQoDwsaw7UE297tic8lTneVAo9T44Mc1UmvcSDhlGc3mg3kDNB00bXzFFF12",
        androidPayMode: 'test'));
  }

  /* Future<void> createPaymentMethod() async {
   
    StripePayment.setStripeAccount("acct_1KXDEkFHzmJTFbQo");
    //step 1: add card
    PaymentMethod paymentMethod = PaymentMethod();
    paymentMethod = await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    ).then((PaymentMethod paymentMethod) {
      return paymentMethod;
    }).catchError((e) {
      print('Error Card: ${e.toString()}');
    });
    paymentMethod != null
        ? processPaymentAsDirectCharge(paymentMethod)
        : _showPaymentFailedAlert();
    //dismissLoadingWidget();
  }*/
  Future<void> createPaymentMethod() async {
    logger.i("length ${payments.length}");
    StripePayment.setStripeAccount("acct_1KXDEkFHzmJTFbQo");
    //step 1: add card
    PaymentMethod paymentMethod = PaymentMethod();
    paymentMethod = await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    ).then((PaymentMethod paymentMethod) {
      return paymentMethod;
    }).catchError((e) {
      print('Error Card: ${e.toString()}');
    });
    paymentMethod != null
        ? processPaymentAsDirectCharge(paymentMethod)
        : _showPaymentFailedAlert();
    //dismissLoadingWidget();
  }

  Future<void> processPaymentAsDirectCharge(PaymentMethod paymentMethod) async {
    //showLoading();

    try {
      int amount = (double.parse(
                  cartController.totalCartPrice.value.toStringAsFixed(2)) *
              100)
          .toInt();
      //step 2: request to create PaymentIntent, attempt to confirm the payment & return PaymentIntent
      const response = "succeed";
      print('Now i decode');
      if (true) {
        const paymentIntentX = response;
        const status = paymentIntentX;
        if (status == 'succeeded') {
          StripePayment.completeNativePayRequest();
          _addToCollection(status, paymentMethod.id);
          userController.updateUserData({"cart": []});
          Get.snackbar("Success", "Payment succeeded");
        } else {
          _addToCollection(status, paymentMethod.id);
        }
      } /*else {
        //case A
        StripePayment.cancelNativePayRequest();
        _showPaymentFailedAlert();
      }*/
    } catch (e) {
      Get.snackbar("eroor", e.toString(),
          duration: const Duration(seconds: 60));
    }
  }

  getPaymentHistory() {
    //showLoading();
    payments.clear();
    firebaseFirestore
        .collection(collection)
        .where("clientId", isEqualTo: userController.userModel.value.id)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        PaymentsModel payment =
            PaymentsModel.fromDocumentSnapshot(documentSnapshot: doc);
        payments.add(payment);
      }

      logger.i("length ${payments.length}");
      //dismissLoadingWidget();
      Get.to(() => PaymentsScreen());
    });
  }

  void _showPaymentFailedAlert() {
    Get.defaultDialog(
        content: const CustomText(
          text: "Payment failed, try another card",
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomText(
                  text: "Okay",
                ),
              ))
        ]);
  }

  _addToCollection(String paymentStatus, paymentId) {
    String id = const Uuid().v1();
    firebaseFirestore.collection(collection).doc(id).set({
      "id": id,
      "clientId": userController.userModel.value.id,
      "status": paymentStatus,
      "paymentId": paymentId,
      "cart": userController.userModel.value.cartItemsToJson(),
      "amount": cartController.totalCartPrice.value.toStringAsFixed(2),
      "createdAt": DateTime.now().microsecondsSinceEpoch,
    });
  }
}
