import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
//import 'file:///C:/Users/danil/Projects/flutter/PhoneDialer/phone_dialer/lib/helper/StateHolder.dart';
import 'package:phone_dialer/helper/StateHolder.dart';
import 'package:phone_dialer/custom_widgets/CstmStuff.dart';

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
    FocusScope.of(context).unfocus();
    return DefaultPage(
      title: "Phone",
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
              padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.38,
              child: GridView.count(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  childAspectRatio: 1.5,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: generateButtons(12)
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.13,
              child: GridView.count(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                crossAxisCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  getDeleteButton(
                    icon: Icons.delete,
                    onPressed: () {
                      setState(() {
                        controller.text = "";
                        StateHolder.instance.setText(controller.text);
                      });
                    },
                  ),
                  CstmIconButton(
                    icon: Icon(Icons.phone, color: Colors.green, size: 50,),
                    onPressed: controller.text.trim().length >= 5 ? doCall : null,
                  ),
                  getDeleteButton(
                    icon: Icons.backspace,
                    onPressed: () {
                     setState(() {
                        controller.text = controller.text.substring(0, controller.text.length - 1);
                        StateHolder.instance.setText(controller.text);
                     });
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getDeleteButton({Key key, IconData icon, Function onPressed}) {
    Widget widget;
    controller.text.isNotEmpty ?
      widget = CstmIconButton(
        icon: Icon(icon, color: Colors.red[900],),
        onPressed: onPressed
      ) :
        widget = MaterialButton(onPressed: null,);
    return widget;
  }

  addNumber(int index) {
    setState(() {
      controller.text += '${index+1}';
    });
  }

  Future<void> doCall() async {
    String number = '4146${controller.text}';
    bool res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  addString(String s) {
    setState(() {
      controller.text += s;
    });
  }

  generateButtons(int quantity) {
    List<Widget> buttons = List();
    for(int i = 0; i<quantity-3; i++) {
      buttons.add(
          Center(
            child: MaterialButton(
                child: Text(
                  '${i+1}',
                  style: TextStyle(
                      fontSize: 30
                  ),
                ),
                onPressed: () => addNumber(i)
            ),
          )
      );
    }
    buttons.add(
        Center(
          child: MaterialButton(
              child: Text(
                '*',
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              onPressed: () => addString('*')
          ),
        )
    );
    buttons.add(
        Center(
          child: MaterialButton(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                        fontSize: 30
                    ),
                  ),
                  Text('+')
                ],
              ),
              onPressed: () => addNumber(-1),
              onLongPress: () => addString('+'),
          ),
        )
    );
    buttons.add(
        Center(
          child: MaterialButton(
              child: Text(
                '#',
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              onPressed: () => addString('#')
          ),
        )
    );
    return buttons;
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}