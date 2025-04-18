import 'package:epsp_sige/controllers/UserController.dart';
import 'package:epsp_sige/settings/SettingsPage.dart';
import 'package:epsp_sige/utils/Routes.dart';
import 'package:epsp_sige/widgets/ChargementWidget.dart';
import 'package:epsp_sige/widgets/MessageWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {

  bool isCancelButtonPressed = false;
  bool isConfirmButtonPressed = false;
  bool isLogOutButtonPressed = false;
  GetStorage box = GetStorage();

  bool isVisible = false; // A flag to control the visibility of a loading widget
  bool isLoadingWaitingAPIResponse = false; // A flag to indicate if an API request is in progress

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero, () {
        var userCtrl = context.read<UserController>();
        userCtrl.getDataAPI();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: SizedBox(width: 0,),
        title: Text(
          'Profil',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Color(0xFF040034),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Expanded(
                    child: _body(),
                  ),
                ],
              ),
            ),
            ChargementWidget(isVisible),
          ],
        ),
      ),
    );
  }

  Widget _body(){
    var userCtrl = context.watch<UserController>();

    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                child: Center(
                  child: CircleAvatar(
                    radius: 52,
                    child: CircleAvatar(
                      radius: 52,
                      backgroundImage: AssetImage("${userCtrl.user?.image == null ? "assets/avatard.png" : userCtrl.user?.image!}"),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -13,
                left: MediaQuery.of(context).size.width * 0.0,
                right: MediaQuery.of(context).size.width * 0.0,
                child: Container(
                  margin: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: Offset(-5, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  '${userCtrl.user?.fullName == null ? "Fullname : null" : userCtrl.user?.fullName}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.phone_outlined,
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.04),
              Text(
                "${userCtrl.user?.phone == null ? "Phone : null" : userCtrl.user?.phone}",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.mail_outline,
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.04),
              Text(
                "${userCtrl.user?.email == null ? "Email : null" : userCtrl.user?.email}",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Container(
          height: 1.0,
          width: double.infinity,
          color: Colors.grey,
        ),
        ListTile(
          title: Text(
            'Edit Profil',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          leading: Icon(
            Icons.edit_outlined,
            size: 20,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 17,
          ),
          onTap: () {
            Navigator.pushNamed(context, Routes.EditProfilePageRoutes);
          },
        ),
        ListTile(
          title: Text(
            'My QR Code',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          leading: Icon(
            Icons.qr_code_outlined,
            size: 20,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 17,
          ),
          onTap: () {
            showSnackBar(context, "Available soon !");
          },
        ),
        ListTile(
          title: Text(
            'Help and Comments ',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          leading: Icon(
            Icons.help_center_outlined,
            size: 20,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 17,
          ),
          onTap: () {
            showSnackBar(context, "Available soon !");
          },
        ),
        ListTile(
          leading: Icon(Icons.settings_outlined),
          title: Text('Settings'),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
          },
        ),
        Container(
          height: 1.0,
          width: double.infinity,
          color: Colors.grey,
        ),
        ListTile(
          title: Text(
            'Logout',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          leading: Icon(
            Icons.logout_outlined,
            size: 20,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 17,
          ),
          onTap: () {
            openAlertDialog(context);
          },
        ),
      ],
    );
  }

  openAlertDialog(context) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Do you really want to logout?"),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(
                    fontSize: 16
                ),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: Text(
                "Confirm",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 16),
              ),
              onPressed: () {
                isLoadingWaitingAPIResponse ? null : _handleLogoutPressed();
              },
            ),
          ],
        );
      },
    );
    if (result != null) {
      var message = !result ? "Logout canceled" : "Logged out";
      showSnackBar(context, message);
    }
  }

  Future<void> LogoutPressed() async {
    if (!mounted) return; // Check if the widget is still mounted before calling setState()

    isVisible = true;
    setState(() {
      isLoadingWaitingAPIResponse = true;
    });

    // Only access the context if the widget is still mounted
    final BuildContext context = this.context;

    var ctrl = context.read<UserController>();
    Map data = {};

    var response = await ctrl.logout(data);
    await Future.delayed(Duration(seconds: 1));

    isVisible = false;
    setState(() {
    });

    if (response.status) {
      await Future.delayed(Duration(seconds: 5));
      setState(() {});
      Navigator.pushNamedAndRemoveUntil(context, Routes.LoginPageRoutes, ModalRoute.withName('/homepage'),);

      var msg = (response.data?['message']);
      MessageWidgetsSuccess.showSnack(context, msg);

    } else {
      var msg = response.isException == true ? response.errorMsg : (response.data?['message']);
      MessageWidgets.showSnack(context, msg, Colors.red);
    }
    setState(() {
      isLoadingWaitingAPIResponse = false;
    });

  }

  void _handleLogoutPressed() async {
    if(isLoadingWaitingAPIResponse) return;

    setState(() {
      isLoadingWaitingAPIResponse = true;
    });

    await LogoutPressed();

    setState(() {
      isLoadingWaitingAPIResponse = false;
    });
  }

  showSnackBar(context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Ok',
          textColor: Colors.orange,
          onPressed: scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }
}
