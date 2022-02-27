import 'package:flutter/material.dart';
import 'package:ihm/constants/controllers.dart';
import 'package:ihm/screens/payments/widgets/paymen_widget.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.grey.withOpacity(.1),
        iconTheme:const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        title:const Text(
          "Payment History",
          style:  TextStyle(color: Colors.black),
        ),

      ),
      body: ListView(
        children: [
          Column(
            children:paymentsController.payments.map((payment) => PaymentWidget(paymentsModel: payment,)).toList()
            ,
          )
        ],
      ),
    );
  }


}