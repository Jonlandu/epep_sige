import 'dart:convert';
import 'package:epsp_sige/utils/Constantes.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../apps/MonApplication.dart';

class HttpResponse {
  bool status;
  Map? data;
  String? errorMsg;
  bool? isError;
  bool? isException;

  HttpResponse(
      {required this.status,
      this.data,
      this.errorMsg,
      this.isError,
      this.isException});
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Future<dynamic> getData(String url_api, {String? token}) async {
  try {
    var url = "${Constantes.BASE_URL}$url_api";
    var dio = Dio();

    int milliseconds = 10000;
    Duration? duration = Duration(milliseconds: milliseconds);

    dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.connectTimeout = duration; // 1 second

    var response = await dio.get(url);
    //dio.interceptors.add(alice.getDioInterceptor());

    print(
        "BEHOLD THE ANSWER OF GETDATA API FUNCTION : $response"); // To remove after

    if (response.statusCode == 200) {
      if (response.data is String) {
        return json.decode(response.data);
      } else {
        return response.data;
      }
    }
    //return json.decode(response.body);
    return null;
  } catch (e, trace) {
    print(e.toString());
    print(trace.toString());
    print(
        "Salut Mardochééééééééééééééééééééééééééééééééééééééé Voici le TOKEN : $token");
    print(
        "Salut Mardochééééééééééééééééééééééééééééééééééééééé Voici l'url : ${Constantes.BASE_URL}$url_api");
    return null;
  }
}

Future<HttpResponse> postData(String api_url, Map data, {String? token}) async {
  try {
    var url = Uri.parse("${Constantes.BASE_URL}$api_url");

    String dataStr = json.encode(data);
    var _tkn = token;
    var response = await http.post(url, body: dataStr, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $_tkn"
    }).timeout(Duration(seconds: 10));

    print("JOSHUA TO SEE IF EVERYTHING GOES WELL : ${data}");
    var successList = [200, 201];
    var msg = json.decode(response.body);
    var st = successList.contains(response.statusCode);
    if (response.statusCode == 500) throw Exception(msg);
    printWrapped("BEHOLD THE INTERE RESPOSE : ${response.body}");
    return HttpResponse(status: st, data: msg);
  } catch (e, trace) {
    printWrapped(e.toString());
    printWrapped(trace.toString());
    print("Something wrong post data");

    return HttpResponse(
        status: false,
        errorMsg: "Unexpected error, connexion's problem",
        isException: true);
  }
}

Future<HttpResponse> postDataLogin(String api_url, Map data,
    {String? token}) async {
  try {
    var url = Uri.parse("${Constantes.BASE_URL}/$api_url");
    String dataStr = json.encode(data);

    // Ne pas inclure le header Authorization si le token est null
    var headers = {
      "Content-Type": "application/json",
    };

    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    }

    var response = await http
        .post(url, body: dataStr, headers: headers)
        .timeout(Duration(seconds: 10));

    var successList = [200, 201];
    var msg = json.decode(response.body);
    var st = successList.contains(response.statusCode);

    if (response.statusCode == 500) throw Exception(msg);
    print("Josue nlandu Lucien ma reponse: ${response.body}");
    return HttpResponse(status: st, data: msg);
  } catch (e, trace) {
    print("Error: $e");
    print("Stack trace: $trace");
    return HttpResponse(
        status: false,
        errorMsg: "Unexpected error, connexion's problem",
        isException: true);
  }
}

Future<HttpResponse> updateData(String endpoint, Map data,
    {String? token}) async {
  try {
    final url = "${Constantes.BASE_URL}$endpoint";
    final jsonData = json.encode(data);

    final response = await http.put(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonData,
    );

    printWrapped("VOICI JOSUE UPDATE ${response.body}");
    final successList = [200, 201];
    final message = json.decode(response.body);
    final status = successList.contains(response.statusCode);

    if (response.statusCode == 500) {
      throw Exception(message);
    }
    print("I AME THE updateData FONCTION");
    print("I AME THE updateData FONCTION BEHOLD THE TOKEN : $token");
    printWrapped(
        "I AME THE updateData FONCTION BEHOLD THE RESPONSE : ${response.body}");
    return HttpResponse(status: status, data: message);
  } catch (e, trace) {
    printWrapped(e.toString());
    printWrapped(trace.toString());
    print("I AME THE updateData FONCTION BUT INSIDE CATCH WHAT IS HAPPENING ?");

    return HttpResponse(
      status: false,
      errorMsg: "Something wrong happened!",
      isException: true,
    );
  }
}

/*Future<dynamic> updateData(String endpoint, Map data, {String? token}) async {
  final dio = Dio();

  try{
    final url = "${Constantes.BASE_URL}$endpoint";
    var _tkn = token;

    String jsonData = json.encode(data);

    final response = await dio.put(url, data: jsonData,
      options: Options(
        followRedirects: false,
        contentType: "application/json",
        headers: {
          'Authorization':'Bearer $_tkn',
          "Accept" : "application/json"
        },
      ),
    );

    var successList = [200, 201];
    var msg = json.decode(response.data);
    var st = successList.contains(response.statusCode);
    if (response.statusCode == 500) throw Exception(msg);

    printWrapped(response.toString());

    return HttpResponse(status: st, data: msg); // {"status": st, "m

  }catch(e, trace) {
    printWrapped(e.toString());
    printWrapped(trace.toString());
    print("I am cacthedddddddddddddddddddddddddddddddddddddddddddd");
    return HttpResponse(
        status: false,
        errorMsg: "Erreur inattendue, Problème de connexion",
        isException: true
    ); // {"status": st, "msg": msg};{
  }
}*/

Future<HttpResponse> sendOTP(String api_url, Map data, {String? token}) async {
  try {
    var url = Uri.parse("${Constantes.BASE_URL}$api_url");
    String dataStr = json.encode(data);
    var response = await http.post(url, body: dataStr, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    }).timeout(Duration(seconds: 1));

    var successList = [200, 201];
    var message = json.decode(response.body);
    var status = successList.contains(response.statusCode);
    if (response.statusCode == 500) throw Exception(message);
    return HttpResponse(status: status, data: message);
  } catch (e, trace) {
    printWrapped(e.toString());
    printWrapped(trace.toString());

    return HttpResponse(
        status: false,
        errorMsg: "Something wrong happened !",
        isException: true);
  }
}

Future<HttpResponse> updatePassword(String endpoint, Map data,
    {String? token}) async {
  try {
    final url = "${Constantes.BASE_URL}$endpoint";

    final jsonData = json.encode(data);

    final response = await http.put(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonData,
    );

    final successList = [200, 201];
    final message = json.decode(response.body);
    final status = successList.contains(response.statusCode);

    if (response.statusCode == 500) {
      throw Exception(message);
    }

    return HttpResponse(status: status, data: message);
  } catch (e, trace) {
    printWrapped(e.toString());
    printWrapped(trace.toString());

    return HttpResponse(
      status: false,
      errorMsg: "Something wrong happened!",
      isException: true,
    );
  }
}

Future<HttpResponse> deleteData(String endpoint, {String? token}) async {
  try {
    final url = "${Constantes.BASE_URL}$endpoint";

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      },
    );

    final successList = [200, 201];
    final message = json.decode(response.body);
    final status = successList.contains(response.statusCode);

    if (response.statusCode == 500) {
      throw Exception(message);
    }

    return HttpResponse(status: status, data: message);
  } catch (e, trace) {
    printWrapped(e.toString());
    printWrapped(trace.toString());

    return HttpResponse(
      status: false,
      errorMsg: "Something wrong happened!",
      isException: true,
    );
  }
}
