import 'package:get/get.dart';
import 'package:shopingapp/category/loading_indicator.dart';
import 'package:shopingapp/consts/consts.dart';
import 'package:shopingapp/consts/lists.dart';
import 'package:shopingapp/controller/cart_controller.dart';

import '../home_screen/home.dart';
import '../widgets/new_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(()=>
      Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value ? Center(
            child: loadingIndicator(),
          ):ourButton(
            onpress: () async {
             await controller.placeMyOrder(orderPaymentMethod: paymentMethods[controller.paymentIndex.value],
              totalAmount: controller.totalP.value);

             await controller.clearCart();
             VxToast.show(context, msg: "Order placed successfully");
             Get.offAll(const Home());
            },
            color: redColor,
            textColor: whiteColor,
            title: "Place my order",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodList.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: controller.paymentIndex.value == index
                                ? redColor
                                : Colors.transparent,
                            width: 1,
                          )),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset(paymentMethodList[index],
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                              colorBlendMode: controller.paymentIndex.value == index ? BlendMode.darken : BlendMode.color,
                              color: controller.paymentIndex.value == index ? Colors.black.withOpacity(0.3): Colors.transparent,
                          ),
                          controller.paymentIndex.value == index
                              ? Transform.scale(
                                  scale: 1.2,
                                  child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    value: true,
                                    onChanged: (value) {},
                                  ),
                                )
                              : Container(),
                        ],
                      )),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
