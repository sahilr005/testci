import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flexable/config/apiconst.dart';
import 'package:flexable/config/common.dart';
import 'package:flexable/config/const.dart';
import 'package:flexable/controller/utils/network_dio/network_dio.dart';
import 'package:flexable/model/Organization_model.dart';
import 'package:flexable/model/services_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

NetworkRepository networkRepository = NetworkRepository();

class NetworkRepository {
  static final NetworkRepository _networkRepository =
      NetworkRepository._internal();

  factory NetworkRepository() {
    return _networkRepository;
  }
  NetworkRepository._internal();

//............................... Auth

  authDatasend(context, {required String token}) async {
    Map data = {"supabaseToken": token};
    try {
      final authResponce = await NetworkDioHttp.postDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.auth,
        data: data,
      );
      log('\x1b[97m Response : $authResponce');
      return checkResponse2(authResponce);
    } catch (e) {
      CommonMethod().getXSnackBar("Error", e.toString(), Colors.red);
    }
  }

  googleAuth(context, {required String accesstoken}) async {
    Map data = {"googleToken": accesstoken};
    try {
      final authResponce = await NetworkDioHttp.postDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.authGoogle,
        data: data,
      );
      log(data.toString());
      log('\x1b[97m Response : $authResponce');
      return checkResponse2(authResponce);
    } catch (e) {
      CommonMethod().getXSnackBar("Error", e.toString(), Colors.red);
    }
  }

// ................................ Services Get

  getServices(context, orgId) async {
    try {
      final servicesResponse = await NetworkDioHttp.getDioHttpMethod(
          context: context,
          url: ApiAppConstants.apiEndPoint +
              ApiAppConstants.getorgpart +
              "?orgId=" +
              orgId,
          header: Options(
            headers: {
              "authorization":
                  "v4.local.URC2UcW0k5Xpn7PFhsjfjOu1z8sIOCWFbBOJnPxzfVOWWOusxpmBSCT1oNJ5edT4vTntsRNifEviLBk4KYrVCB5whgYpqFCSdQJ9-hACAvZ7FDtx9jgUe3aXHj_EszDQQ9WU7MLXDQTq07oK8s-v1HiMbjdW-jkMbtdVPpQ2qEXckX92BQD-uWX4dwy5gTmJfdEVpa_fi4IK_rjwVXo8i01bZ6c"
            },
          ));
      debugPrint('\x1b[97m services Api Response : $servicesResponse');
      return checkResponse(
          servicesResponse, Servicemodel.fromJson(servicesResponse['body']));
    } catch (e) {
      CommonMethod().getXSnackBar("Responce Is null", e.toString(), Colors.red);
    }
  }

  getOrg(context) async {
    try {
      final organizationResponse = await NetworkDioHttp.getDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.getorg,
        header: Options(
          headers: {
            "authorization":
                "v4.local.URC2UcW0k5Xpn7PFhsjfjOu1z8sIOCWFbBOJnPxzfVOWWOusxpmBSCT1oNJ5edT4vTntsRNifEviLBk4KYrVCB5whgYpqFCSdQJ9-hACAvZ7FDtx9jgUe3aXHj_EszDQQ9WU7MLXDQTq07oK8s-v1HiMbjdW-jkMbtdVPpQ2qEXckX92BQD-uWX4dwy5gTmJfdEVpa_fi4IK_rjwVXo8i01bZ6c"
          },
          // headers: {"authorization": box.read("token")},
        ),
      );
      debugPrint('\x1b[97m Organization Api Response : $organizationResponse');
      return checkResponse(organizationResponse,
          OrganizationModel.fromJson(organizationResponse['body']));
    } catch (e) {
      CommonMethod().getXSnackBar("Error", e.toString(), Colors.red);
    }
  }

// ...................................... Qr Data Send

  postdats(context, {datsData}) async {
    dynamic token = box.read("token");
    try {
      final datspostResponse = await NetworkDioHttp.postDioHttpMethod(
          context: context,
          url: ApiAppConstants.apiEndPoint + ApiAppConstants.datspost,
          data: datsData,
          header: Options(
            headers: {"authorization": token},
          ));
      log('\x1b[97m Response : $datspostResponse');
      Get.toNamed("/QrDetails", arguments: true);
    } catch (e) {
      Get.toNamed("/QrDetails", arguments: false);
      log("Error Log " + e.toString());
    }
  }

  postDatsCode(context, {datsData}) async {
    try {
      final datspostResponse = await NetworkDioHttp.postDioHttpMethod(
        context: context,
        url: ApiAppConstants.apiEndPoint + ApiAppConstants.datsCodepost,
        data: datsData,
        header: Options(
          headers: {"authorization": box.read("token")},
        ),
      );
      log('\x1b[97m Response : $datspostResponse');
      // Get.to(() => const QrDetailsScreen(redeem: false));
      Get.toNamed("/QrDetails", arguments: true);
    } catch (e) {
      log("Error  " + e.toString());
      // Get.to(() => const QrDetailsScreen(redeem: false));
      Get.toNamed("/QrDetails", arguments: false);

      // CommonMethod().getXSnackBar("Error", e.toString(), Colors.red);
    }
  }

  Future<void> checkResponse(
    response,
    modelResponse,
  ) async {
    if (response["error_description"] == null ||
        response["error_description"] == 'null') {
      if (response['body']['status'] == 200 ||
          response['body']['status'] == "200") {
        return modelResponse;
      } else if (response['body']['status'] == 500 ||
          response['body']['status'] == "500") {
        return modelResponse;
      } else {
        showErrorDialog(message: response['body']['message']);
      }
    } else {
      showErrorDialog(message: response['body']['message']);
    }
  }

  Future<void> checkResponse2(
    response,
  ) async {
    if (response["error_description"] == null ||
        response["error_description"] == 'null') {
      if (response['body']['status'] == 200 ||
          response['body']['status'] == "200") {
        return response['body'];
      } else if (response['body']['status'] == 500 ||
          response['body']['status'] == "500") {
        showErrorDialog(message: response['body']['message']);
        return response['body'];
      } else {
        showErrorDialog(message: response['body']['message']);
      }
    } else {
      showErrorDialog(message: response['body']['message']);
    }
  }

  void showErrorDialog({required String message}) {
    CommonMethod().getXSnackBar("Error", message.toString(), Colors.red);
  }
}
