import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
//import 'package:contacts_app/smsButton.dart';
//import 'package:contacts_app/phoneButton.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  Iterable<Contact> _contacts;

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    //We already have permissions for contact when we get to this page, so we
    // are now just retrieving it
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text('Contacts')),
      ),
      body: _contacts != null
      //Build a list view of all contacts, displaying their avatar and
      // display name
          ? ListView.builder(
        itemCount: _contacts?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          Contact contact = _contacts?.elementAt(index);
          if(contact.displayName != null) {
            return ListTile(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
              leading: (contact.avatar != null && contact.avatar.isNotEmpty)
                  ? CircleAvatar(
                backgroundImage: MemoryImage(contact.avatar),
              )
                  : CircleAvatar(
                child: Text(contact.initials()),
                backgroundColor: Theme.of(context).accentColor,
              ),
              title: Text("${contact.displayName}" ?? ''),
              //This can be further expanded to showing contacts detail
              // onPressed().
              onLongPress: () => printPhones(contact),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //PhoneButton(phoneNumbers: contact.phones),
                  //SmsButton(phoneNumbers: contact.phones)
                ],
              ),
            );
          } else {
            return Container(color: Colors.red,);
          }
        },
      )
          : Center(child: const CircularProgressIndicator()),
    );
  }

  List<String> getPhones(Contact contact) {
    List<String> phones = List();
    contact.phones.toList().forEach((element) {
      phones.add("${element.value}");
    });
    return phones;
  }

  printPhones(Contact contact) {
    List<String> phones = getPhones(contact);
    phones?.forEach((element) {
      debugPrint(element);
    });
  }
}