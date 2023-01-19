import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/custom_widget/color.dart';
import '../../../data/helper/helper.dart';
import '../controllers/detail_presensi_controller.dart';

class DetailPresensiView extends GetView<DetailPresensiController> {
  DetailPresensiView({Key? key}) : super(key: key);
  final Map<String, dynamic> data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ATTENDANCE DETAIL'),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_new_rounded),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: blue2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          // height: MediaQuery.of(context).size.height / 6,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: blue2.withOpacity(0.5),
                blurRadius: 6,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [blue1, blue2]),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "${formatDateCus(data["date"])}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Masuk",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                    "Jam : ${DateFormat.jms().format(DateTime.parse(data["masuk"]["date"]))}",
                    style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 5,
                ),
                Text(
                    "Posisi : ${data["masuk"]["latitude"]}, ${data["masuk"]["longitude"]}",
                    style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 5,
                ),
                Text(
                    "Distance : ${data["masuk"]["distance"].toString().substring(0, 3)} meter",
                    style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Address : ",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        "${data["masuk"]["address"]}",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Status : ${data["masuk"]["status"]}",
                    style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 500,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Keluar",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                    data["keluar"]?["date"] != null
                        ? "Jam : ${DateFormat.jms().format(DateTime.parse(data["keluar"]?["date"]))}"
                        : "Jam :   -",
                    style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 5,
                ),
                Text(
                    data["keluar"]?["latitude"] == null &&
                            data["keluar"]?["longitude"] == null
                        ? "Posisi : -"
                        : "Posisi : ${data["keluar"]["latitude"]}, ${data["keluar"]["longitude"]}",
                    style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 5,
                ),
                Text(
                    data["keluar"]?["distance"] == null
                        ? "Ditance : "
                        : "Distance : ${data["keluar"]?["distance"].toString().substring(0, 3)} meter",
                    style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Address : ",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        data["keluar"]?["address"] != null
                            ? "${data["keluar"]?["address"]}"
                            : "-",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                    data["keluar"]?["status"] != null
                        ? "Status : ${data["keluar"]["status"]}"
                        : "Status : -",
                    style: TextStyle(color: Colors.white)),
              ]),
        ),
      ),
    );
  }
}
