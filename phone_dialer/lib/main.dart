import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_dialer/PhoneDialer.dart';
import 'ContactsPage.dart';

void main() {
  runApp(PageMain());
}

class PageMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    checkPermissions();
    return MaterialApp(
      initialRoute: MainPage.routeName,
      routes: {
        MainPage.routeName: (context) => MainPage(),
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }

  checkPermissions() async {
    final PermissionHandler permissionHandler = PermissionHandler();
    await permissionHandler.requestPermissions([PermissionGroup.contacts]);
  }
}

class MainPage extends StatelessWidget{
  static String routeName = "/main";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            new Container(color: Colors.yellow,),
            new PhoneDialer(),
            new ContactsPage()
          ],
        ),
        bottomNavigationBar: TabBar(
          //controller: TabController(),
          tabs: [
            Tab(icon: new Icon(Icons.history),),
            Tab(icon: new Icon(Icons.call),),
            Tab(icon: new Icon(Icons.contacts),)
          ],
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Colors.green,
        ),
      ),
    );
  }
}



