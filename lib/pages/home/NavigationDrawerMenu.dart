import 'package:epsp_sige/controllers/UserController.dart';
import 'package:epsp_sige/pages/news/NotificationsPage.dart';
import 'package:epsp_sige/settings/SettingsPage.dart';
import 'package:epsp_sige/utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserController>(
          create: (_) => UserController(),
        ),
        // Other providers...
      ],
      child: NavigationDrawerMenu(),
    ),
  );
}

class NavigationDrawerMenu extends StatefulWidget {
  const NavigationDrawerMenu({super.key});

  @override
  State<NavigationDrawerMenu> createState() => _NavigationDrawerMenuState();
}

class _NavigationDrawerMenuState extends State<NavigationDrawerMenu> {
  late UserController userCtrl;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userCtrl = context.watch<UserController>();
  }
  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),
  );

  Widget buildHeader(BuildContext context) => Container(

    color: Color(0xFF040034),
    padding: EdgeInsets.only(
      top: 24 + MediaQuery.of(context).padding.top,
      bottom: 24,
    ),
    child: Column(
      children: [
        CircleAvatar(
          radius: 52,
          backgroundImage: AssetImage("${userCtrl.user?.image == null ? "assets/avatard.png" : userCtrl.user?.image!}"),
        ),
        SizedBox(height: 12,),
        Text('${userCtrl.user?.fullName==null ? "Fullname : null" : userCtrl.user?.fullName}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
          ),
        ),
        Text('${userCtrl.user?.email == null ? "Email : null" : userCtrl.user?.email}', style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),),
      ],
    ),
  );

  Widget buildMenuItems(BuildContext context) => Container(
    padding: EdgeInsets.all(24.0),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          leading: Icon(Icons.home_outlined),
          title: Text('Home'),
          onTap: (){
            Navigator.pushReplacementNamed(context, Routes.BottomNavigationPageRoutes);
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications_outlined),
          title: Text('Notifications'),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationsPage()));
            //Navigator.pushReplacementNamed(context, Routes.NotificationsPageRoutes);
          },
        ),
        ListTile(
          leading: Icon(Icons.settings_outlined),
          title: Text('Settings'),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
          },
        ),
        ListTile(
          leading: Icon(Icons.help_center_outlined),
          title: Text('Help and Comments'),
          onTap: (){
            showSnackBar(context, "Available soon !");
          },
        ),
        Divider(color: Colors.grey,),
        ListTile(
          leading: Icon(Icons.logout_outlined),
          title: Text('Logout'),
          onTap: (){
            openAlertDialog(context);
          },
        ),
      ],
    ),
  );

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
                    fontSize: 16),
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
                    fontSize: 16),),
              onPressed: () {
                setState(() {});
                var ctrl = context.read<UserController>();
                Map data = {};
                ctrl.logout(data);
                Navigator.pushNamedAndRemoveUntil(context, Routes.LoginPageRoutes, ModalRoute.withName('/homepage'),);
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
