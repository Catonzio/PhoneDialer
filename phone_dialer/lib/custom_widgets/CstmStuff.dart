import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultPage extends StatelessWidget {

  final String title;
  final Widget body;

  DefaultPage(
    {
      Key key,
      this.title,
      this.body
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