import 'package:flexable/controller/utils/repository/network_repository.dart';
import 'package:flexable/model/Organization_model.dart';
import 'package:get/get.dart';

class OrganizationController extends GetxController {
  List<Payload>? data;
  organization(context) async {
    OrganizationModel response = await networkRepository.getOrg(context);
    if (response.status == 200) {
      data = response.payload;
      update();
    }
  }
}
