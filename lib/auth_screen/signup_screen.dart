
import 'package:get/get.dart';
import 'package:shopingapp/consts/consts.dart';
import 'package:shopingapp/controller/auth_controller.dart';
import 'package:shopingapp/home_screen/home.dart';

import 'package:shopingapp/widgets/applogo_wid.dart';
import 'package:shopingapp/widgets/bg_wid.dart';
import 'package:shopingapp/widgets/custom_textfield.dart';
import 'package:shopingapp/widgets/new_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Welcome to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
                ()=> Column(
                children: [
                  customTextField(hint: nameHint, title: name,controller: nameController, isPass: false),
                  customTextField(hint: emailHint, title: email,controller: emailController, isPass: false),
                  customTextField(hint: passwordHint, title: password, controller: passwordController,isPass: true),
                  customTextField(hint: passwordHint, title: retypePass, controller: passwordRetypeController,isPass: true),
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: TextButton(
                  //         onPressed: () {}, child: forgetPassword.text.make())),

                  Row(
                    children: [
                      Checkbox(
                        checkColor: redColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        },
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              )),
                          TextSpan(
                              text: termS,
                              style: TextStyle(
                                fontFamily: regular,
                                color: Colors.red,
                              )),
                          TextSpan(
                              text: " & ",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              )),
                          TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                fontFamily: regular,
                                color: Colors.red,
                              ))
                        ])),
                      ),
                    ],
                  ),
                  5.heightBox,
                  controller.isLoading.value ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),) :
          ourButton(
                          color: isCheck == true ? redColor : lightGrey,
                          title: signup,
                          textColor: whiteColor,
                          onpress: () async{
                            if(isCheck != false){
                              controller.isLoading(true);
                              try{
                                await controller
                                    .signupMethod(context: context, email: emailController.text, password: passwordController.text).then((value) {
                                      return controller.storeUserData(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                      );
                                }).then((value){
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                });
                              }catch(e){
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                              }
                            }else{
                              controller.isLoading(false);
                            }
                          },)
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                  10.heightBox,
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                      text: alreadyAc,
                      style: TextStyle(fontFamily: bold, color: fontGrey),
                    ),
                    TextSpan(
                      text: login,
                      style: TextStyle(fontFamily: bold, color: Colors.blue),
                    ),
                  ])).onTap(() {
                    Get.back();
                  })
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
