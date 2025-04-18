import 'package:flutter/material.dart';

class LockByThumbPrintPage extends StatefulWidget {
  const LockByThumbPrintPage({super.key});

  @override
  State<LockByThumbPrintPage> createState() => _LockByThumbPrintPageState();
}

class _LockByThumbPrintPageState extends State<LockByThumbPrintPage> {

  bool isSwitched = false;
  bool activatedSwitchButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xFF040034),
        title: Text('Lock by Thumb Print',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Unlocking with fingerprint',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'when this option is enabled, you will need to use your fingerprint to open FincoPay.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      activatedSwitchButton = isSwitched;
                    });
                  },
                  activeTrackColor: Colors.orange,
                  activeColor: Color(0xFF040034),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
