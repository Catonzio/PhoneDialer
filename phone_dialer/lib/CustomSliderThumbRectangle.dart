import 'dart:ui';

import 'package:flutter/material.dart';

class CustomSliderThumbRectangle extends SliderComponentShape {
  final Color color;
  final int min;
  final int max;
  final String text;

  const CustomSliderThumbRectangle({
    @required this.color,
    @required this.max,
    @required this.text,
    this.min = 0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(20);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        Animation<double> activationAnimation,
        Animation<double> enableAnimation,
        bool isDiscrete,
        TextPainter labelPainter,
        RenderBox parentBox,
        SliderThemeData sliderTheme,
        TextDirection textDirection,
        double value,
        double textScaleFactor,
        Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    TextSpan span = new TextSpan(
      text: this.text
    );


    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl
        //textDirection: TextDirection.ltr
    );
    tp.layout();
    Offset textCenter = Offset(center.dy - (tp.height / 2), - center.dx - (tp.width / 2));

    Paint paintRB;
    final RRect borderRectB = BorderRadius.circular(8).resolve(textDirection).toRRect(Rect.fromCenter(center: center, width: 30, height: 30));
    paintRB = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    Paint paintR;
    final RRect borderRect = BorderRadius.circular(8).resolve(textDirection).toRRect(Rect.fromCenter(center: center, width: 30, height: 30));
    paintR = new Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRRect(borderRectB, paintRB);
    canvas.drawRRect(borderRect, paintR);

    //Offset textCenter = Offset(center.dx - (tp.width/2), center.dy - (tp.height/2));
    //canvas.rotate(1.5708);
    //canvas.rotate(0);
    //canvas.drawColor(Colors.red, BlendMode.colorBurn);
    //canvas.rotate(1.5708);

    //canvas.translate(textCenter.dx, textCenter.dy);
    //canvas.rotate(3.14159 * 3.0/2.0);
    tp.paint(canvas, new Offset(center.dx - (tp.width/2), center.dy - (tp.height/2)));
  }
}