import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CstmAlertDialog extends StatelessWidget {

  final String dialogTitle;
  final Widget body;
  final String continueText;
  final Function pressed;
  final double height;

  CstmAlertDialog({
    Key key,
    this.dialogTitle,
    this.body,
    this.continueText,
    this.pressed,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
        child: Text(continueText),
        onPressed: pressed
    );

    return Container(
      child: AlertDialog(
        title: Text(dialogTitle),
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content:
        Container(
            height: this.height,
            child: body
        ),
        actions: [
          cancelButton,
          continueButton,
        ],
      ),
    );

  }

}