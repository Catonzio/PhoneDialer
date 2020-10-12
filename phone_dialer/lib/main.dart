import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_dialer/helper/CurrentSettings.dart';
import 'package:phone_dialer/pages/PhoneDialer.dart';
import 'package:phone_dialer/pages/Register.dart';
import 'package:phone_dialer/helper/StateHolder.dart';
import 'package:phone_dialer/pages/SettingsPage.dart';
import 'package:phone_dialer/pages/TrialContactsPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if((await Permission.contacts.request().isGranted) && (await Permission.phone.request().isGranted)) {
    runApp(PageMain());
  } else {
    //SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    exit(0);
  }
}

class PageMain extends StatelessWidget {
  static final mainPageKey = new GlobalKey<MainPageState>();
  static final defaultPrefix = "4146";

  @override
  Widget build(BuildContext context) {
    CurrentSettings.instance.prefix = defaultPrefix;
    return MaterialApp(
      initialRoute: MainPage.routeName,
      routes: {
        MainPage.routeName: (context) => MainPage(key: mainPageKey),
        PhoneDialer.routeName: (context) => PhoneDialer(),
        SettingsPage.routeName: (context) => SettingsPage()
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        accentColor: Colors.amber,
        primaryColor: Colors.black
      ),
    );
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
    //checkPermissions();
    StateHolder.instance.getContacts();
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
            new TrialContactsPage(contacts: StateHolder.instance.contacts,)
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

  /*checkPermissions() async {
    final PermissionHandler permissionHandler = PermissionHandler();
    await permissionHandler.requestPermissions([PermissionGroup.contacts]);
    if((await permissionHandler.checkPermissionStatus(PermissionGroup.contacts)) == PermissionStatus.granted)
      debugPrint("Bella zio");
  }*/
}



