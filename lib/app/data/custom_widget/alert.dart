import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:presence_test/app/data/custom_widget/color.dart';

class alertWidget {
  static showToast({required String responeMessage}) {
    Fluttertoast.showToast(
        msg: responeMessage, // Message
        toastLength: Toast.LENGTH_SHORT, // toast length
        gravity: ToastGravity.BOTTOM, // position
        timeInSecForIosWeb: 2, // duaration
        backgroundColor: blue2, // background color
        textColor: Colors.white // text color
        );
  }
}

class defaultDialogCustome extends GetxController {
  static showDialogCustome({
    required String title,
    Function()? onTapConfrim,
    Function()? onTapCancel,
    bool? isConfirmButtonOn = true,
    bool? isDefaultOnTap = true,
    Widget? content,
    Widget? textButton,
    Widget? textButtonCancel,
    Widget? textButtonConfirm,
  }) {
    Get.defaultDialog(
      radius: 25,
      backgroundColor: blue2,
      contentPadding: EdgeInsets.all(0.0),
      title: title,
      titlePadding: EdgeInsets.only(bottom: 10.0, top: 20.0),
      titleStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
      content: content,
      confirm: isConfirmButtonOn ?? true
          ? Container(
              padding: EdgeInsets.only(top: 30.0),
              height: 90,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.white, width: 0.5))),
                child: InkWell(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25)),
                  onTap: () {
                    Get.back();
                  },
                  child: textButton,
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.only(top: 30.0),
              width: double.infinity,
              height: 90,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.white, width: 0.5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150.0,
                      child: InkWell(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(25)),
                        onTap: isDefaultOnTap ?? true ? () {
                          Get.back();
                        } : onTapCancel,
                        child: textButtonCancel,
                      ),
                    ),
                    Container(
                      width: 150.0,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),
                      child: InkWell(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(25)),
                        onTap: onTapConfrim,
                        child: textButtonConfirm,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
