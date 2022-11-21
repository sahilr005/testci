import 'package:flexable/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Column header() {
  return Column(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Back",
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ),
      Image.asset(
        "assets/images/logo2.png",
        width: 200,
      ),
    ],
  );
}

height(height) {
  return SizedBox(height: double.tryParse(height.toString()));
}

width(width) {
  return SizedBox(width: double.tryParse(width.toString()));
}

textfiled(hinttext, {controller}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      fillColor: white,
      filled: true,
      border: InputBorder.none,
      hintText: hinttext,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  );
}

textFormfiled(hinttext, {controller, String? Function(String?)? validator}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    decoration: InputDecoration(
      fillColor: white,
      filled: true,
      border: InputBorder.none,
      hintText: hinttext,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  );
}


class CommonMethod {
  void showSnackBar(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void getXSnackBar(String title, String message, Color? color) {
    Get.snackbar(
      title,
      message,
      backgroundColor: color,
      colorText: white,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      duration: const Duration(seconds: 2),
      borderRadius: 0,
      barBlur: 10,
    );
  }

  void getXConfirmationSnackBar(
    String title,
    String message,
    Function() onButtonPress,
  ) {
    Get.snackbar(title, message,
        mainButton: TextButton(
          onPressed: onButtonPress,
          child:  Icon(Icons.delete, color: white),
        ),
        backgroundColor: Colors.blue,
        colorText: white,
        isDismissible: true,
        // dismissDirection: SnackDismissDirection.HORIZONTAL,
        duration: const Duration(seconds: 6),
        borderRadius: 0,
        barBlur: 10,
        icon: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.close,
              color: white,
            )));
  }
}
