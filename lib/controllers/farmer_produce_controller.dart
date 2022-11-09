import 'package:farmers_directory/data/repository/farmer_produce_repo.dart';
import 'package:get/get.dart';

class FarmerProduceController extends GetxController {
  final FarmerProduceRepo farmerProduceRepo;

  FarmerProduceController({required this.farmerProduceRepo});

//access with Get for Ui
  List<dynamic> get farmerProduceList => _farmerProduceList;

  List<dynamic> _farmerProduceList = [];

  Future<void> getFarmerProduceList() async {
    Response response = await farmerProduceRepo.getFarmerProduceList();

    if (response.statusCode == 200) {
      //initialize as null to avoid duplicate
      _farmerProduceList = [];
      //  _farmerProduceList.addAll();
      update(); //similar to setState for ui
    } else {}
  }
}
