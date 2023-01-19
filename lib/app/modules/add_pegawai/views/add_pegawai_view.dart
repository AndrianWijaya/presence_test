import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_test/app/data/custom_widget/color.dart';
import 'package:presence_test/app/data/custom_widget/text_field.dart';

import '../../../data/custom_widget/button.dart';
import '../../../data/custom_widget/card_navigation.dart';
import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
  const AddPegawaiView({Key? key}) : super(key: key);

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
          title: const Text('ADD PEGAWAI'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 15, right: 15, left: 15),
          child: Column(
            children: [
              textField(
                  cursorColor: blue2,
                  isIconPrefixOn: false,
                  keyboardType: TextInputType.number,
                  controller: controller.nipc,
                  label: Text(
                    "NIP",
                    style: TextStyle(color: blue2),
                  ),
                  enabledBorderSide: BorderSide(
                      width: 1, color: blue2, style: BorderStyle.solid),
                  focusedBorder: BorderSide(
                      width: 2, color: blue2, style: BorderStyle.solid),
                  obscureText: false,
                  isIconOn: false),
              SizedBox(height: 20),
              textField(
                  cursorColor: blue2,
                  isIconPrefixOn: false,
                  keyboardType: TextInputType.name,
                  controller: controller.nameC,
                  label: Text(
                    "Name",
                    style: TextStyle(color: blue2),
                  ),
                  enabledBorderSide: BorderSide(
                      width: 1, color: blue2, style: BorderStyle.solid),
                  focusedBorder: BorderSide(
                      width: 2, color: blue2, style: BorderStyle.solid),
                  obscureText: false,
                  isIconOn: false),
              SizedBox(height: 20),
              textField(
                  cursorColor: blue2,
                  isIconPrefixOn: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.emailc,
                  label: Text(
                    "Email",
                    style: TextStyle(color: blue2),
                  ),
                  enabledBorderSide: BorderSide(
                      width: 1, color: blue2, style: BorderStyle.solid),
                  focusedBorder: BorderSide(
                      width: 2, color: blue2, style: BorderStyle.solid),
                  obscureText: false,
                  isIconOn: false),
              SizedBox(height: 20),
              textField(
                  cursorColor: blue2,
                  isIconPrefixOn: false,
                  keyboardType: TextInputType.name,
                  controller: controller.jobC,
                  label: Text(
                    "Job",
                    style: TextStyle(color: blue2),
                  ),
                  enabledBorderSide: BorderSide(
                      width: 1, color: blue2, style: BorderStyle.solid),
                  focusedBorder: BorderSide(
                      width: 2, color: blue2, style: BorderStyle.solid),
                  obscureText: false,
                  isIconOn: false),
              SizedBox(height: 20),
              Obx(
                () => DropdownButtonFormField2(
                  iconEnabledColor: blue2,
                  iconOnClick: Icon(Icons.arrow_drop_up_rounded),
                  icon: Icon(Icons.arrow_drop_down_rounded),
                  iconSize: 32,
                  isExpanded: true,
                  hint: Text(
                    "Pilih Role",
                    style: TextStyle(color: blue2),
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: blue2, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: blue2, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: blue2, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  dropdownDecoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: blue2.withOpacity(0.20),
                        offset: const Offset(
                          0,
                          4,
                        ),
                        blurRadius: 6,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 0, right: 10),
                  items: controller.menuItems,
                  onChanged: (newValue) {
                    controller.selectedValue.value = newValue.toString();
                  },
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => containerCustom(
                  width: double.infinity,
                  radiusValue: 10,
                  num1: 0.13,
                  num2: 102.34,
                  onShadow: false,
                  isGradient: true,
                  useBoxDecoration: true,
                  child: elevatedButtonCustome(
                    useBorderRadius: true,
                    radiusValue: 10,
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.addPegawai();
                      }
                    },
                    child: containerCustom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      isGradient: false,
                      onShadow: false,
                      useBoxDecoration: false,
                      child: controller.isLoading.isFalse
                          ? Text(
                              "ADD EMPLOYEE",
                              style: TextStyle(fontSize: 16),
                            )
                          : CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
