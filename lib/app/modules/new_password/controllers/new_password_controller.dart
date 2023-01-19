import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_test/app/data/custom_widget/alert.dart';
import 'package:presence_test/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  var isLoading = false.obs;
  var isHidePassword = true.obs;
  var isHidePassword2 = true.obs;
  var isHidePassword3 = true.obs;
  var currentPasswordC = TextEditingController();
  var newPasswordC = TextEditingController();
  var confrimPasswordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void updatePassword() async {
    if (currentPasswordC.text.isNotEmpty &&
        newPasswordC.text.isNotEmpty &&
        confrimPasswordC.text.isNotEmpty) {
      if (newPasswordC.text == confrimPasswordC.text) {
        isLoading.value = true;
        try {
          String email = auth.currentUser!.email!;
          await auth.signInWithEmailAndPassword(
              email: email, password: currentPasswordC.text);
          await auth.currentUser!.updatePassword(newPasswordC.text);

          Get.offAllNamed(Routes.PROFILE);
          alertWidget.showToast(
              responeMessage: "Password changed successfully");
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            alertWidget.showToast(
                responeMessage: "Password you entered are too short");
          } else if (e.code == 'wrong-password') {
            alertWidget.showToast(responeMessage: "Inccorect Password");
          } else {
            alertWidget.showToast(responeMessage: "${e.code.toLowerCase()}");
          }
        } catch (e) {
          alertWidget.showToast(responeMessage: "Password failed to change");
        } finally {
          isLoading.value = false;
        }
      } else {
        // Get.snackbar("Terjadi Kesalahan", "Confrim Password tidak sama");
        defaultDialogCustome.showDialogCustome(
          title: "Invalid password",
          content: const Text("New Password and Confrim Password \n not macth",
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
      // Get.snackbar("Terjadi Kesalahan", "Form tidak boleh boleh kosong");
      defaultDialogCustome.showDialogCustome(
        title: "Error!",
        content: const Text("Form can't be blank.\nPlease try again.",
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
