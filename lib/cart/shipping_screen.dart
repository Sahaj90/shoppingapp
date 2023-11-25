import 'package:get/get.dart';
import 'package:shopingapp/cart/payment_method.dart';
import 'package:shopingapp/consts/consts.dart';
import 'package:shopingapp/controller/cart_controller.dart';
import 'package:shopingapp/widgets/custom_textfield.dart';
import 'package:shopingapp/widgets/new_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onpress: (){
            if(controller.addressController.text.length> 10){
              Get.to(()=> const PaymentMethods());
            }else{
              VxToast.show(context, msg: "Please fill the details");
            }

          },
          color: redColor,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(hint:"Address",isPass: false, title: "Address",controller: controller.addressController),
            customTextField(hint:"City",isPass: false, title: "City",controller: controller.cityController),
            customTextField(hint:"State",isPass: false, title: "State",controller: controller.stateController),
            customTextField(hint:"Postal code",isPass: false, title: "Postal code",controller: controller.postalcodeController),
            customTextField(hint:"Phone",isPass: false, title: "Phone",controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}


