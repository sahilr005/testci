import 'dart:developer';
import 'package:flexable/config/common.dart';
import 'package:flexable/controller/dats_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flexable/config/colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeView extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final orgcode;
  const QrCodeView({Key? key, this.orgcode}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrCodeViewState();
}

class _QrCodeViewState extends State<QrCodeView> {
  final DatsController datscontroller = Get.put(DatsController());

  @override
  void reassemble() {
    super.reassemble();
    datscontroller.controller!.resumeCamera();
  }

  bool scan = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildQrView(context),
        floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      scan = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: scan
                        ? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          )
                        : const BoxDecoration(),
                    alignment: Alignment.center,
                    child: const Text("Scan code"),
                  ),
                ),
              ),
              width(15),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      scan = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: !scan
                        ? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          )
                        : const BoxDecoration(),
                    alignment: Alignment.center,
                    child: const Text("Enter code"),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    datscontroller.controller?.resumeCamera();
    var scanArea = (Get.width < 400 || Get.height < 400) ? 150.0 : 300.0;
    return Stack(
      children: [
        SizedBox(
            height: Get.height,
            width: Get.width,
            child: QRView(
              key: datscontroller.qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: scan
                  ? QrScannerOverlayShape(
                      borderColor: Colors.white,
                      borderRadius: 10,
                      borderLength: 30,
                      borderWidth: 4,
                      cutOutSize: scanArea)
                  : QrScannerOverlayShape(borderColor: Colors.transparent),
              onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
            )),
        Padding(
          padding: EdgeInsets.only(left: Get.width * .3, top: scanArea - 200),
          child: Text(
            scan ? "Scan QR Code" : "  Enter Code",
            style: TextStyle(
                fontSize: 22, color: white, fontWeight: FontWeight.w600),
          ),
        ),
        if (!scan)
          Padding(
            padding: EdgeInsets.only(
                left: Get.width * .15,
                right: Get.width * .15,
                top: Get.height * .3),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 20),
              child: TextField(
                controller: datscontroller.codecontroller,
                autofocus: true,
                decoration: InputDecoration(
                    suffix: GestureDetector(
                      onTap: () {
                        datscontroller.postCodeData(context,
                            orgServiceItemId: Get.arguments);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 30, right: 10),
                        child: Icon(Icons.done_all),
                      ),
                    ),
                    border: InputBorder.none,
                    // isCollapsed: true,
                    hintText: "Enter Code"),
              ),
            ),
          ),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: const Icon(Icons.close, size: 20),
          ),
        ),
        Positioned(
          right: 15,
          child: GestureDetector(
            onTap: () async {
              await datscontroller.controller?.toggleFlash();
              setState(() {});
            },
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(top: 15),
              child: const Icon(Icons.flash_on, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      datscontroller.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // setState(() {
      datscontroller.result = scanData;
      print("Scaned Dta  " + datscontroller.result!.code!);
      datscontroller.aq++;
      if (datscontroller.aq == 1) {
        datscontroller.postQrdata(context,
            datsData: datscontroller.result!.code!);
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    datscontroller.controller?.dispose();
    super.dispose();
  }
}
