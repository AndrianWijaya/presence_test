import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_test/app/data/custom_widget/alert.dart';
import 'package:presence_test/app/routes/app_pages.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var isHidePassword = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> login() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        final credential = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passwordC.text);
        if (credential.user != null) {
          if (credential.user!.emailVerified == true) {
            isLoading.value = false;
            Get.offAllNamed(Routes.HOME);

            alertWidget.showToast(responeMessage: "Login success");
          } else {
            defaultDialogCustome.showDialogCustome(
              isConfirmButtonOn: false,
              title: "Email Verification!",
              content: const Text(
                  "The Email has not been verified. \n Please send verification on you email.",
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                  textAlign: TextAlign.center),
              textButtonCancel: const Center(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              onTapConfrim: () async {
                try {
                  await credential.user!.sendEmailVerification();
                  Get.back();
                  alertWidget.showToast(
                      responeMessage: "Verification email sent successfully");
                  isLoading.value = false;
                } on Exception {
                  isLoading.value = false;
                  alertWidget.showToast(
                      responeMessage: "Verification email failed to send");
                }
              },
              textButtonConfirm: const Center(
                child: Text(
                  "Send",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          defaultDialogCustome.showDialogCustome(
            title: "User not found!",
            content: const Text("Please registered first before login.",
                style: TextStyle(color: Colors.white, fontSize: 14.0),
                textAlign: TextAlign.center),
            textButton: const Center(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else if (e.code == 'wrong-password') {
          defaultDialogCustome.showDialogCustome(
            title: "Incorrect password!",
            content: const Text(
                "The password you entered is incorrect." +
                    '\n' +
                    "Please try again.",
                style: TextStyle(color: Colors.white, fontSize: 14.0),
                textAlign: TextAlign.center),
            textButton: const Center(
              child: Text("OK",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
            ),
          );
        }
      } catch (e) {
        isLoading.value = false;
        defaultDialogCustome.showDialogCustome(
          title: "Error!",
          content: const Text("Unable to log in.",
              style: TextStyle(color: Colors.white, fontSize: 14.0),
              textAlign: TextAlign.center),
          textButton: const Center(
            child: Text("OK",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center),
          ),
        );
      }
    } else {
      defaultDialogCustome.showDialogCustome(
        title: "Error!",
        content: const Text(
            "Email or Password can't be blank.\nPlease try again.",
            style: TextStyle(color: Colors.white, fontSize: 14.0),
            textAlign: TextAlign.center),
        textButton: const Center(
          child: Text("OK",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
        ),
      );
    }
  }
}
