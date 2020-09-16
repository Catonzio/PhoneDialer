import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:phone_dialer/custom_widgets/CstmAlertDialog.dart';
import 'package:phone_dialer/custom_widgets/CstmSlider.dart';
import 'package:phone_dialer/custom_widgets/CstmStuff.dart';
import 'package:phone_dialer/helper/CstmColors.dart';
import 'package:phone_dialer/helper/Helper.dart';
import 'package:phone_dialer/helper/StateHolder.dart';
//import 'file:///C:/Users/danil/Projects/flutter/PhoneDialer/phone_dialer/lib/helper/StateHolder.dart';
import 'package:phone_dialer/main.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key key, this.contacts});
  final Iterable<Contact> contacts;
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  ItemScrollController _controller;
  TextEditingController searchController;
  Iterable<Contact> contacts;
  CstmColors colors;
  int selectedRadio;
  int index;

  @override
  void initState() {
    _controller = ItemScrollController();
    searchController = TextEditingController();
    colors = CstmColors();
    contacts = StateHolder.instance.contacts;
    selectedRadio = 0;
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "Contacts",
      body: contacts != null
      //Build a list view of all contacts, displaying their avatar and
      // display name
          ? Column(
        children: [
          Padding(
            child: TextField(
                controller: searchController,
                onChanged: (text) => search(),
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
                        child: CstmSlider(index: index, onChanged: (value) => move(value))
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
                backgroundColor: colors.getColor(index, StateHolder.instance.contacts.length),
              ),
              title: Text("${contact.displayName}" ?? ''),
              //This can be further expanded to showing contacts detail
              // onPressed().
              onLongPress: () => selectNumber(contact, context),
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

  move(double value)  {
    setState(() {
      index = value.toInt();
      _controller.jumpTo(index: value.toInt());
    });
  }

  selectNumber(Contact contact, BuildContext context) {
    List<String> numbers = Helper.getPhones(contact);
    numbers.length >= 2 ?
      showMyDialog(context, numbers)
    :
        StateHolder.instance.phoneNumber = numbers[0];
    PageMain.mainPageKey.currentState.controller.animateTo(1);
  }

  search() {
    setState(() {
      this.contacts = Helper.getSearchedList(searchController.text.trim(), StateHolder.instance.contacts);
    });
  }

  void showMyDialog(BuildContext context, List<String> numbers) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CstmAlertDialog(
          continueText: "Ok",
          dialogTitle: "Select a number",
          body: Column(
            children: getListOfRadios(numbers),
          ),
          pressed: () => {
            StateHolder.instance.phoneNumber = numbers[selectedRadio]
          },
        );
      }
    );
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  getListOfRadios(List<String> numbers) {
    List<Widget> widgets = List();
    int indx = 0;
    numbers.forEach((element) {
      widgets.add(
        Radio(
          value: indx,
          groupValue: selectedRadio,
          activeColor: Colors.green,
          onChanged: (val) {
            debugPrint("Radio $val");
            setSelectedRadio(val);
          },
        )
      );
      indx++;
    });
    return widgets;
  }


}