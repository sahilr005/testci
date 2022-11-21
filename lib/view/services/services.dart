import 'package:flexable/config/colors.dart';
import 'package:flexable/config/const.dart';
import 'package:flexable/controller/dats_controller.dart';
import 'package:flexable/controller/services_controller.dart';
import 'package:flexable/controller/utils/nodata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopScreen extends StatefulWidget {
  final String orgId;
  const ShopScreen({Key? key, required this.orgId}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ServicesController controller =
      Get.put<ServicesController>(ServicesController());
  final DatsController datscontroller = Get.put(DatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Services"),
          centerTitle: true,
          backgroundColor: appcolor),
      body: GetBuilder<ServicesController>(
        initState: (_) => controller.services(context, widget.orgId),
        builder: (_) {
          if (_.data == null) {
            return Center(child: NoData());
          }
          return ListView.builder(
            itemCount: _.data!.length,
            itemBuilder: (context, index) {
              if (_.data == null) {
                return NoData();
              }
              return Card(
                elevation: 0.5,
                child: ListTile(
                  title: Text(_.data![index].name!),
                  subtitle: Text(_.data![index].serviceTypeName!.toString()),
                  onTap: () async {
                    Get.toNamed("/QrCodeView",
                        arguments: _.data![index].id.toString());
                  },
                  leading: CircleAvatar(
                      foregroundImage: NetworkImage(
                    imageBaseUrl + _.data![index].imageHash!,
                  )),
                  trailing: const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      )),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
