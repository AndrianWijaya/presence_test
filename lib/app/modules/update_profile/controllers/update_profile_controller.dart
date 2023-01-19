import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage_firebase;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_test/app/data/custom_widget/alert.dart';

class UpdateProfileController extends GetxController {
  var isLoading = false.obs;
  var nipc = TextEditingController();
  var namec = TextEditingController();
  var emailc = TextEditingController();

  var fireStore = FirebaseFirestore.instance;
  var storage = storage_firebase.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();

  XFile? image;

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  void deleteImage(String uid) async {
    try {
      fireStore
          .collection("pegawai")
          .doc(uid)
          .update({"imageProfile": FieldValue.delete()});
      Get.back();
      alertWidget.showToast(responeMessage: "Image successfully deleted");
    } catch (e) {
      alertWidget.showToast(responeMessage: "Image failed deleted");
    }
  }

  Future<void> updateProflie(String uid) async {
    if (nipc.text.isNotEmpty &&
        namec.text.isNotEmpty &&
        emailc.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "name": namec.text,
        };
        if (image != null) {
          String extImage = image!.name.split(".").last;
          File file = File(image!.path);

          await storage.ref("$uid/imageProfile.$extImage").putFile(file);
          String urlImageProfile =
              await storage.ref("$uid/imageProfile.$extImage").getDownloadURL();

          data.addAll({"imageProfile": urlImageProfile});
        }
        await fireStore.collection("pegawai").doc(uid).update(data);
        Get.back();
        alertWidget.showToast(responeMessage: "Profile successfully updated");
      } catch (e) {
        alertWidget.showToast(responeMessage: "Profile failed updated");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
