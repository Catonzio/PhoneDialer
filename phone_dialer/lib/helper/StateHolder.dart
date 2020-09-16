import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';

class StateHolder {

  StateHolder.privateConstructor();

  static final StateHolder _instance = StateHolder.privateConstructor();

  static StateHolder get instance => _instance;

  Iterable<Contact> contacts;
  String phoneNumber;

  Future<void> getContacts() async {
    //We already have permissions for contact when we get to this page, so we
    // are now just retrieving it
    Iterable<Contact> contacts = await ContactsService.getContacts();
    this.contacts = contacts.where((element) => element != null && element.displayName != null && element.displayName.isNotEmpty);
  }

  void setText(String text) {
    this.phoneNumber = text;
  }

}