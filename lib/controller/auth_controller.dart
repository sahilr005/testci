import 'dart:developer';
import 'package:flexable/config/const.dart';
import 'package:flexable/controller/utils/repository/network_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void signInUser(context) async {
    if (formkey.currentState!.validate()) {
      supabaseClient
          .signInUser(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((token) async {
        dynamic returnToken =
            await networkRepository.authDatasend(context, token: token);
        box.write("token", returnToken["payload"]["token"]);
        log(box.read("token"));
        Get.offAllNamed("/home");
      });
    }
  }


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confpasswordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  RxBool check = false.obs;

  void signUpUser(context) async {
    if (formkey.currentState!.validate()) {
      supabaseClient
          .signUpUser(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((token) async {
        dynamic returnToken =
            await networkRepository.authDatasend(context, token: token);
        box.write("token", returnToken["payload"]["token"]);
        log("Return Token " + returnToken["payload"]["token"]);
        Get.offAllNamed("/home");
      });
    }
    update();
  }



  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confpasswordController.dispose();
    super.onClose();
  }
}
