import 'package:get/get.dart';

class Requete extends GetConnect {
  //
  String url = "http://localhost:8080/";
  //static String urlSt = "http://10.0.2.2:8080/";
  //
  Future<Response> getE(
    String path,
  ) async {
    print("path: $path");
    return get("$url$path");
  }

  //
  Future<Response> postE(String path, var object) async {
    print("$url$path");
    return post("$url$path", object);
  }

  //
  Future<Response> putE(String path, var object) async {
    return put("$url$path", object);
  }

  //
  Future<Response> deleteE(String path) async {
    return delete("$url$path");
  }
}
