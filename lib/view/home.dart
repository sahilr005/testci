import 'package:flexable/controller/utils/nodata.dart';
import 'package:flexable/view/auth/login.dart';
import 'package:flexable/view/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flexable/config/common.dart';
import 'package:flexable/config/const.dart';
import 'package:flexable/config/colors.dart';

import '../controller/organization_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OrganizationController controller =
      Get.put<OrganizationController>(OrganizationController());
  @override
  void initState() {
    box.write("login", true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: GetBuilder<OrganizationController>(
        initState: (_) => controller.organization(context),
        builder: (_) {
          if (_.data == null) {
            return Center(
              child: Column(
                children: [
                  homeheader(),
                  NoData(),
                ],
              ),
            );
          }
          return SingleChildScrollView(
              child: Column(
            children: [
              homeheader(),
              height(10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _.data!.length,
                itemBuilder: (context, index) {
                  if (_.data == null) {
                    return NoData();
                  }
                  return Card(
                    child: GestureDetector(
                      onTap: () {
                        // Get.toNamed("/QrCodeView");
                        // Get.toNamed("/ShopScreen");
                        Get.to(() => ShopScreen(orgId: _.data![index].id!));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                                imageBaseUrl + _.data![index].imageHash!),
                            ListTile(
                              title: Text(_.data![index].name!),
                              // leading: CircleAvatar(
                              //     foregroundImage: NetworkImage(
                              //   imageBaseUrl + _.data![index].coverImageHash!,
                              // )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ));
        },
      )),
    );
  }

  Container homeheader() {
    return Container(
      color: appcolor,
      width: Get.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40),
                Image.asset(
                  "assets/images/logo2.png",
                  width: 200,
                ),
                GestureDetector(
                  onTap: () async {
                    box.write("login", false);
                    await box.erase();
                    Get.offAll(() => const LoginPage());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          height(Get.height * .07),
          const Text(
            "Welcome Benjamin’s",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          height(Get.height * .04),
          Container(
            height: 2,
            color: lightblack,
            width: Get.width * .8,
          ),
          height(Get.height * .08),
        ],
      ),
    );
  }
}
