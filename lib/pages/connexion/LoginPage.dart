import 'dart:convert';

import 'package:epsp_sige/controllers/UserController.dart';
import 'package:epsp_sige/pages/accueil_enrolleur.dart';
import 'package:epsp_sige/utils/Queries.dart';
import 'package:epsp_sige/utils/Routes.dart';
import 'package:epsp_sige/utils/navigations.dart';
import 'package:epsp_sige/widgets/ChargementWidget.dart';
import 'package:epsp_sige/widgets/CustomVisibilityWidget.dart';
import 'package:epsp_sige/widgets/EntryFieldEmailWidgets.dart';
import 'package:epsp_sige/widgets/EntryFieldPasswordWidgets.dart';
import 'package:epsp_sige/widgets/MessageWidgets.dart';
import 'package:epsp_sige/widgets/ReusableButtonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool iSButtonPressedSignIn = false;
  //
  var box = GetStorage();
  //
  UserController? userController;

  //CustomVisibility Bloc variable
  bool isCancelButtonVisible = false;

  var email = TextEditingController(text: 'gombe');
  var password = TextEditingController(text: 'sigerdc');

  var formKey = GlobalKey<FormState>();
  bool isVisible = false;
  bool isLoadingWaitingAPIResponse = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    //box.erase();
    //
    userController = UserController(stockage: box);
  }

  @override
  Widget build(BuildContext context) {
    //
    //box.erase();
    //
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              _body(context),
              ChargementWidget(isVisible),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    //

    //
    return Form(
      key: formKey,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(06.0),
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Container(
                        height: 70,
                        child: Image.asset(
                          'assets/logo_esige_large.png',
                          width: 300,
                          height: 300,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Don\'t you have an account? Contact l'admin",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      EntryFieldEmailWidgets(
                        ctrl: email,
                        required: true,
                        label: "Email",
                        isEmail: false,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015),
                      EntryFieldPasswordWidgets(
                        ctrl: password,
                        label: "Password",
                        required: true,
                        isPassword: false,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Text(
                                'Forgot Password ? Contact l\'admin',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      ReusableButtonWidgets(
                        text: "Login",
                        fontSize: 14,
                        onPressed: () async {
                          //
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          );
                          //
                          final Map<String, dynamic> data = {
                            "email": email.text.trim(),
                            "password": password.text.trim(),
                          };
                          //postDataLogin("users/login", data, context);
                          postDataLogin("users/login", data, context);
                        },
                        color: Color(0xFF336699),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 1.0,
                              width: 75,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 11,
                            ),
                            Text(
                              'Or login with',
                              style: TextStyle(fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 11,
                            ),
                            Container(
                              height: 1.0,
                              width: 75,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {});
                              },
                              child: Image.asset(
                                "assets/facebook.png",
                                width: 30,
                                height: 30,
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.04),
                            InkWell(
                              onTap: () {
                                setState(() {});
                              },
                              child: Image.asset(
                                "assets/google.png",
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      CustomVisibilityWidget(
                        visible: isCancelButtonVisible,
                        onPressed: () {
                          setState(() {
                            isCancelButtonVisible = false;
                            isLoadingWaitingAPIResponse = false;
                          });
                        },
                        child: Text(
                          'Cancel query',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      // Add the logo here at the bottom
                      Image.asset(
                        'assets/logo_asp.png', // Or 'assets/logo_asp.png' if that's the correct file
                        width: 100,
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> LoginPressed() async {
  //   // Request focus on a new FocusNode to dismiss the keyboard
  //   FocusScope.of(context).requestFocus(FocusNode());
  //   // Validate the form
  //   if (!formKey.currentState!.validate()) {
  //     return;
  //   }
  //   // Show loading indicator
  //   setState(() {
  //     isVisible = true;
  //     isLoadingWaitingAPIResponse = true;
  //   });
  //   try {
  //     final ctrl = context.read<UserController>();
  //     final Map<String, dynamic> data = {
  //       "email": email.text.trim(),
  //       "password": password.text.trim(),
  //     };
  //     // Attempt to log in
  //     await ctrl.login(data);
  //     // Check if the response is successful
  //   } catch (e) {
  //     print(e.toString());
  //     print(e);
  //     MessageWidgets.showSnack(context, "Erreur inattendue: ${e.toString()}");
  //   } finally {
  //     // Hide loading indicator
  //     setState(() {
  //       isVisible = false;
  //       isLoadingWaitingAPIResponse = false;
  //     });
  //   }
  // }

  void _handleNavigation(Map<dynamic, dynamic>? response) {
    //
    box.write("user", response);
    //
    print("Role: ${jsonEncode(response?['etablissements'])}");
    var role = response?['sousProvedId'];
    //
    //Navigations.navigations = response?['navigations'] ?? [];
    //
    print("Role: $role");
    final List<Map<String, dynamic>> establishments =
        response?['etablissements'].cast<Map<String, dynamic>>() ?? [];
    if (role != null) {
      print("Establishments: $establishments");
      //Accueil
      //establishments
      Get.to(AccueilEnrolleur(response!));

    } else if (role == 'super_admin' ||
        role == 'admin_user' ||
        role == 'superv_national') {
      // Navigate to BottomNavigationPage with full access
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.BottomNavigationPageRoutes,
        ModalRoute.withName('/loginpage'),
      );
    } else if (role == 'superv_provincial') {
      // Navigate to BottomNavigationPage with provincial access
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.BottomNavigationPageRoutes,
        ModalRoute.withName('/loginpage'),
        arguments: {
          'accessLevel': 'provincial',
          'province': response?['userInfo']['user']['province'] ?? "",
        },
      );
    } else if (role == 'superv_provinceeducationelle') {
      // Navigate to BottomNavigationPage with proved access
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.BottomNavigationPageRoutes,
        ModalRoute.withName('/loginpage'),
        arguments: {
          'accessLevel': 'proved',
          'proved': response?['userInfo']['user']['proved'] ?? "",
        },
      );
    } else if (role == 'superv_sous_division') {
      // Navigate to BottomNavigationPage with sous-division access
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.BottomNavigationPageRoutes,
        ModalRoute.withName('/loginpage'),
        arguments: {
          'accessLevel': 'sous_division',
          'sous_division': response?['userInfo']['user']['sousproved'] ?? "",
        },
      );
    }
  }
}
