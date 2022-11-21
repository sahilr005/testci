import 'package:flexable/config/const.dart';
import 'package:flexable/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flexable/config/common.dart';
import 'package:flexable/config/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignInController controller = Get.put(SignInController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appcolor,
        body: SingleChildScrollView(
          child: Form(
            key: controller.formkey,
            child: Column(
              children: [
                header(),
                SizedBox(
                  height: Get.height * .15,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white30,
                  ),
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      height(8),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: black,
                              height: 1,
                            ),
                          ),
                          width(10),
                          Text(
                            "Create your account",
                            style: TextStyle(fontSize: 18, color: black),
                          ),
                          width(10),
                          Expanded(
                            child: Container(
                              color: black,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                      height(20),
                      textFormfiled(
                        "Email",
                        validator: (String? value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Email is not valid';
                          }
                          return null;
                        },
                        controller: controller.emailController,
                      ),
                      height(20),
                      textFormfiled("Password", validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        } else if (value.length < 6) {
                          return "Password should be at least 6 characters";
                        }
                        return null;
                      }, controller: controller.passwordController),
                      height(20),
                      textFormfiled(
                        "Confirm Password",
                        controller: controller.confpasswordController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Invalid password';
                          } else if (controller.passwordController.text !=
                              controller.confpasswordController.text) {
                            return "Conformpassword not match with password";
                          }
                          return null;
                        },
                      ),
                      height(20),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.white,
                                  ),
                                  child: Obx(() => Checkbox(
                                      value: controller.check.value,
                                      onChanged: (a) {
                                        controller.check.value = a!;
                                      }))),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Click here to agree to our",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    ' terms of service and privacy policy.',
                                    style: TextStyle(
                                      color: Color(0xff8098CE),
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      height(20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () => controller.signUpUser(context),
                                child: const Text(
                                  "Create Account",
                                  style: TextStyle(fontSize: 20),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  backgroundColor: Colors.black,
                                )),
                          ),
                        ],
                      ),
                      height(12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () =>
                                  supabaseClient.googleSignin(context),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image: AssetImage(
                                          "assets/images/google.png"),
                                      height: 30,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 24, right: 8),
                                      child: Text(
                                        'Sign in with Google',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      height(8),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
