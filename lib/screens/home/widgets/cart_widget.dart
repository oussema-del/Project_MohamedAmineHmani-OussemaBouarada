import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihm/constants/controllers.dart';
import 'package:ihm/controllers/cart_controller.dart';
import 'package:ihm/models/cart.dart';
import 'package:ihm/widgets/global_widgets/custom_text.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel cartItem;

  CartItemWidget({Key? key, required this.cartItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            cartItem.image,
            width: 80,
          ),
        ),
        Expanded(
            child: Wrap(
          direction: Axis.vertical,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 14),
                child: CustomText(
                  text: cartItem.name,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      cartController.decreaseQuantity(cartItem);
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: cartItem.quantity.toString(),
                  ),
                ),

                /* Obx(
                      () => CustomText(
                        text: cartController.totQuan.toString(),
                      ),
                    )*/

                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      cartController.increaseQuantity(cartItem);
                    }),
              ],
            )
          ],
        )),
        Padding(
          padding: const EdgeInsets.all(14),
          child: CustomText(
            text: cartItem.cost.toStringAsFixed(2),
            size: 22,
            weight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
