import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence_test/app/controllers/page_navigation_controller.dart';
import 'package:presence_test/app/data/custom_widget/bottom_nav.dart';
import 'package:presence_test/app/routes/app_pages.dart';

import '../../../data/custom_widget/color.dart';
import '../../../data/helper/helper.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final pageC = Get.find<PageNavigationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: blue2),
      // ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: blue2),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                Map<String, dynamic> dataUser = snapshot.data!.data()!;
                String urlDefaultImage =
                    "https://ui-avatars.com/api/?name=${dataUser["name"]}";
                return SingleChildScrollView(
                  padding: EdgeInsets.only(top: 40, right: 20, left: 20),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: blue2.withOpacity(0.2),
                                    blurRadius: 16,
                                    offset: Offset(
                                        1, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    dataUser["imageProfile"] != null
                                        ? dataUser["imageProfile"] != ""
                                            ? dataUser["imageProfile"]
                                            : urlDefaultImage
                                        : urlDefaultImage),
                                radius: 50,
                              ),
                            ),
                            SizedBox(width: 18),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                Text(
                                  "Welcome",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text("${dataUser['name']}")
                              ],
                            ),
                          ],
                        ),
                      ),
                      //Card data user
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: blue2.withOpacity(0.5),
                              blurRadius: 6,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [blue1, blue2]),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${dataUser["job"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "${dataUser["nip"]}",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 5),
                              Text(
                                dataUser["address"] != null
                                    ? dataUser["address"] != ""
                                        ? dataUser["address"]
                                        : "Lokasi tidak ditemukan"
                                    : "Lokasi tidak ditemukan",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ]),
                      ),
                      SizedBox(height: 20),
                      //Absensi
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: blue2.withOpacity(0.5),
                              blurRadius: 6,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [blue1, blue2]),
                        ),
                        child: StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                            stream: controller.streamTodayPresensi(),
                            builder: (context, snapshotTodayPresensi) {
                              if (snapshotTodayPresensi.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              var dataToday =
                                  snapshotTodayPresensi.data?.data();
                              return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Masuk",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            dataToday?["masuk"] == null
                                                ? "-"
                                                : "${DateFormat.jms().format(DateTime.parse(dataToday!["masuk"]["date"]))}",
                                            style:
                                                TextStyle(color: Colors.white))
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      width: 2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              30,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Keluar",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            dataToday?["keluar"] == null
                                                ? "-"
                                                : "${DateFormat.jms().format(DateTime.parse(dataToday!["keluar"]["date"]))}",
                                            style:
                                                TextStyle(color: Colors.white))
                                      ],
                                    ),
                                  ]);
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //Garis
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 500,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(colors: [blue1, blue2])),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Last 5 days"),
                          TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.ATTENDANCE_HISTORY);
                              },
                              child: Text("see more.."))
                        ],
                      ),
                      //List Absen
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: controller.streamPresensi(),
                          builder: (context, snapshotPresensi) {
                            if (snapshotPresensi.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshotPresensi.data?.docs.length == 0 ||
                                snapshotPresensi.data == null) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height / 4,
                                child: Center(
                                  child: Text("Belum ada history presensi."),
                                ),
                              );
                            }
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshotPresensi.data!.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var dataPresensi =
                                    snapshotPresensi.data!.docs[index].data();
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Material(
                                    color: blue1,
                                    borderRadius: BorderRadius.circular(20),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () => Get.toNamed(
                                          Routes.DETAIL_PRESENSI,
                                          arguments: dataPresensi),
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        margin: EdgeInsets.only(bottom: 10),
                                        width: double.infinity,
                                        // height: MediaQuery.of(context).size.height / 6,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: blue2.withOpacity(0.5),
                                              blurRadius: 6,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          // gradient: LinearGradient(colors: [blue1, blue2]),
                                        ),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Masuk",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "${formatDateCus(dataPresensi["date"])}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  dataPresensi["masuk"]
                                                              ?["date"] ==
                                                          null
                                                      ? "-"
                                                      : "${DateFormat.jms().format(DateTime.parse(dataPresensi["masuk"]["date"]))}",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    500,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Keluar",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                dataPresensi["keluar"]
                                                            ?["date"] ==
                                                        null
                                                    ? "-"
                                                    : "${DateFormat.jms().format(DateTime.parse(dataPresensi["keluar"]["date"]))}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          })
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text("Tidak dapat memuat data"),
                );
              }
            }),
      ),
      bottomNavigationBar: bottomNavigation(
          initialActiveIndex: pageC.pageNavigation.value,
          onTap: (int i) => pageC.changePage(i)),
    );
  }
}
