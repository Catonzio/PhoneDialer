import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_dialer/pages/PhoneDialer.dart';
import 'package:phone_dialer/pages/Register.dart';
import 'package:phone_dialer/helper/StateHolder.dart';
//import 'file:///C:/Users/danil/Projects/flutter/PhoneDialer/phone_dialer/lib/helper/StateHolder.dart';
//import 'helper/StateHolder.dart';
import 'pages/ContactsPage.dart';

void main() {
  runApp(PageMain());
}

class PageMain extends StatelessWidget {
  static final mainPageKey = new GlobalKey<MainPageState>();

  @override
  Widget build(BuildContext context) {
    checkPermissions();
    StateHolder.instance.getContacts();
    return MaterialApp(
      initialRoute: MainPage.routeName,
      routes: {
        MainPage.routeName: (context) => MainPage(key: mainPageKey),
        PhoneDialer.routeName: (context) => PhoneDialer()
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        accentColor: Colors.amber,
        primaryColor: Colors.black
      ),
    );
  }

  checkPermissions() async {
    final PermissionHandler permissionHandler = PermissionHandler();
    await permissionHandler.requestPermissions([PermissionGroup.contacts]);
  }
}

class MainPage extends StatefulWidget {
  static String routeName = "/main";

  const MainPage({Key key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(icon: new Icon(Icons.history),),
    Tab(icon: new Icon(Icons.call),),
    Tab(icon: new Icon(Icons.contacts),)
  ];

  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: tabs.length, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint("First build ${StateHolder.instance.contacts.length}");

    return Scaffold(
        body: TabBarView(
          controller: controller,
          //to disable the swipe between tabs
          physics: NeverScrollableScrollPhysics(),
          children: [
            new Register(),
            new PhoneDialer(),
            new ContactsPage(contacts: StateHolder.instance.contacts,)
          ],
        ),
        bottomNavigationBar: TabBar(
          controller: controller,
          tabs: tabs,
          labelColor: Theme.of(context).accentColor,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
        ),
      );
  }
}



