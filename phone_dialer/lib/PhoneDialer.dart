import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:phone_dialer/StateHolder.dart';

class PhoneDialer extends StatefulWidget {
  static String routeName = "/phoneDialer";

  @override
  _PhoneDialerState createState() => _PhoneDialerState();
}

class _PhoneDialerState extends State<PhoneDialer> {
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    controller.text = StateHolder.instance.phoneNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //SizedBox(height: 200,),
            Padding(
              child: TextField(
                focusNode: AlwaysDisabledFocusNode(),
                controller: controller,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
                decoration: InputDecoration(
                    border: InputBorder.none
                ),
              ),
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: GridView.count(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: List.generate(9, (index) {
                    return Center(
                      child: MaterialButton(
                          child: Text(
                            '${index+1}',
                            style: TextStyle(
                                fontSize: 30
                            ),
                          ),
                          onPressed: () => _changed(index)
                      ),
                    );
                  })
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.16,
              child: GridView.count(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                crossAxisCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MaterialButton(),
                  IconButton(
                    icon: Icon(Icons.phone, color: Colors.green, size: 50,),
                    onPressed: call3,
                  ),
                  getDeleteButton()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _changed(int index) {
    setState(() {
      controller.text += '${index+1}';
    });
  }

  Future<void> call3() async {
    String number = '4146${controller.text}';
    bool res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  getDeleteButton() {
    if(controller.text.isNotEmpty)
      return IconButton(
        icon: Icon(Icons.backspace, color: Colors.red[900],),
        onPressed: () {
          setState(() {
            controller.text = controller.text.substring(0, controller.text.length - 1);
          });
        },
      );
    else
      return MaterialButton();
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}