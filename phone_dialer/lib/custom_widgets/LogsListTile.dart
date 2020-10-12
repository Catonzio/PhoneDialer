import 'package:call_log/call_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogsListTile extends StatelessWidget {

  final String name;
  final String number;
  final CallType callType;
  final DateTime date;
  final BorderRadius radius;
  final bool isLast;
  final bool isFirst;

  LogsListTile({Key key,
    this.name,
    this.number,
    this.callType,
    this.date,
    this.radius,
    this.isLast,
    this.isFirst
  });

  @override
  Widget build(BuildContext context) {
    String dateF = formatDate(date);
    return Container(
      //padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      //color: Colors.grey,
      decoration: BoxDecoration(
        color: Colors.grey[900],
          border: Border.all(
            color: Colors.black
          ),
          borderRadius:
              isFirst && isLast ? BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20), topRight: Radius.circular(20), topLeft: Radius.circular(20))
              : isFirst ? BorderRadius.only(bottomLeft: Radius.zero, bottomRight: Radius.zero, topLeft: Radius.circular(20), topRight: Radius.circular(20))
              : isLast ? BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20), topLeft: Radius.zero, topRight: Radius.zero)
              : null
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            child: Row(
              children: [
                callType == CallType.incoming ?
                Padding(child:  Icon(Icons.call, color: Colors.green, size: 30,), padding: EdgeInsets.fromLTRB(10, 0, 10, 0),)
                    :
                Padding(child: Icon(Icons.call_end, color: Colors.red, size: 30), padding: EdgeInsets.fromLTRB(10, 0, 10, 0),),
                Text(name != "null" ? name : "Not saved", style: TextStyle(fontSize: 20),),
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
            padding: EdgeInsets.fromLTRB(25, 0, 10, 10),
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
    //return "$day/$month/$year $hour:$minutes:$seconds";
    if(hour.length == 1)
      hour = "0" + hour;
    if(minutes.length == 1)
      minutes = "0" + minutes;
    return "$hour:$minutes";
  }

}