import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<String> notifications = [
    "You have sent money 100\$ to Murdoch",
    "You have withdrowed 500\$ via M-PESA",
    "Fincodern whish you a good day",
    "Enoch Ntumba sent to you 1.000\$ via Equity-BCDC",
    "You transfered to Abraham Nlandu 650\$",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            child: Icon(Icons.arrow_back, color: Colors.white,),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Notifications',
              style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF040034),
          actions: [
            Theme(
              data: Theme.of(context).copyWith(
                  //textTheme: TextTheme().apply(bodyColor: Colors.black),
                  dividerColor: Colors.black,
                  iconTheme: IconThemeData(color: Colors.white)),
              child: PopupMenuButton<int>(
                color: Colors.white,
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                      value: 1,
                      child: InkWell(
                        onTap: () {
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.short_text_outlined,
                              color: Colors.orange,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text("Short by date", style: TextStyle(color: Colors.black),)
                          ],
                        ),
                      )),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                      value: 2,
                      onTap: () async {

                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 7,
                          ),

                          Text("Delete all",style: TextStyle(color: Colors.black))
                        ],
                      )),
                ],
              ),
            )
          ]
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.all(15),
                child: InkWell(
                  onTap: (){},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.notifications, color: Colors.orange,),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              notifications[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              "A few minutes ago",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(child: Icon(Icons.more_horiz), onTap: (){},),
                    ],
                  ),
                ),
              ),
              Divider(height: 1, color: Colors.grey,)
            ],
          );
        },
      ),
    );
  }
}
