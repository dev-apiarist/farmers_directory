import 'package:farmers_directory/controllers/farmer_produce_controller.dart';
import 'package:farmers_directory/data/api/api_client.dart';
import 'package:farmers_directory/data/repository/farmer_produce_repo.dart';
import 'package:get/get.dart';

Future<void> init() async {
  //api-client
  Get.lazyPut(() => ApiClient(appBaseUrl: 'url'));

  //repos
  Get.lazyPut(() => FarmerProduceRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => FarmerProduceController(farmerProduceRepo: Get.find()));
}
