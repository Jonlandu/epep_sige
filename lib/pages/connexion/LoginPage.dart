import 'package:epsp_sige/controllers/UserController.dart';
import 'package:epsp_sige/utils/Routes.dart';
import 'package:epsp_sige/widgets/ChargementWidget.dart';
import 'package:epsp_sige/widgets/CustomVisibilityWidget.dart';
import 'package:epsp_sige/widgets/EntryFieldEmailWidgets.dart';
import 'package:epsp_sige/widgets/EntryFieldPasswordWidgets.dart';
import 'package:epsp_sige/widgets/MessageWidgets.dart';
import 'package:epsp_sige/widgets/ReusableButtonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool iSButtonPressedSignIn = false;

  //CustomVisibility Bloc variable
  bool isCancelButtonVisible = false;

  var email = TextEditingController(text: 'josuenlandu@esige.com');
  var password = TextEditingController(text: 'Josue12345');

  var formKey = GlobalKey<FormState>();
  bool isVisible = false;
  bool isLoadingWaitingAPIResponse = false;

  @override
  Widget build(BuildContext context) {
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
                  child : Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                      Container(
                        height: 70,
                        child: Image.asset(
                          'assets/logoesig.png',
                          width: 300,
                          height: 300,
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.06),

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
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                      EntryFieldEmailWidgets(
                        ctrl: email,
                        required: true,
                        label: "Email",
                        isEmail: false,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      EntryFieldPasswordWidgets(
                        ctrl: password,
                        label: "Password",
                        required: true,
                        isPassword: false,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {

                              },
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

                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      ReusableButtonWidgets(
                          text: "Login",
                          fontSize: 14,
                          onPressed: isLoadingWaitingAPIResponse ? null : _handleLoginPressed,
                          color: Color(0xFF336699),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
                            SizedBox(width: 11,),
                            Text(
                              'Or login with',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 11,),
                            Container(
                              height: 1.0,
                              width: 75,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {

                                });
                              },
                              child: Image.asset(
                                "assets/facebook.png",
                                width: 30,
                                height: 30,
                              ),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.height * 0.04),
                            InkWell(
                              onTap: () {
                                setState(() {

                                });
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

                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
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
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
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

  Future<void> LoginPressed() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isVisible = true;
      isLoadingWaitingAPIResponse = true;
    });

    try {
      final ctrl = context.read<UserController>();
      final Map<String, dynamic> data = {
        "username": email.text.trim(),
        "password": password.text.trim()
      };

      final response = await ctrl.login(data); // This already calls _handleLoginResponse internally

      //if (response.status) {
      if (true) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.BottomNavigationPageRoutes,
          ModalRoute.withName('/loginpage'),
        );

        MessageWidgetsSuccess.showSnack(
            context,
            response.data?['message'] ?? "Connexion réussie"
        );
      } else {
        final errorMsg = (response.isException ?? false)
            ? (response.errorMsg ?? "Erreur inconnue")
            : (response.data?['message'] ?? "Échec de la connexion");

        MessageWidgets.showSnack(context, errorMsg);
      }
    } catch (e) {
      MessageWidgets.showSnack(context, "Erreur inattendue: ${e.toString()}");
    } finally {
      setState(() {
        isVisible = false;
        isLoadingWaitingAPIResponse = false;
      });
    }
  }

  void _handleLoginPressed() async {
    if(isLoadingWaitingAPIResponse) return;
    setState(() {
      isLoadingWaitingAPIResponse = true;
      isCancelButtonVisible = true;
    });

    await LoginPressed();

    setState(() {
      isLoadingWaitingAPIResponse = false;
      isCancelButtonVisible = false;
    });
  }
}
