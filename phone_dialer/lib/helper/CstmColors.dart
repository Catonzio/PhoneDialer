import 'dart:ui';

import 'package:flutter/material.dart';

class CstmColors {

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
}