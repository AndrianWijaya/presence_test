import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_test/app/data/custom_widget/alert.dart';

class ForgotPasswordController extends GetxController {
  var emailC = TextEditingController();
  var isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  void sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        defaultDialogCustome.showDialogCustome(
          title: "Success!",
          content: const Text(
            "We send password reset link to your email.\nPlease check you email.",
            style: TextStyle(color: Colors.white, fontSize: 14.0),
            textAlign: TextAlign.center),
        textButton: const Center(
          child: Text("OK",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
        ),
        );
        Get.back();
      } catch (e) {
        defaultDialogCustome.showDialogCustome(
          title: "Error!",
          content: const Text(
            "Failed to send password reset link \n to your email.\nPlease try again.",
            style: TextStyle(color: Colors.white, fontSize: 14.0),
            textAlign: TextAlign.center),
        textButton: const Center(
          child: Text("OK",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
        ),
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}
