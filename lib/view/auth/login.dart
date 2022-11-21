import 'package:flexable/config/const.dart';
import 'package:flexable/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flexable/config/common.dart';
import 'package:flexable/config/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appcolor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: controller.formkey,
              child: Column(
                children: [
                  header(),
                  SizedBox(
                    height: Get.height * .23,
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
                              "Sign in",
                              style: TextStyle(fontSize: 28, color: black),
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
                        height(40),
                        textFormfiled("Username", validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter Username/Email';
                          }
                          return null;
                        }, controller: controller.emailController),
                        height(20),
                        textFormfiled("Password", validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Invalid password';
                          } else if (value.length < 6) {
                            return "Password should be at least 6 characters";
                          }
                          return null;
                        }, controller: controller.passwordController),
                        height(6),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(color: whitelight),
                            )),
                        height(40),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.signInUser(context);
                                  },
                                  child: const Text(
                                    "Login",
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
                                onPressed: () =>  supabaseClient.googleSignin(context),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                        height(12),
                        GestureDetector(
                          onTap: () => Get.toNamed("/signup"),
                          child: Text(
                            "Not Registered?  Create an account",
                            style: TextStyle(color: whitelight),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
