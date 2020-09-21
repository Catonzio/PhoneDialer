import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_dialer/pages/SettingsPage.dart';

class DefaultPage extends StatelessWidget {

  final String title;
  final Widget body;
  final bool showSettingsButton;

  DefaultPage(
    {
      Key key,
      this.title,
      this.body,
      this.showSettingsButton
    }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (
            Padding(
              child: Text(
                '$title',
                style: TextStyle(
                  decoration:
                  TextDecoration.underline,
                  height: 1.5,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto-Regular',
                ),
              ),
              padding: EdgeInsets.all(2),
            )
        ),
        actions: [
          //To check if the settings button should be visualized
          showSettingsButton == true ?
          MaterialButton(
            child: Icon(Icons.settings),
            onPressed: () => Navigator.of(context).pushNamed(SettingsPage.routeName),
          ) : Container()
        ],
        //backgroundColor: Colors.black,
      ),
      body: body,
    );
  }

}

class CstmIconButton extends StatelessWidget {
  final Icon icon;
  final Function onPressed;

  CstmIconButton({Key key,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: onPressed
    );
  }

}