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
    TextStyle style = TextStyle(fontSize: 15, color: Colors.grey[400]);
    String dateF = formatDate(date);
    return Container(
      //padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      //color: Colors.grey,
      height: MediaQuery.of(context).size.height*0.08,
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
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              callType == CallType.outgoing ?
              Padding(child:  Image.asset("assets/outgoing-call (1).png", color: Colors.green, height: 25,), padding: EdgeInsets.fromLTRB(10, 0, 10, 0),)
              : callType == CallType.incoming ?
              Padding(child: Image.asset("assets/incoming-call (2).png", color: Colors.red, height: 25), padding: EdgeInsets.fromLTRB(10, 0, 10, 0),)
              : callType == CallType.missed ?
              //Padding(child: Icon(Icons.call, color: Colors.red, size: 30), padding: EdgeInsets.fromLTRB(10, 0, 10, 0),)
              Padding(child: Image.asset("assets/missed-call (1).png", color: Colors.red, height: 25), padding: EdgeInsets.fromLTRB(10, 0, 10, 0),)
              : callType == CallType.rejected ?
              Padding(child: Image.asset("assets/rejected-call.png", color: Colors.red, height: 25),  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),)
                  : Padding(child: Image.asset("assets/missed-call (1).png", color: Colors.red, height: 25),  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(child: Text(name != "null" ? name : "Not saved", style: TextStyle(fontSize: 20, color: Colors.grey[300]),), padding: EdgeInsets.fromLTRB(0, 0, 0, 5),)
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.height*0.36,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(number, style: style),
                        //SizedBox(width: MediaQuery.of(context).size.width * 0.30,),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(dateF, style: style),

                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      )
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