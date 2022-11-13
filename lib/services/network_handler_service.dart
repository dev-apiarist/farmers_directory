import 'dart:convert';
import 'dart:io';
import 'secure_store_service.dart';
import 'package:http/http.dart' as http;


// Creates a class to handle requests made
class NetworkHandler {
  static String token = ""; // creating a field variable for token.
  static final client = http.Client();
  static final Map<String, String> _headers ={
    "Content-type": "application/json",
    "Authorization": "Bearer $token"
  };

  static Future<Map<String, String>> _generateHeader()async{
    token = await getToken("jwt-auth");
    return {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    };

  }
  // Don't really need a constructor, as we are not instantiating the Helper class

  //Gets token from the SecureStore if it doesn't exist instead of null it will return an empty string.
  static Future<String> getToken(String tokenKey) async {
    String? authToken = await SecureStore.getToken(tokenKey);
    if(authToken == null){
      return Future.value(" ");
    }
    return authToken;
  }


  static Future<String> post(String endpoint, var body) async {
    // Could actually store this in a field variable instead of calling the method for each
    //request
    http.Response response = await client
        .post(buildUrl(segment: endpoint), body: jsonEncode(body), headers: await _generateHeader());
    //Want to check here to see if the response was a success or it failed. status 200 would mean it is.
    // want to facilitate if the response is 201, like when creating an entity
    return _handleResponse(response);

  }

  static Future<String> get({String endpoint = "", String queryParams = ""}) async {
    var response = await client.get(buildUrl(segment: endpoint, query: queryParams), headers: await _generateHeader());
    return _handleResponse(response);

  }

  static Future <String> postMultipart(String endpoint, Map<String, String> body, List<Map<String, dynamic>> streams) async{
    http.MultipartRequest request = http.MultipartRequest("POST",buildUrl(segment: endpoint));
    request.headers.addAll(await _generateHeader());
    var multipartFileList = streams.map((element) {
      File dataFile = File(element["data"].path);
      return http.MultipartFile(element["field"], dataFile.readAsBytes().asStream(),dataFile.lengthSync(), filename: dataFile.path.split('/').last );
    });
    request.files.addAll(multipartFileList);
    request.fields.addAll(body);

    http.StreamedResponse response = await request.send();
    var streamToString = await response.stream.bytesToString();
    if(response.statusCode == 200 || response.statusCode == 201){
      return streamToString;
    }else{
      throw Exception(jsonDecode(streamToString)["error"]);
    }
  }

  static Future<String> patch(String endpoint, var changes) async {

    var response = await client.patch(buildUrl(segment: endpoint),
        body: changes,
        headers: await _generateHeader());

    return _handleResponse(response);
  }

  static Future<String> put(String endpoint, var changes) async {
    var response = await client.put(buildUrl(segment: endpoint),
        body: changes,
        headers: await _generateHeader());

    return _handleResponse(response);
  }

  static Future<String> delete(String endpoint) async {
    var response = await client.delete(buildUrl(segment: endpoint), headers: await _generateHeader());
    return _handleResponse(response);
  }

  //Here is where the uri is built
  // https://apicontact.fimijm.com/
  static buildUrl({String segment = "", query=""}) {
    Uri uri = Uri(
      scheme: "https",
      host: "farmers-directory.vercel.app",
      path: "/api/v1$segment",
      query: query,
    );

    return uri;
  }

//  Create a function to which handles responses. If there is an error or if the response is successfunl
  static String _handleResponse(http.Response response){
    if(response.statusCode == 200 || response.statusCode == 201){
      return response.body;
    }else{
      //  Describe what we should do if there is an error from the server.
      //  Could return a message to the user.
      print(jsonDecode(response.body)["error"]);
      throw Exception(jsonDecode(response.body)["error"]);
    }
  }
}
