import 'package:get/get.dart';
import 'package:shopingapp/auth_screen/signup_screen.dart';
import 'package:shopingapp/consts/consts.dart';
import 'package:shopingapp/consts/lists.dart';
import 'package:shopingapp/controller/auth_controller.dart';
import 'package:shopingapp/widgets/applogo_wid.dart';
import 'package:shopingapp/widgets/bg_wid.dart';
import 'package:shopingapp/widgets/custom_textfield.dart';
import 'package:shopingapp/widgets/new_button.dart';

import '../home_screen/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(AuthController());
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
                ()=> Column(
                children: [
                  customTextField(hint: emailHint, title: email,isPass: false, controller: controller.emailController),
                  customTextField(hint: passwordHint, title: password, isPass: true, controller: controller.passwordController),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetPassword.text.make())),
                  5.heightBox,
                  controller.isLoading.value ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ) :
                  ourButton(
                      color: redColor,
                      title: login,
                      textColor: whiteColor,
                      onpress: () async{
                        controller.isLoading(true);
                        await controller.loginMethod(context: context).then((value) {
                          if(value!=null){
                            VxToast.show(context, msg: loggedin);
                            Get.offAll(() => const Home());
                          }else{
                            controller.isLoading(false);
                          }
                        });
                      }).box.width(context.screenWidth - 50).make(),

                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  ourButton(
                      color: Colors.orange.shade300,
                      title: signup,
                      textColor: whiteColor,
                      onpress: () {
                        Get.to(() => const SignUp());
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: lightGrey,
                                child: Image.asset(
                                  socialIconList[index],
                                  width: 35,
                                ),
                              ),
                            )),
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
