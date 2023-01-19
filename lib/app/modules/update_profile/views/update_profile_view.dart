import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_test/app/data/custom_widget/button.dart';
import 'package:presence_test/app/data/custom_widget/card_navigation.dart';
import 'package:presence_test/app/data/custom_widget/text_field.dart';

import '../../../data/custom_widget/color.dart';
import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;
  UpdateProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.nipc.text = user["nip"];
    controller.namec.text = user["name"];
    controller.emailc.text = user["email"];
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_new_rounded),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: blue2,
        title: const Text('UPDATE PROFILE'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, right: 15, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textField(
                isIconPrefixOn: false,
                enabled: false,
                keyboardType: TextInputType.number,
                controller: controller.nipc,
                labelText: "NIP",
                obscureText: false,
                isIconOn: false),
            SizedBox(height: 20),
            textField(
                isIconPrefixOn: false,
                enabled: false,
                keyboardType: TextInputType.emailAddress,
                controller: controller.emailc,
                labelText: "Email",
                obscureText: false,
                isIconOn: false),
            SizedBox(height: 20),
            textField(
                cursorColor: blue2,
                isIconPrefixOn: false,
                keyboardType: TextInputType.name,
                controller: controller.namec,
                label: Text(
                  "Name",
                  style: TextStyle(color: blue2),
                ),
                obscureText: false,
                enabledBorderSide: BorderSide(
                    width: 1, color: blue2, style: BorderStyle.solid),
                focusedBorder: BorderSide(
                    width: 2, color: blue2, style: BorderStyle.solid),
                isIconOn: false),
            SizedBox(height: 20),
            Text(
              "Picture Profile",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<UpdateProfileController>(
                  builder: (c) {
                    if (c.image != null && c.image != "") {
                      return CircleAvatar(
                        backgroundImage: FileImage(File(c.image!.path)),
                        radius: 60,
                      );
                    } else if (user["imageProfile"] != null &&
                        user["imageProfile"] != "") {
                      return CircleAvatar(
                        backgroundImage: NetworkImage(user["imageProfile"]),
                        radius: 60,
                      );
                    } else {
                      return Text("Image not found");
                    }
                  },
                ),
                containerCustom(
                  isGradient: false,
                  useBoxDecoration: true,
                  onShadow: false,
                  useBorder: true,
                  radiusValue: 10,
                  child: Row(
                    children: [
                      containerCustom(
                        isGradient: false,
                        onShadow: false,
                        useBoxDecoration: false,
                        child: IconButton(
                          splashRadius: 18,
                          onPressed: () {
                            controller.pickImage();
                          },
                          icon: Icon(
                            Icons.mode_edit,
                            color: blue2,
                            size: 28,
                            shadows: [
                              BoxShadow(
                                color: Color.fromRGBO(255, 255, 255, 0.20),
                                offset: const Offset(
                                  0.0,
                                  0.0,
                                ),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (user["imageProfile"] != null &&
                          user["imageProfile"] != "")
                        containerCustom(
                          isGradient: false,
                          onShadow: false,
                          useBoxDecoration: false,
                          child: IconButton(
                            splashRadius: 2,
                            onPressed: () {
                              controller.deleteImage(user["uid"]);
                            },
                            icon: Icon(
                              Icons.delete_rounded,
                              color: red1,
                              size: 28,
                              shadows: [
                                BoxShadow(
                                  color: Color.fromRGBO(255, 255, 255, 0.20),
                                  offset: const Offset(
                                    0.0,
                                    0.0,
                                  ),
                                  blurRadius: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Obx(
              () => containerCustom(
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
                      await controller.updateProflie(user["uid"]);
                    }
                  },
                  child: containerCustom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    isGradient: false,
                    onShadow: false,
                    useBoxDecoration: false,
                    child: controller.isLoading.isFalse
                        ? Text(
                            "UPDATE",
                            style: TextStyle(fontSize: 16),
                          )
                        : CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
