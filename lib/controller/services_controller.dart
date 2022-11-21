import 'package:flexable/controller/utils/repository/network_repository.dart';
import 'package:flexable/model/services_model.dart';
import 'package:get/get.dart';

class ServicesController extends GetxController {
  List<Payload>? data;
  services(context,orgId) async {
    Servicemodel response = await networkRepository.getServices(context,orgId);
    if (response.status == 200) {
      data = response.payload;
      update();
    }
  }
}
