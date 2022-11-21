import 'dart:developer';

import 'package:flexable/config/const.dart';
import 'package:flexable/controller/utils/repository/network_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  // final authlisten = client.auth.onAuthStateChange.listen((event) {
  //   log("Auth Lisning Strat");
  //   if (event.event == AuthChangeEvent.signedIn) {
  //     Get.offAllNamed("/home");
  //   } else if (event.event == AuthChangeEvent.signedOut) {
  //     Get.offAllNamed("/login");
  //   }
  // });

  Future<void> googleSignin(context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email', "https://www.googleapis.com/auth/userinfo.profile"]);

    _googleSignIn.signIn().then((result) async {
      await result!.authentication.then((googleKey) {
        log(googleKey.accessToken.toString());
        log("Id Token " + googleKey.idToken.toString());
        log(_googleSignIn.currentUser!.displayName!);
        dynamic returnToken = networkRepository.googleAuth(context,
            accesstoken: googleKey.idToken.toString());
        log(returnToken.toString());
        log(returnToken["payload"]["token"].toString());
        box.write("token", returnToken["payload"]["token"]);
        log(box.read("token"));
        Get.offAllNamed("/home");
      }).catchError((err) {
        log('inner error ' + err.toString());
      });
    }).catchError((err) {
      log('error occured');
    });

    // final GoogleSignInAccount? googleSignInAccount =
    //     await googleSignIn.signIn();
    // if (googleSignInAccount != null) {
    //   final GoogleSignInAuthentication googleSignInAuthentication =
    //       await googleSignInAccount.authentication;

    //   return googleSignInAuthentication.accessToken!;
    // }
    // return "";
  }

  Future<String> signUpUser({String? email, String? password}) async {
    debugPrint("email:$email password:$password");
    try {
      AuthResponse response =
          await client.auth.signUp(email: email!, password: password!);
      if (response.user != null) {
        log("Access Token " + response.session!.accessToken);
        log(response.user!.toJson().toString());
        return response.session!.accessToken;
      } else {
        Get.snackbar("Error", "Something wrong");
        return "";
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return "";
    }
  }

  Future<String> signInUser({String? email, String? password}) async {
    debugPrint("email:$email password:$password");
    try {
      final response = await client.auth
          .signInWithPassword(email: email!, password: password!);
      if (response.user != null) {
        return response.session!.accessToken;
      } else {
        Get.snackbar("Error", "Something wrong");
        log("Responce is null");
        return "";
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return "";
    }
  }

  Future<void> logout(context) async {
    await client.auth.signOut();
    Get.offAllNamed("/login");
  }
}
