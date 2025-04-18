import 'package:epsp_sige/utils/Routes.dart';
import 'package:epsp_sige/widgets/ReusableButtonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscoverPage extends StatefulWidget {
  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  bool isButtonPressedSignUp = false;
  bool iSButtonPressedSignIn = false;
  bool isButtonPressedLoginwithphonenumber = false;
  bool isButtonPressedSkipfornow = false;

/*  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var userCtrl = context.read<UserController>();
      if(userCtrl.isFirstTimeBienvenue){
        isFirstTimeBienvenueNavigate();
      }
    });
  }
  isFirstTimeBienvenueNavigate(){
    Navigator.popAndPushNamed(context, Routes.LoginPageRoutes);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(13.0),
                child: Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.16
                    ),
                    Container(
                      height: 70,
                      child: Image.asset(
                        'assets/logoesig.png',
                        width: 300,
                        height: 300,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.13),
                    Text(
                      'DISCOVER AMAZING THINGS AROUND YOU',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    ReusableButtonWidgets(
                        text: "Login",
                        textColor: Colors.white,
                        color: Color(0xFF336699),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.LoginPageRoutes);
                        },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.015),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
