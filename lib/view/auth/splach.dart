import 'dart:async';
import 'package:flexable/config/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flexable/config/const.dart';
import 'package:flexable/config/colors.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      // box is from Getstorage it's a offline storage
      box.read("login") != null && box.read("login") == true
          ? Get.offAllNamed("/home")
          : Get.offAllNamed("/login");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: appcolor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image.asset(splachlogo),
            ),
            SizedBox(height: 15, width: Get.width),
            CircularProgressIndicator(color: whitelight, strokeWidth: 1),
          ],
        ),
      ),
    );
  }
}
