import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:presence_test/app/data/custom_widget/card_navigation.dart';
import 'package:presence_test/app/routes/app_pages.dart';

import '../../../controllers/page_navigation_controller.dart';
import '../../../data/custom_widget/bottom_nav.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  final pageC = Get.find<PageNavigationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                Map<String, dynamic> dataUser = snapshot.data!.data()!;
                String urlDefaultImage =
                    "https://ui-avatars.com/api/?name=${dataUser["name"]}";
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: Stack(
                          children: [
                            Positioned(
                              child: containerCustom(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 2.5,
                                padding: EdgeInsets.only(top: 60),
                                onShadow: false,
                                isGradient: true,
                                useBoxDecoration: true,
                                num1: -40.12,
                                num2: 127.13,
                                radiusValue: 30,
                                child: Container(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            dataUser["imageProfile"] != null
                                                ? dataUser["imageProfile"] != ""
                                                    ? dataUser["imageProfile"]
                                                    : urlDefaultImage
                                                : urlDefaultImage),
                                        radius: 60,
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "${dataUser['name']}",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "${dataUser['email']}",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              right: 20,
                              bottom: 30,
                              child: containerCustom(
                                onShadow: false,
                                isGradient: true,
                                useBoxDecoration: true,
                                num1: -40.12,
                                num2: 127.13,
                                height: MediaQuery.of(context).size.height / 2.2,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      containerCustom(
                                        isGradient: true,
                                        num1: -40.12,
                                        num2: 127.13,
                                        useBoxDecoration: true,
                                        onShadow: true,
                                        child: materialToInkWell(
                                            radiusValue: 15,
                                            istap: true,
                                            useBorder: true,
                                            color: Colors.transparent,
                                            ontap: () {
                                              Get.toNamed(Routes.UPDATE_PROFILE,
                                                  arguments: dataUser);
                                            },
                                            colorBorder: Colors.white,
                                            child: listTileCustom(
                                                IconColor: Colors.white,
                                                useIcon: true,
                                                title: Text(
                                                  "Update Profile",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                icon: Icons.person_rounded,
                                                size: 28,
                                                onShadow: true)),
                                      ),
                                      SizedBox(height: 20),
                                      containerCustom(
                                        isGradient: true,
                                        num1: -40.12,
                                        num2: 127.13,
                                        useBoxDecoration: true,
                                        onShadow: true,
                                        child: materialToInkWell(
                                            radiusValue: 15,
                                            istap: true,
                                            useBorder: true,
                                            color: Colors.transparent,
                                            ontap: () {
                                              Get.toNamed(Routes.NEW_PASSWORD);
                                            },
                                            colorBorder: Colors.white,
                                            child: listTileCustom(
                                                IconColor: Colors.white,
                                                useIcon: true,
                                                title: Text(
                                                  "Update Password",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                icon: Icons.key_rounded,
                                                size: 28,
                                                onShadow: true)),
                                      ),
                                      SizedBox(height: 20),
                                      if (dataUser["role"] == "admin")
                                        containerCustom(
                                          isGradient: true,
                                          num1: -40.12,
                                          num2: 127.13,
                                          useBoxDecoration: true,
                                          onShadow: true,
                                          child: materialToInkWell(
                                              radiusValue: 15,
                                              istap: true,
                                              useBorder: true,
                                              color: Colors.transparent,
                                              ontap: () {
                                                Get.toNamed(Routes.ADD_PEGAWAI);
                                              },
                                              colorBorder: Colors.white,
                                              child: listTileCustom(
                                                  IconColor: Colors.white,
                                                  useIcon: true,
                                                  title: Text(
                                                    "Add Employee",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  icon: Icons
                                                      .person_add_alt_rounded,
                                                  size: 28,
                                                  onShadow: true)),
                                        ),
                                      SizedBox(height: 20),
                                      containerCustom(
                                        isGradient: true,
                                        num1: -40.12,
                                        num2: 127.13,
                                        useBoxDecoration: true,
                                        onShadow: true,
                                        child: materialToInkWell(
                                            radiusValue: 15,
                                            istap: true,
                                            useBorder: true,
                                            color: Colors.transparent,
                                            ontap: () {
                                              controller.logOut();
                                            },
                                            colorBorder: Colors.white,
                                            child: listTileCustom(
                                                IconColor: Colors.white,
                                                useIcon: true,
                                                title: Text(
                                                  "Log Out",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                icon: Icons.logout_rounded,
                                                size: 28,
                                                onShadow: true)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text("Tidak dapat memuat data user"),
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
