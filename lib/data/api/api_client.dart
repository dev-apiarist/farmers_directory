import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  // jwt-Token
  late String token;

  //api-url
  final String appBaseUrl;

  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    //how long request should try
    timeout = Duration(seconds: 30);

// header to make requests
    _mainHeaders = {
      // respond with json data
      'Content-type': 'application/json; charset= UTF-8',
      //when making post requests token required
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(
    String uri,
  ) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
