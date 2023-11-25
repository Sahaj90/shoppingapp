import 'dart:io';

import 'package:get/get.dart';
import 'package:shopingapp/consts/consts.dart';
import 'package:shopingapp/controller/profile_controller.dart';
import 'package:shopingapp/widgets/bg_wid.dart';
import 'package:shopingapp/widgets/custom_textfield.dart';
import 'package:shopingapp/widgets/new_button.dart';


class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // if data image url and controller path is empty

              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      PF1,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : data['imageUrl'] != '' &&
                          controller.profileImgPath
                              .isEmpty // if data image url not empty and controller path is empty
                      ? Image.network(data['imageUrl'],
                              width: 100, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()
                      : Image.file(File(controller.profileImgPath.value),
                              width: 100, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),

              10.heightBox,
              ourButton(
                  color: redColor,
                  onpress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change"),
              const Divider(),
              20.heightBox,
              customTextField(
                  controller: controller.nameController,
                  hint: nameHint,
                  title: name,
                  isPass: false),
              10.heightBox,
              customTextField(
                  controller: controller.oldpassController,
                  hint: passwordHint,
                  title: oldpass,
                  isPass: true),
              10.heightBox,
              customTextField(
                  controller: controller.newpassController,
                  hint: passwordHint,
                  title: newpass,
                  isPass: true),
              20.heightBox,
              controller.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      // width: context.screenWidth-60,//
                      child: ourButton(
                          color: redColor,
                          onpress: () async {
                            controller.isLoading(true);

                            //if image is not selected
                            if(controller.profileImgPath.value.isNotEmpty){
                              await controller.uploadProfileImage();
                            }else{
                              controller.profileImageLink = data['imageUrl'];
                            }
                            // password matching in database
                            if(data['password'] == controller.oldpassController.text){

                              await controller.changeAuthPassword(
                                email: data['email'],
                                password: controller.oldpassController.text,
                                newpassword: controller.newpassController.text

                              );
                              await controller.updateProfile(
                                  imgUrl: controller.profileImageLink,
                                  name: controller.nameController.text,
                                  password: controller.newpassController.text);
                              // VxToast.show(context, msg: "Updated");
                            }else{
                              // VxToast.show(context, msg: "Wrong old Password");
                              controller.isLoading(false);
                            }

                          },
                          textColor: whiteColor,
                          title: "Save")),
            ],
          )
              .box
              .white
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(
                top: 50,
                left: 12,
                right: 12,
              ))
              .rounded
              .make(),
        ),
      ),
    ));
  }
}
