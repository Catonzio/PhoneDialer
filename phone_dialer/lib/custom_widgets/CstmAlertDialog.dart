import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CstmAlertDialog extends StatelessWidget {

  final String dialogTitle;
  final Widget body;
  final String continueText;
  final Function pressed;
  final double height;
  final Function state;

  CstmAlertDialog({
    Key key,
    this.dialogTitle,
    this.body,
    this.continueText,
    this.pressed,
    this.height,
    this.state
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

    return AlertDialog(
      title: Text(dialogTitle),
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content:
      StatefulBuilder(
        builder: (context, state) {
          return Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.20,
              child: body
          );
        },
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
  }

}