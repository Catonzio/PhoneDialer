import 'package:call_log/call_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_dialer/custom_widgets/CstmStuff.dart';
import 'package:phone_dialer/custom_widgets/LogsListTile.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: logsEntries,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  List<CallLogEntry> entries = (snapshot.data as Iterable<CallLogEntry>).toList();
                  var map = getEntriesForTime(entries);
                  map.forEach((key, value) {
                    StringBuffer buffer = StringBuffer();
                    value.forEach((element) {
                      buffer.write(" ${element.name}");
                    });
                    debugPrint("Key: $key, Value: ${buffer.toString()}");
                  });
                  return Expanded(
                    child: ListView.separated(
                      itemCount: entries.length,
                      itemBuilder: (context, index) {
                        return LogsListTile(
                          name: entries[index].name != null ? entries[index].name : "null",
                          number: entries[index].number,
                          callType: entries[index].callType,
                          //date: new DateTime.fromMillisecondsSinceEpoch(entries[index].timestamp)
                          date: DateTime.now(),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 5,
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
    return "${date.day}/${date.month}/${date.year}";
  }

}