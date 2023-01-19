import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_test/app/data/custom_widget/button.dart';
import 'package:presence_test/app/data/custom_widget/text_field.dart';
import 'package:presence_test/app/routes/app_pages.dart';

import '../../../data/custom_widget/card_navigation.dart';
import '../../../data/custom_widget/color.dart';
import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: blue2,
        title: const Text('UPDATE PASSWORD'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 15, right: 15, left: 15),
        child: Column(children: [
          Obx(() {
            return textField(
              autocorrect: false,
              controller: controller.currentPasswordC,
              hintText: "Current Password",
              hintStyle: TextStyle(color: blue2Op),
              obscureText: controller.isHidePassword.value,
              isIconOn: true,
              enabledBorderSide:
                  BorderSide(width: 1, color: blue2, style: BorderStyle.solid),
              focusedBorder:
                  BorderSide(width: 2, color: blue2, style: BorderStyle.solid),
              onPressed: () {
                controller.isHidePassword.value =
                    !controller.isHidePassword.value;
              },
            );
          }),
          SizedBox(height: 20),
          Obx(() {
            return textField(
              autocorrect: false,
              controller: controller.newPasswordC,
              hintText: "New Password",
              hintStyle: TextStyle(color: blue2Op),
              obscureText: controller.isHidePassword2.value,
              isIconOn: true,
              enabledBorderSide:
                  BorderSide(width: 1, color: blue2, style: BorderStyle.solid),
              focusedBorder:
                  BorderSide(width: 2, color: blue2, style: BorderStyle.solid),
              onPressed: () {
                controller.isHidePassword2.value =
                    !controller.isHidePassword2.value;
              },
            );
          }),
          SizedBox(height: 20),
          Obx(() {
            return textField(
              autocorrect: false,
              controller: controller.confrimPasswordC,
              hintText: "Confirm Password",
              hintStyle: TextStyle(color: blue2Op),
              obscureText: controller.isHidePassword3.value,
              isIconOn: true,
              enabledBorderSide:
                  BorderSide(width: 1, color: blue2, style: BorderStyle.solid),
              focusedBorder:
                  BorderSide(width: 2, color: blue2, style: BorderStyle.solid),
              onPressed: () {
                controller.isHidePassword3.value =
                    !controller.isHidePassword3.value;
              },
            );
          }),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      side: BorderSide(width: 2, color: blue2),
                      fixedSize: Size(150, 50)),
                  onPressed: () {
                    Get.back();
                    Get.toNamed(Routes.PROFILE);
                  },
                  child: Text(
                    "CANCEL",
                    style: TextStyle(color: blue2),
                  )),
              SizedBox(width: 20),
              Obx(() => containerCustom(
                radiusValue: 10,
                num1: 0.13,
                num2: 102.34,
                onShadow: true,
                isGradient: true,
                useBoxDecoration: true,
                child: elevatedButtonCustome(
                  useBorderRadius: true,
                  radiusValue: 10,
                  onPressed: () {
                    if (controller.isLoading.isFalse) {
                      controller.updatePassword();
                    }
                  },
                  child: containerCustom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    isGradient: false,
                    onShadow: false,
                    useBoxDecoration: false,
                    child: controller.isLoading.isFalse
                        ? Text(
                            "UPDATE PASSWORD",
                            style: TextStyle(fontSize: 16),
                          )
                        : CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                  ),
                ),
              )),
            ],
          )
        ]),
      ),
    );
  }
}
