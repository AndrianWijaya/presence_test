import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_test/app/data/custom_widget/color.dart';
import 'package:presence_test/app/data/custom_widget/text_field.dart';

import '../../../data/custom_widget/button.dart';
import '../../../data/custom_widget/card_navigation.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FORGOT PASSWORD'),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_rounded),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: blue2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 15, right: 15, left: 15),
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
                    width: 2, color: blue2, style: BorderStyle.solid),
                focusedBorder: BorderSide(
                    width: 3, color: blue2, style: BorderStyle.solid),
                obscureText: false,
                isIconOn: false),
            SizedBox(height: 20),
            Obx(() => containerCustom(
              // width: MediaQuery.of(context).size.width / 3,
              width: double.infinity,
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
                    controller.sendEmail();
                  }
                },
                child: containerCustom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  isGradient: false,
                  onShadow: false,
                  useBoxDecoration: false,
                  child: controller.isLoading.isFalse
                      ? Text(
                          "SEND TO EMAIL",
                          style: TextStyle(fontSize: 16),
                        )
                      : CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
