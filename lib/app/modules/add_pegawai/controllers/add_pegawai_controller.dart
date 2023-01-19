import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_test/app/data/custom_widget/alert.dart';
import 'package:presence_test/app/data/custom_widget/text_field.dart';

import '../../../data/custom_widget/color.dart';

class AddPegawaiController extends GetxController {
  var selectedValue = "Admin".obs;

  var isHidePassword = true.obs;
  var isLoading = false.obs;
  var isLoadingAddPegawai = false.obs;
  var nameC = TextEditingController();
  var jobC = TextEditingController();
  var nipc = TextEditingController();
  var emailc = TextEditingController();
  var passwordAdminC = TextEditingController();

  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Admin"), value: "Administrator"),
    DropdownMenuItem(child: Text("Employee"), value: "Employee"),
  ].obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesAddPegawai() async {
    if (passwordAdminC.text.isNotEmpty) {
      isLoadingAddPegawai.value = true;
      try {
        String emailAdmin = auth.currentUser!.email!;

        var adminCredential = await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: passwordAdminC.text,
        );

        var pegawaiCredential = await auth.createUserWithEmailAndPassword(
          email: emailc.text,
          password: "password",
        );

        if (pegawaiCredential.user != null) {
          String uid = pegawaiCredential.user!.uid;

          await firestore.collection("pegawai").doc(uid).set({
            "nip": nipc.text,
            "creatDate": DateTime.now().toIso8601String(),
            "name": nameC.text,
            "email": emailc.text,
            "uid": uid,
            "role": selectedValue.value,
            "job": jobC.text
          });

          await pegawaiCredential.user!.sendEmailVerification();

          await auth.signOut();

          var adminCredential = await auth.signInWithEmailAndPassword(
            email: emailAdmin,
            password: passwordAdminC.text,
          );

          Get.back();
          Get.back();

          alertWidget.showToast(responeMessage: "Employee successfully added");
        }
        isLoadingAddPegawai.value = false;
      } on FirebaseAuthException catch (e) {
        isLoadingAddPegawai.value = false;
        if (e.code == 'weak-password') {
          alertWidget.showToast(
              responeMessage: "Password you entered are too short");
        } else if (e.code == 'email-already-in-use') {
          alertWidget.showToast(responeMessage: "Email already exist");
        } else if (e.code == 'wrong-password') {
          alertWidget.showToast(responeMessage: "Inccorect Password");
        } else {
          alertWidget.showToast(responeMessage: "${e.code.toLowerCase()}");
        }
      } catch (e) {
        isLoadingAddPegawai.value = false;
        alertWidget.showToast(responeMessage: "Employee failed added");
      }
    } else {
      isLoading.value = false;
      defaultDialogCustome.showDialogCustome(
        title: "Error!",
        content: const Text("The password is required.",
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

  Future<void> addPegawai() async {
    if (nameC.text.isNotEmpty &&
        nipc.text.isNotEmpty &&
        emailc.text.isNotEmpty &&
        jobC.text.isNotEmpty &&
        selectedValue.value.toString().isNotEmpty) {
      isLoading.value = true;
      defaultDialogCustome.showDialogCustome(
        title: "Admin Validation!",
        content: Column(
          children: [
            Text("Enter you password.",
                style: TextStyle(color: Colors.white, fontSize: 14.0),
                textAlign: TextAlign.center),
            SizedBox(height: 15),
            Obx(
              () {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: textField(
                    isDefaultIconColor: false,
                    isDefaultFillColor: false,
                    fillColor: blue2,
                    iconColor: Colors.white,
                    textStyle: TextStyle(color: Colors.white),
                    obscureText: isHidePassword.value,
                    isIconOn: true,
                    autocorrect: false,
                    controller: passwordAdminC,
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.white),
                    onPressed: () {
                      isHidePassword.value = !isHidePassword.value;
                    },
                    enabledBorderSide: BorderSide(
                        width: 2, color: Colors.white, style: BorderStyle.solid),
                    focusedBorder: BorderSide(
                        width: 3, color: Colors.white, style: BorderStyle.solid),
                  ),
                );
              },
            )
          ],
        ),
        isConfirmButtonOn: false,
        textButtonCancel: const Center(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        textButtonConfirm: const Center(
          child: Text(
            "Confrim",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        isDefaultOnTap: false,
        onTapCancel: () {
          isLoading.value = false;
          Get.back();
        },
      );
      // Get.defaultDialog(
      //     title: "Validasi Admin",
      //     content: Column(
      //       children: [
      //         Text("Masukan password"),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Obx(() {
      //           return textField(
      //             autocorrect: false,
      //             controller: passwordAdminC,
      //             labelText: "Password",
      //             obscureText: isHidePassword.value,
      //             isIconOn: true,
      //             onPressed: () {
      //               isHidePassword.value = !isHidePassword.value;
      //             },
      //           );
      //         }),
      //       ],
      //     ),
      //     actions: [
      //       OutlinedButton(
      //           style: ElevatedButton.styleFrom(
      //               fixedSize: Size(double.infinity, 50)),
      //           onPressed: () {
      //             isLoading.value = false;
      //             Get.back();
      //           },
      //           child: Text("Close")),
      //       Obx(
      //         () => ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //               fixedSize: Size(double.infinity, 50)),
      //           onPressed: () async {
      //             if (isLoadingAddPegawai.isFalse) {
      //               await prosesAddPegawai();
      //             }
      //             isLoading.value = false;
      //           },
      //           child: isLoadingAddPegawai.isFalse
      //               ? Text("Add Pegawai")
      //               : CircularProgressIndicator(
      //                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      //                 ),
      //         ),
      //       ),
      //     ]);
    } else {
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
