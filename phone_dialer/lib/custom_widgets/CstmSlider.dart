import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_dialer/helper/Helper.dart';
//import 'file:///C:/Users/danil/Projects/flutter/PhoneDialer/phone_dialer/lib/helper/StateHolder.dart';
import 'package:phone_dialer/helper/StateHolder.dart';

import 'CustomSliderThumbRectangle.dart';

class CstmSlider extends StatelessWidget {

  final int index;
  final Function onChanged;

  CstmSlider({Key key,
    this.index,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    if(StateHolder.instance.contacts != null) {
      return RotatedBox(
          quarterTurns: 1,
          child: SliderTheme(
            data: SliderThemeData(
                activeTrackColor: Colors.amber,
                inactiveTrackColor: Colors.grey,
                thumbShape: CustomSliderThumbRectangle(
                  color: Colors.amber,
                  max: StateHolder.instance.contacts?.length,
                  text: Helper.getLabel(index, StateHolder.instance.contacts),
                ),
                //SliderComponentShape.noThumb,
                trackHeight: 7
            ),
            child: Slider(
              value: index.toDouble(),
              min: 0,
              max: StateHolder.instance.contacts.length.toDouble(),
              divisions: StateHolder.instance.contacts.length,
              onChanged: onChanged,
              //label: getLabel(),
            ),
          )
      );
    } else
      return Container();
  }

}