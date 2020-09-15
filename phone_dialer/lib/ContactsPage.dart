import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:phone_dialer/PhoneDialer.dart';
import 'package:phone_dialer/StateHolder.dart';
import 'package:phone_dialer/main.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'CustomSliderThumbRectangle.dart';
//import 'package:contacts_app/smsButton.dart';
//import 'package:contacts_app/phoneButton.dart';

class ContactsPage extends StatefulWidget {

  //ContactsPage({Key key, this.contacts});
  //final Iterable<Contact> contacts;

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  ItemScrollController _controller;
  TextEditingController searchController;
  Iterable<Contact> contacts;
  int index;

  @override
  void initState() {
    _controller = ItemScrollController();
    searchController = TextEditingController();
    contacts = StateHolder.instance.contacts;
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text('Contacts')),
      ),
      body: StateHolder.instance.contacts != null
      //Build a list view of all contacts, displaying their avatar and
      // display name
          ? Column(
        children: [
          Padding(
            child: TextField(
              controller: searchController,
              onChanged: (text) => getSearchedList(),
              decoration: InputDecoration(
                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                hintText: "Search",
                prefixIcon: Icon(Icons.search)
              )
            ),
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: getListOfContacts()
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      child: RotatedBox(
                          quarterTurns: 1,
                          child: SliderTheme(
                            data: SliderThemeData(
                                activeTrackColor: Colors.amber,
                                inactiveTrackColor: Colors.grey,
                                thumbShape: CustomSliderThumbRectangle(
                                  color: Colors.amber,
                                  max: StateHolder.instance.contacts.length,
                                  text: getLabel(),
                                ),
                                //SliderComponentShape.noThumb,
                                trackHeight: 7
                            ),
                            child: Slider(
                              value: index.toDouble(),
                              min: 0,
                              max: StateHolder.instance.contacts.length.toDouble(),
                              onChanged: (value) => move(value),
                              divisions: StateHolder.instance.contacts.length,
                              //label: getLabel(),
                            ),
                          )
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      )
          : Center(child: const CircularProgressIndicator()),
    );
  }

  Widget getListOfContacts() {
    Widget widget = ScrollablePositionedList.builder(
      itemScrollController: _controller,
      itemCount: contacts?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        Contact contact = contacts?.elementAt(index);
        if(contact.displayName != null) {
          return Container(
            height:  MediaQuery.of(context).size.height * 0.07,
            child: ListTile(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
              leading: (contact.avatar != null && contact.avatar.isNotEmpty)
                  ? CircleAvatar(
                backgroundImage: MemoryImage(contact.avatar),
              )
                  : CircleAvatar(
                child: Text(contact.initials(), style: TextStyle(color: Colors.black),),
                backgroundColor: getColor(index, StateHolder.instance.contacts.length),
              ),
              title: Text("${contact.displayName}" ?? ''),
              //This can be further expanded to showing contacts detail
              // onPressed().
              onLongPress: () => printPhones(contact, index),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //PhoneButton(phoneNumbers: contact.phones),
                  //SmsButton(phoneNumbers: contact.phones)
                ],
              ),
            ),
          );
        } else {
          return Container(color: Colors.red,);
        }
      },
    );
    return widget;
  }

  String getLabel() {
    if(index >= StateHolder.instance.contacts.length)
      index = StateHolder.instance.contacts.length - 1;
    String name = StateHolder.instance.contacts.toList()[index].displayName;
    if(name != null && name.isNotEmpty)
      return name[0];
    else
      return "";
  }

  move(double value) {
    setState(() {
      index = value.toInt();
      _controller.jumpTo(index: value.toInt());
    });
  }

  List<String> getPhones(Contact contact) {
    List<String> phones = List();
    contact.phones.toList().forEach((element) {
      phones.add("${element.value}");
    });
    return phones;
  }

  printPhones(Contact contact, int index) {
    List<String> phones = getPhones(contact);
    debugPrint("Index $index");
    phones?.forEach((element) {
      debugPrint(element);
    });
    StateHolder.instance.phoneNumber = phones[0];
    PageMain.mainPageKey.currentState.controller.animateTo(1);
  }

  Color colors(int group) {
    switch (group) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.orange;
        break;
      case 3:
        return Colors.yellow;
        break;
      case 4:
        return Colors.green;
        break;
      case 5:
        return Colors.blue;
        break;
      case 6:
        return Colors.indigo;
        break;
      case 7:
        return Colors.purple;
        break;
    }
  }

  int getGroup(int index, int size) {
    //this type of division truncates the number: 47.xx will be 47 -> so I need +1
    int slice = size~/7 + 1;
    if(index > 0 && index < slice)
      return 1;
    else if(index >= slice && index < slice*2)
      return 2;
    else if(index >= slice*2 && index < slice*3)
      return 3;
    else if(index >= slice*3 && index < slice*4)
      return 4;
    else if(index >= slice*4 && index < slice*5)
      return 5;
    else if(index >= slice*5 && index < slice*6)
      return 6;
    else if(index >= slice*6 && index < slice*7)
      return 7;
    else
      return 0;
  }

  Color getColor(int index, int size) {
    int group = getGroup(index, size);
    MaterialColor col = colors(group);
    int val = normalize(index, group, size);
    //debugPrint("Index: $index, size: $size, group: $group, val: $val");
    return col;
  }

  int normalize(int index, int group, int size) {
    //number [1 ; (size~/7 + 1)]
    int val = (index - (size~/7 + 1)*(group-1)) + 1;

    return val;
  }

  getSearchedList() {
    if(searchController.text.isNotEmpty) {
      setState(() {
        this.contacts = StateHolder.instance.contacts.where(
                (element) =>
                    element.displayName.toLowerCase()
                        .contains(searchController.text.toLowerCase().trim())
        );
      });
    } else {
      setState(() {
        this.contacts = StateHolder.instance.contacts;
      });
    }
  }
}