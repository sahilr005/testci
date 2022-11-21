import 'dart:convert';
import 'package:flexable/controller/utils/repository/network_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DatsController extends GetxController {
  Barcode? result;
  int aq = 0;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  TextEditingController codecontroller = TextEditingController();
  postQrdata(context, {required datsData}) async {
    Map data = json.decode(datsData);

    Map postdata = {
      "orgServiceItemId": data["orgServiceItemId"].toString(),
      "userId": data["userId"].toString(),
      "signature": data["signature"].toString(),
      "validityUpto": data["validity"],
      "ticketId": data["orderId"].toString()
    };
    print(".................." + postdata.toString());

    await networkRepository.postdats(context, datsData: postdata);
    aq = 0;
    update();
  }

  postCodeData(context, {orgServiceItemId}) async {
    Map datsdata = {
      "uniqueCode": codecontroller.text.trim(),
      "orgServiceItemId": orgServiceItemId
    };
    dynamic response =
        await networkRepository.postDatsCode(context, datsData: datsdata);
    codecontroller.clear();
    aq = 0;
    update();
  }
}
