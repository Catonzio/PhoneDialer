import 'dart:math';

import 'package:call_log/call_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_dialer/custom_widgets/CstmStuff.dart';
import 'package:phone_dialer/custom_widgets/LogsListTile.dart';
import 'package:phone_dialer/helper/StateHolder.dart';

import '../main.dart';

class Register extends StatefulWidget {

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {

  Future<Iterable<CallLogEntry>> logsEntries;

  @override
  void initState() {
    logsEntries = getLogsEntries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: "Register",
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
              future: logsEntries,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  List<CallLogEntry> entries = (snapshot.data as Iterable<CallLogEntry>).toList();
                  Map<String, List<CallLogEntry>> map = getEntriesForTime(entries);
                  return Expanded(
                    child: ListView.builder(
                      itemCount: map.keys.length,
                      itemBuilder: (context, index) {
                        String date = map.keys.toList()[index];
                        List<CallLogEntry> logs = map[date];
                        return Padding(
                          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 0, 5),
                                child: Text("$date", style: TextStyle(fontSize: 20),)
                              ),
                              //SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                              getLogsButtons(logs)
                            ],
                          ),
                        );
                      },
                    )
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Map<String, List<CallLogEntry>> getEntriesForTime(List<CallLogEntry> entries) {
    Map<String, List<CallLogEntry>> map = Map();
    entries.forEach((element) {
      try {
        var date = DateTime.fromMillisecondsSinceEpoch(element.timestamp);
        var day = getDayFromDate(date);
        List<CallLogEntry> mapList = List();
        if(map.containsKey(day)) {
          mapList = map[day];
          mapList.add(element);
        } else {
          mapList.add(element);
          map[day] = mapList;
        }
      } catch (exception) {
        debugPrint("coglione");
      }
    });
    return map;
  }

  Future<Iterable<CallLogEntry>> getLogsEntries() async {
    return await CallLog.get();
  }

  getDayFromDate(DateTime date) {
    return "${date.day} ${mapMonth(date.month)} ${date.year}";
    //return "${date.day}/${date.month}/${date.year}";
  }

  String mapMonth(int month) {
    return month == 1 ? "gennaio"
        : month == 2 ? "febbraio"
        : month == 3 ? "marzo"
        : month == 4 ? "aprile"
        : month == 5 ? "maggio"
        : month == 6 ? "giugno"
        : month == 7 ? "luglio"
        : month == 8 ? "agosto"
        : month == 9 ? "settembre"
        : month == 10 ? "ottobre"
        : month == 11 ? "novembre"
        : month == 12 ? "dicembre"
        : "";
  }

  getLogsButtons(List<CallLogEntry> logs) {
    List<Widget> children = List();
    logs.forEach((element) {
      if(element != null && element.name != null) {
        children.add(
            MaterialButton(
              child: LogsListTile(
                name: element.name != "null" ? element.name : "Not saved",
                number: element.number,
                date: new DateTime.fromMillisecondsSinceEpoch(element.timestamp),
                callType: element.callType,
                isLast: logs[logs.length-1] == element,
                isFirst: logs[0] == element,
              ),
              onPressed: onLongPressed(element),
            )
        );
      }
    });
    Widget column = Container(
      child: Column(
        children: children,
      ),
    );
    return column;
  }

  onLongPressed(CallLogEntry element) {
    if(element.number != null && element.number.isNotEmpty) {
      //StateHolder.instance.phoneNumber = element.number;
      //PageMain.mainPageKey.currentState.controller.animateTo(1);
    }
  }

}