import 'package:flutter/material.dart';
import 'package:natillera_app/config/colors/customColors.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import '../../../config/utils/back_button.dart';


PreferredSizeWidget header(BuildContext context, String text, String subtitle) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(75.0),
    child: NewGradientAppBar(
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomPaint(
            painter: CircleOne(),
          ),
          CustomPaint(
            painter: CircleTwo(),
          ),
        ],
      ),
      title: Container(
        margin:const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  <Widget>[
            Text(
              text,
              style:const  TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              subtitle,
              style:const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
     leading: 
      backButton(context, Colors.white)
     
      
    ),
  );
}

class CircleOne extends CustomPainter {
  Paint? _paint;

  CircleOne() {
    _paint = Paint()
      ..color = CustomColors.headerCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(const Offset(50.0, 2.0), 99.0, _paint!);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CircleTwo extends CustomPainter {
  Paint? _paint;

  CircleTwo() {
    _paint = Paint()
      ..color = CustomColors.headerCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(const Offset(-30, 30), 50.0, _paint!);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}