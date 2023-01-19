import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence_test/app/data/custom_widget/alert.dart';
import 'package:presence_test/app/routes/app_pages.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PageNavigationController extends GetxController {
  var pageNavigation = 0.obs;
  var auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;

  void changePage(int i) async {
    switch (i) {
      case 1:
        print("ABSENSI");
        Map<String, dynamic> response = await determinePosition();
        if (response["error"] != true) {
          Position position = response["position"];
          List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);
          String address =
              "${placemarks[0].street}, ${placemarks[0].name}, ${placemarks[0].locality}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].administrativeArea}, ${placemarks[0].country}";
          await updatePosition(position, address);

          //cek 2 position
          var distance = Geolocator.distanceBetween(
              -6.1659775, 106.7786425, position.latitude, position.longitude);

          //absensi
          await presensi(position, address, distance);
        } else {
          // Get.snackbar("Terjadi Kesalahan", "${response["message"]}");
          alertWidget.showToast(responeMessage: "${response["message"]}");
        }
        break;
      case 2:
        pageNavigation.value = i;
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        pageNavigation.value = i;
        Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> presensi(
      Position position, String address, double distance) async {
    String uid = auth.currentUser!.uid;
    DateTime dateNow = DateTime.now();
    String dateFormat = DateFormat.yMd().format(dateNow).replaceAll("/", "-");

    var collectionPresensi =
        firestore.collection("pegawai").doc(uid).collection("presence");
    var snapPresensi = await collectionPresensi.get();
    var presensiTodayDoc = await collectionPresensi.doc(dateFormat).get();
    String status = "Di Luar Are";

    if (distance <= 200) {
      status = "Di Dalam Area";
    }

    if (snapPresensi.docs.length == 0) {
      //first absen
      defaultDialogCustome.showDialogCustome(
        isConfirmButtonOn: false,
        title: "Attendance validation!",
        content: const Text("You want attendance now?",
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
          await collectionPresensi.doc(dateFormat).set({
            "date": dateNow.toIso8601String(),
            "masuk": {
              "date": dateNow.toIso8601String(),
              "latitude": position.latitude,
              "longitude": position.longitude,
              "address": address,
              "status": status,
              "distance": distance
            }
          });
          Get.back();
          alertWidget.showToast(responeMessage: "attendance Successful");
        },
        textButtonConfirm: const Center(
          child: Text(
            "Confirm",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      );
      // Get.defaultDialog(
      //     title: "Validasi Absensi",
      //     middleText: "Absen sekarang?",
      //     actions: [
      //       OutlinedButton(onPressed: () => Get.back(), child: Text("CANCEL")),
      //       ElevatedButton(
      //           onPressed: () async {
      //             await collectionPresensi.doc(dateFormat).set({
      //               "date": dateNow.toIso8601String(),
      //               "masuk": {
      //                 "date": dateNow.toIso8601String(),
      //                 "latitude": position.latitude,
      //                 "longitude": position.longitude,
      //                 "address": address,
      //                 "status": status,
      //                 "distance": distance
      //               }
      //             });
      //             Get.back();
      //             Get.snackbar("Berhasil", "Absen masuk berhasil");
      //           },
      //           child: Text("YES"))
      //     ]);
    } else if (presensiTodayDoc.exists == true) {
      var dataPresensiToday = presensiTodayDoc.data();

      if (dataPresensiToday?["keluar"] != null) {
        // Get.snackbar("Terjadi Kesalahan", "Kamu sudah absen hari ini");
        // alertWidget.showToast(responeMessage: "You've been absent today");
        defaultDialogCustome.showDialogCustome(
          title: "Invalid attendance!",
          content: const Text(
            "You've been absent today.",
            style: TextStyle(color: Colors.white, fontSize: 14.0),
            textAlign: TextAlign.center),
        textButton: const Center(
          child: Text("OK",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
        ),
        );
      } else {
        //absen keluar
        defaultDialogCustome.showDialogCustome(
          isConfirmButtonOn: false,
          title: "Attendance validation!",
          content: const Text("You want attendance out now?",
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
            await collectionPresensi.doc(dateFormat).update({
              "date": dateNow.toIso8601String(),
              "keluar": {
                "date": dateNow.toIso8601String(),
                "latitude": position.latitude,
                "longitude": position.longitude,
                "address": address,
                "status": status,
                "distance": distance
              }
            });
            Get.back();
            alertWidget.showToast(responeMessage: "Attendance exit Successful");
          },
          textButtonConfirm: const Center(
            child: Text(
              "Confirm",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    } else {
      //absen masuk
      defaultDialogCustome.showDialogCustome(
        isConfirmButtonOn: false,
        title: "Attendance validation!",
        content: const Text("You want attendance now?",
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
          await collectionPresensi.doc(dateFormat).set({
            "date": dateNow.toIso8601String(),
            "masuk": {
              "date": dateNow.toIso8601String(),
              "latitude": position.latitude,
              "longitude": position.longitude,
              "address": address,
              "status": status,
              "distance": distance
            }
          });
          Get.back();
          alertWidget.showToast(responeMessage: "attendance Successful");
        },
        textButtonConfirm: const Center(
          child: Text(
            "Confirm",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      );
      // Get.defaultDialog(
      //     title: "Validasi Absensi",
      //     middleText: "Absen sekarang?",
      //     actions: [
      //       OutlinedButton(onPressed: () => Get.back(), child: Text("CANCEL")),
      //       ElevatedButton(
      //           onPressed: () async {
      //             await collectionPresensi.doc(dateFormat).set({
      //               "date": dateNow.toIso8601String(),
      //               "masuk": {
      //                 "date": dateNow.toIso8601String(),
      //                 "latitude": position.latitude,
      //                 "longitude": position.longitude,
      //                 "address": address,
      //                 "status": status,
      //                 "distance": distance
      //               }
      //             });
      //             Get.back();
      //             Get.snackbar("Berhasil", "Absen masuk berhasil");
      //           },
      //           child: Text("YES"))
      //     ]);
    }
  }

  Future<void> updatePosition(Position position, String address) async {
    String uid = auth.currentUser!.uid;

    await firestore.collection("pegawai").doc(uid).update({
      "position": {
        "latitude": position.latitude,
        "longitude": position.longitude
      },
      "address": address
    });
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
      return {"message": "Can't access GPS", "error": true};
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return {"message": "Permission to use GPS denied", "error": true};
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "message":
            "Location permissions are permanently denied, we can't request permission",
        "error": true
      };

      // return Future.error(
      //   'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    return {
      "position": position,
      "message": "Successfully got the location",
      "error": false
    };
  }
}
