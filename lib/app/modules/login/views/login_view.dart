import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:presence_test/app/data/custom_widget/text_field.dart';
import 'package:presence_test/app/routes/app_pages.dart';

import '../../../data/custom_widget/button.dart';
import '../../../data/custom_widget/card_navigation.dart';
import '../../../data/custom_widget/color.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1,
                child: Stack(
                  children: [
                    Positioned(
                      child: containerCustom(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 2.5,
                          onShadow: false,
                          isGradient: true,
                          useBoxDecoration: true,
                          num1: -40.12,
                          num2: 127.13,
                          radiusValue: 30,
                          child: Icon(
                            Icons.groups_rounded,
                            size: 150,
                            color: Colors.white,
                          )),
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      height: MediaQuery.of(context).size.height / 2,
                      bottom: MediaQuery.of(context).size.height / 8,
                      child: Column(
                        children: [
                          textField(
                              cursorColor: blue2,
                              isIconPrefixOn: false,
                              controller: controller.emailC,
                              keyboardType: TextInputType.emailAddress,
                              hintText: "Email",
                              hintStyle: TextStyle(color: blue2Op),
                              enabledBorderSide: BorderSide(
                                  width: 2,
                                  color: blue2,
                                  style: BorderStyle.solid),
                              focusedBorder: BorderSide(
                                  width: 3,
                                  color: blue2,
                                  style: BorderStyle.solid),
                              obscureText: false,
                              isIconOn: false),
                          SizedBox(height: 20),
                          Obx(
                            () {
                              return textField(
                                cursorColor: blue2,
                                isIconPrefixOn: false,
                                isIconOn: true,
                                autocorrect: false,
                                hintText: "Password",
                                hintStyle: TextStyle(color: blue2Op),
                                enabledBorderSide: BorderSide(
                                    width: 2,
                                    color: blue2,
                                    style: BorderStyle.solid),
                                focusedBorder: BorderSide(
                                    width: 3,
                                    color: blue2,
                                    style: BorderStyle.solid),
                                controller: controller.passwordC,
                                obscureText: controller.isHidePassword.value,
                                onPressed: () {
                                  controller.isHidePassword.value =
                                      !controller.isHidePassword.value;
                                },
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          Obx(
                            () => containerCustom(
                              width: MediaQuery.of(context).size.width / 2.5,
                              radiusValue: 10,
                              num1: 0.13,
                              num2: 102.34,
                              onShadow: false,
                              isGradient: true,
                              useBoxDecoration: true,
                              child: elevatedButtonCustome(
                                useBorderRadius: true,
                                radiusValue: 10,
                                onPressed: () async {
                                  if (controller.isLoading.isFalse) {
                                    await controller.login();
                                  }
                                },
                                child: containerCustom(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  isGradient: false,
                                  onShadow: false,
                                  useBoxDecoration: false,
                                  child: controller.isLoading.isFalse
                                      ? Text(
                                          "LOG IN",
                                          style: TextStyle(fontSize: 16),
                                        )
                                      : CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.FORGOT_PASSWORD);
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(color: blue2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
