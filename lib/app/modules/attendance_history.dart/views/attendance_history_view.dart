import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../data/custom_widget/color.dart';
import '../../../data/helper/helper.dart';
import '../../../routes/app_pages.dart';
import '../controllers/attendance_history_controller.dart';

class AttendanceHistoryView extends GetView<AttendanceHistoryController> {
  const AttendanceHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios_new_rounded),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: blue2,
          title: const Text('ATTENDANCE HISTORY'),
          centerTitle: true,
          actions: [
            GetBuilder<AttendanceHistoryController>(builder: (controller) {
              return IconButton(
                  onPressed: () {
                    Get.dialog(Dialog(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        height: MediaQuery.of(context).size.height / 2,
                        child: SfDateRangePicker(
                          monthViewSettings: DateRangePickerMonthViewSettings(
                              firstDayOfWeek: 1),
                          selectionMode: DateRangePickerSelectionMode.range,
                          showActionButtons: true,
                          onCancel: () => Get.back(),
                          onSubmit: (obj) {
                            if (obj != null) {
                              if ((obj as PickerDateRange).endDate != null) {
                                controller.pickDate(
                                    obj.startDate!, obj.endDate!);
                                print(obj);
                              }
                            }
                          },
                        ),
                      ),
                    ));
                  },
                  icon: Icon(Icons.filter_list_rounded));
            })
          ],
        ),
        body: GetBuilder<AttendanceHistoryController>(
          builder: (c) => FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: controller.getPresenceHistory(),
            builder: (context, snapshotAllPresensi) {
              if (snapshotAllPresensi.connectionState ==
                  ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshotAllPresensi.data?.docs.length == 0 ||
                  snapshotAllPresensi.data == null) {
                return SizedBox(
                  child: Center(
                    child: Text("There is no history of attendance yet."),
                  ),
                );
              }
              return ListView.builder(
                padding:
                    EdgeInsets.only(top: 10, bottom: 20, right: 20, left: 20),
                itemCount: snapshotAllPresensi.data!.docs.length,
                itemBuilder: (context, index) {
                  var dataPresensi =
                      snapshotAllPresensi.data!.docs[index].data();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Material(
                      color: blue1,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => Get.toNamed(Routes.DETAIL_PRESENSI,
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            // gradient: LinearGradient(colors: [blue1, blue2]),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Star Day",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${formatDateCus(dataPresensi["date"])}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    dataPresensi["masuk"]?["date"] == null
                                        ? "-"
                                        : "${DateFormat.jms().format(DateTime.parse(dataPresensi["masuk"]["date"]))}",
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height / 500,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "End Day",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  dataPresensi["keluar"]?["date"] == null
                                      ? "-"
                                      : "${DateFormat.jms().format(DateTime.parse(dataPresensi["keluar"]["date"]))}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ));
  }
}
