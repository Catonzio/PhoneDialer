import 'package:call_log/call_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogsListTile extends StatelessWidget {

  final String name;
  final String number;
  final CallType callType;
  final DateTime date;

  LogsListTile({Key key,
    this.name,
    this.number,
    this.callType,
    this.date
  });

  @override
  Widget build(BuildContext context) {
    String dateF = formatDate(date);
    return Container(
      //padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      //color: Colors.grey,
      decoration: BoxDecoration(
        color: Colors.grey[800],
          border: Border.all(
            color: Colors.grey[900],
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            child: Row(
              children: [
                callType == CallType.incoming ?
                Icon(Icons.call_made, color: Colors.green, size: 40,)
                    :
                Icon(Icons.call_received, color: Colors.red, size: 40,),
                Text(name != "null" ? name : "Not saved", style: TextStyle(fontSize: 25),),
              ],
            ),
            padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
          ),
          Padding(
            child: Row(
              children: [
                Text(number, style: TextStyle(fontSize: 15),),
                Spacer(),
                Text(dateF, style: TextStyle(fontSize: 15)),
              ],
            ),
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    String year = date.year.toString();
    String month = date.month.toString();
    String day = date.day.toString();
    String hour = date.hour.toString();
    String minutes = date.minute.toString();
    String seconds = date.second.toString();
    return "$day/$month/$year $hour:$minutes:$seconds";
  }

}