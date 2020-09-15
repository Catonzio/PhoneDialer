import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (
            Padding(
              child: Text(
                'Register',
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
        backgroundColor: Colors.black,
      ),
      body: Container(

      ),
    );
  }

}