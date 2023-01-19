import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AttendanceHistoryController extends GetxController {
  var auth = FirebaseAuth.instance;
  var fireStore = FirebaseFirestore.instance;

  DateTime? starDate;
  DateTime endDate = DateTime.now();

  Future<QuerySnapshot<Map<String, dynamic>>> getPresenceHistory() async {
    String uid = auth.currentUser!.uid;

    if (starDate == null) {
      return await fireStore
          .collection("pegawai")
          .doc(uid)
          .collection("presence")
          .where("date", isLessThan: endDate.toIso8601String())
          .orderBy("date", descending: true)
          .get();
    } else {
      return await fireStore
          .collection("pegawai")
          .doc(uid)
          .collection("presence")
          .where("date", isGreaterThan: starDate!.toIso8601String())
          .where("date", isLessThan: endDate.add(Duration(days: 1)).toIso8601String())
          .orderBy("date", descending: true)
          .get();
    }
  }

  void pickDate(DateTime pickStart, DateTime pickEnd) {
    starDate = pickStart;
    endDate = pickEnd;
    update();
    Get.back();
  }
}
