import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_dialer/custom_widgets/CstmAlertDialog.dart';
import 'package:phone_dialer/custom_widgets/CstmStuff.dart';
import 'package:phone_dialer/helper/CurrentSettings.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  static String routeName = "/phoneDialer";

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {

  final Set<String> prefixes = {"4146", "#31#", "+39", "00"};
  int selectedRadio;

  @override
  void initState() {
    selectedRadio = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "Settings",
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.grey,),
            MaterialButton(
              //minWidth: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Prefix", style: TextStyle(fontSize: 20),)
              ),
              onPressed: () => selectPrefix(),
            ),
            Divider(color: Colors.grey,),
            MaterialButton(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("About", style: TextStyle(fontSize: 20),)
              ),
              onPressed: () => debugPrint("About"),
            ),
            Divider(color: Colors.grey,),
          ],
        ),
      ),
    );
  }

  selectPrefix() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CstmAlertDialog(
            continueText: "Ok",
            dialogTitle: "Select a prefix",
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: getListOfRadios(),
                )
              ],
            ),
            pressed: () {
              CurrentSettings.instance.prefix = prefixes.toList()[selectedRadio];
              Navigator.of(context).pop();
              debugPrint("CurrentPrefix: ${CurrentSettings.instance.prefix}");
              PageMain.mainPageKey.currentState.controller.animateTo(1);
            },
          );
        }
    );
  }

  getListOfRadios() {
    return ListView.builder(
      //physics: const NeverScrollableScrollPhysics(),
      itemCount: prefixes.length,
      itemBuilder: (context, index) {
        return RadioListTile(
          value: index,
          groupValue: selectedRadio,
          title: Text(prefixes.toList()[index]),
          onChanged: (value) {
            setState(() {
              selectedRadio = value;
            });
          },
        );
      },
    );
  }
}