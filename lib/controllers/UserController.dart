import 'package:epsp_sige/models/UserModel.dart';
import 'package:epsp_sige/utils/Endpoints.dart';
import 'package:epsp_sige/utils/Queries.dart';
import 'package:epsp_sige/utils/StockageKeys.dart';
import 'package:flutter/cupertino.dart';
import 'dart:core';
import 'dart:convert'; // Ajoutez cette ligne
import 'package:get_storage/get_storage.dart';

class UserController with ChangeNotifier {
  UserModel? user;
  bool initialLoadCompleted = false;
  String? token;
  bool loading = false;
  GetStorage? stockage = GetStorage();
  bool _isFirstTimeBienvenue = true;
  bool get isFirstTimeBienvenue {
    return stockage?.read<bool>(StockageKeys.is_first_time) ?? _isFirstTimeBienvenue;
  }

  set isFirstTimeBienvenue(bool value) {
    _isFirstTimeBienvenue = value;
    stockage?.write(StockageKeys.is_first_time, value);
  }

  UserController({this.stockage});

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  Future<HttpResponse> login(Map data) async {
    var url = "${Endpoints.login}";
    HttpResponse response = await postDataLogin(url, data);
    if (response.status) {
      // Stockage des tokens
      stockage?.write(StockageKeys.tokenKey, response.data?["access"] ?? "");
      stockage?.write(StockageKeys.refreshTokenKey, response.data?["refresh"] ?? "");

      // Stockage des infos utilisateur
      var userData = response.data?["user"];
      if (userData != null) {
        stockage?.write(StockageKeys.userDataKey, json.encode(userData));
      }

      notifyListeners();
    }
    return response;
  }

  void loadStoredUserData() {
    var userData = stockage?.read(StockageKeys.userDataKey);
    if (userData != null) {
      try {
        user = UserModel.fromJson(json.decode(userData));
        notifyListeners();
      } catch (e) {
        print("Error loading stored user data: $e");
      }
    }
  }

  Future<void> getDataAPI() async {
    loading = true;
    notifyListeners();

    try {
      var token = stockage?.read(StockageKeys.tokenKey);
      var response = await getData(Endpoints.userDetails, token: token);

      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey("data")) {
          user = UserModel.fromJson(response["data"] ?? {});
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      loading = false;
      initialLoadCompleted = true;
      notifyListeners();
    }
  }

  Future<HttpResponse> logout(Map data) async{
    var url = "${Endpoints.logout}";
    var tkn = stockage?.read(StockageKeys.tokenKey);
    HttpResponse response = await postData(url, data, token: tkn);
    if(response.status){
      print("Successsssssssssssssssssssssssssss");
      notifyListeners();
    }
    print(response.data);
    return response;
  }

  Future<HttpResponse> updateProfil(Map data) async {
    var url = "${Endpoints.updateProfil}";
    var token = stockage?.read(StockageKeys.tokenKey);

    print("I AM THE UPDATE PROFILE");
    HttpResponse response = await updateData(url, data, token: token);
    if (response.status) {
      var userData = response.data?['user'];
      if (userData != null) {
        user = UserModel.fromJson(userData);
        stockage?.write("user", userData);

        print("I AM THE SUCCEEDED UPDATE PROFILE");
        notifyListeners();
      }
    }
    return response;
  }
}


