import 'package:get/get.dart';
import '../api/api_client.dart';

class FarmerProduceRepo extends GetxService {
  final ApiClient apiClient;

  FarmerProduceRepo({required this.apiClient});
  Future<Response> getFarmerProduceList() async {
    return await apiClient.getData('api/farmers/produce/list');
  }
}
