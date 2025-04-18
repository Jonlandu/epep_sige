import 'package:epsp_sige/models/UserModel.dart';
import 'package:epsp_sige/utils/Endpoints.dart';
import 'package:epsp_sige/utils/Queries.dart';
import 'package:epsp_sige/utils/StockageKeys.dart';
import 'package:flutter/cupertino.dart';
import 'dart:core';
import 'package:get_storage/get_storage.dart';

class UserController with ChangeNotifier {
  UserModel? user;
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
    HttpResponse response = await postData(url, data);
    if (response.status) {
      stockage?.write(StockageKeys.tokenKey, response.data?["accessToken"] ?? "");
      print("TOKEN LOGIN CONTROLLER ::::::::::::::::::: ${response.data?["accessToken"]}");
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> register(Map data) async{
    var url = "${Endpoints.register}";
    HttpResponse response = await postData(url, data);
    if (response.status) {
      stockage?.write(StockageKeys.userKey, response.data?['data']['userId'] ?? {});
      notifyListeners();
    }
    return response;
  }

  void getDataAPI() async {
    var token = stockage?.read(StockageKeys.tokenKey);
    var url = Endpoints.userDetails;
    loading = true;
    notifyListeners();
    var response = await getData(url, token: token);
    if (response != null && response is Map<String, dynamic>) {
      if (response.containsKey("data")) {
        user = UserModel.fromJson(response["data"] ?? {});
        print("USER INFO ::::::::::::::::::: ${user?.fullName}");
        printWrapped("PRINT WRAP DE RESPONSE.DATA : ${response["data"]}");
      }
      notifyListeners();
    }
    loading = false;
    notifyListeners();
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

  Future<HttpResponse> verifyOTPRequest(Map data) async {
    var url = "${Endpoints.verifyOTP}";
    HttpResponse response = await postData(url, data);
    if (response.status) {
      var userData = response.data?['user'];
      if (userData != null) {
        user = UserModel.fromJson(userData);
      }
      //user = UserModel.fromJson(response.data?['user'] ?? {});
      stockage?.write(StockageKeys.tokenKey, response.data?["accessToken"] ?? "");
      //stockage?.read(StockageKeys.tokenKey, response.data?['user']);
      printWrapped("VERIFY OTP RESPONSE : $user");
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> PhoneNumberverifyOTPRequest(Map data) async {
    var url = "${Endpoints.verifyLoginOTPPhoneNumber}";
    HttpResponse response = await postData(url, data);
    if (response.status) {
      var userData = response.data?['user'];
      if (userData != null) {
        user = UserModel.fromJson(userData);
      }
      //user = UserModel.fromJson(response.data?['user'] ?? {});
      stockage?.write(StockageKeys.tokenKey, response.data?["accessToken"] ?? "");
      //stockage?.read(StockageKeys.tokenKey, response.data?['user']);
      printWrapped("VERIFY OTP RESPONSE : $user");
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> ResendPhoneNumberverifyOTPRequest(Map data) async {
    var url = "${Endpoints.resendVerifyLoginOTPPhoneNumber}";
    HttpResponse response = await postData(url, data);
    if (response.status) {
      var userData = response.data?['user'];
      if (userData != null) {
        user = UserModel.fromJson(userData);
      }
      //user = UserModel.fromJson(response.data?['user'] ?? {});
      stockage?.write(StockageKeys.tokenKey, response.data?["accessToken"] ?? "");
      //stockage?.read(StockageKeys.tokenKey, response.data?['user']);
      printWrapped("VERIFY OTP RESPONSE : $user");
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> resendVerifyOTPRequest(Map data) async {
    var url = "${Endpoints.resend_requestPasswordReset_OTP}";
    HttpResponse response = await postData(url, data);
    if (response.status) {
      var userData = response.data?['user'];
      if (userData != null) {
        user = UserModel.fromJson(userData);
      }
      //user = UserModel.fromJson(response.data?['user'] ?? {});
      stockage?.write(StockageKeys.tokenKey, response.data?["accessToken"] ?? "");
      //stockage?.read(StockageKeys.tokenKey, response.data?['user']);
      printWrapped("VERIFY OTP RESPONSE : $user");
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> verifyOTPRequestSignUp(Map data) async {
    var url = "${Endpoints.verifyOTPRegister}";
    HttpResponse response = await postData(url, data);
    if (response.status) {
      var userData = response.data?['user'];
      if (userData != null) {
        user = UserModel.fromJson(userData);
      }
      //user = UserModel.fromJson(response.data?['user'] ?? {});
      stockage?.write(StockageKeys.tokenKey, response.data?["accessToken"] ?? "");
      //stockage?.read(StockageKeys.tokenKey, response.data?['user']);
      printWrapped("VERIFY OTP RESPONSE : $user");
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> requestOTPPhoneNumber(Map data) async {
    var url = "${Endpoints.login_with_phoneNumber}";
    HttpResponse response = await postData(url, data);
    //printWrapped("REQUEST OTP : ${response.data}");
    //print("TEST OF MY FUNCTIONNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN");
    if (response.status) {
      stockage?.write(StockageKeys.userKey, response.data?['data']['userId'] ?? {});
      printWrapped("REQUEST OTP VOICI : ${response.data}");
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> ResendOTPForLoginWithPhoneNumber(Map data) async {
    var url = "${Endpoints.resend_login_OTP}";
    HttpResponse response = await postData(url, data);
    if (response.status) {
      stockage?.write(StockageKeys.userKey, response.data?['data']['userId'] ?? {});
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> SendOTPRequest(Map data) async {
    var url = "${Endpoints.login_with_phoneNumber}";
    HttpResponse response = await sendOTP(url, data);
    if (response.status) {
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> updateUserPasswordVerifyEmail(Map data) async {
    var url = "${Endpoints.RequestUpdatePassword}";
    HttpResponse response = await postData(url, data);
    print("I am outSide");
    if (response.status) {
      stockage?.write(StockageKeys.userKey, response.data?['data']['userId'] ?? {});
      print("I am insoide");
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> changePassword(Map data) async {
    var url = "${Endpoints.changepassword}";
    var tkn = stockage?.read(StockageKeys.tokenKey);
    HttpResponse response = await postData(url, data, token: tkn);
    print("I am outSide");
    if (response.status) {
      //stockage?.write(StockageKeys.userKey, response.data?['data']['userId'] ?? {});
      print("I am succeddddddddddddddddddddddddddddddddddddddd");
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> createNewPassword(Map data) async {
    var url = "${Endpoints.createNewPassword}";
    HttpResponse response = await postData(url, data);
    print("I am outSide");
    if (response.status) {
      stockage?.write(StockageKeys.userKey, response.data?['data'] ?? {});
      print("Password changed");
      notifyListeners();
    }
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


