import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.model.dart';

class SecureStore{
  //Creates a secure persistent storage location for simple data. Something like local storage.
  static final _storage = new FlutterSecureStorage();

  static void storeToken(String tokenKey, String token) async{
    await _storage.write(key: tokenKey, value: token);
  }

  static Future<String?> getToken(String tokenKey) async {
    return await _storage.read(key:tokenKey);
  }

  //Creates a storage entry for the user in the persistent storage created.
  static void createUser(Map userData){
    json.encode(userData);
    storeToken("user", jsonEncode(userData));
  }

  static Future<User> getUser() async{
    String? userData = await getToken("user"); //get token can return null so we need to tell dart that it may be;
    User user = User.fromJson(jsonDecode(userData!));
    print(user.first_name);
    return user;
  }

  static logout() async {
    await _storage.deleteAll();
  }

}