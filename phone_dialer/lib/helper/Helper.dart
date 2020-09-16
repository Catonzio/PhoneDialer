import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import 'StateHolder.dart';

class Helper {

  static List<String> getPhones(Contact contact) {
    List<String> phones = List();
    contact.phones.toList().forEach((element) {
      phones.add("${element.value}");
    });
    return phones;
  }

  static printPhones(Contact contact, int index) {
    List<String> phones = getPhones(contact);
    debugPrint("Index $index");
    phones?.forEach((element) {
      debugPrint(element);
    });
  }

  static String getLabel(int index, Iterable<Contact> contacts) {
    if(contacts != null) {
      if(index >= contacts?.length)
        index = contacts?.length - 1;
      String name = contacts?.toList()[index].displayName;
      if(name != null && name.isNotEmpty)
        return name[0];
      else
        return "";
    } else
      return "";
  }

  static getSearchedList(String text, Iterable<Contact> contacts) {
    if(text.isNotEmpty) {
        return contacts.where(
                (element) =>
                element.displayName.toLowerCase()
                    .contains(text.toLowerCase().trim())
        );
    } else
      return contacts;
  }
}