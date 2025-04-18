import 'package:epsp_sige/controllers/UserController.dart';
import 'package:epsp_sige/pages/home/MyHomePage.dart';
import 'package:epsp_sige/pages/user/ProfilPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {

  int _currentIndex = 0;
  Color other = Colors.grey;
  Color selectedItem = Colors.orange;
  GetStorage box = GetStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var userCtrl = context.read<UserController>();
      userCtrl.getDataAPI();
    });
  }

  final pages = [
    MyHomePage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  Widget _bottomNavigation(){
    context.watch<UserController>();
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, -2), // Décalage vers le haut pour l'ombre
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        unselectedItemColor: other,
        selectedItemColor: selectedItem,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            other = Colors.grey;
            selectedItem = Colors.orange;
          });
        },
      ),
    );
  }
}