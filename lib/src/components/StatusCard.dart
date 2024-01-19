import 'dart:math';

import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:flutter/material.dart';


import '../constants/color_constants.dart';


class OthersStatus extends StatelessWidget {
  const OthersStatus(
      {Key? key, this.name, this.seenvalue ,this.statusNum, this.imageName})
      : super(key: key);
  final String? name;
  final int? seenvalue;
  final int? statusNum;
  final String? imageName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        SizedBox(height: 10,),
      Stack(
        children: [
          CustomPaint(
            painter: StatusBorderPainter(statusNum: statusNum, seenValue: seenvalue),
            child: SizedBox(
              width: 120,  // Adjust width as needed for the CircleAvatar
              height: 120,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                backgroundImage: NetworkImage(
                  imageName!, // Replace with the actual image URL
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 20,),
        TextComponent(
          name ?? "",
          textAlign: TextAlign.center,
          maxLines: 2,
          // style: FontStyles.font15(),
        )

    ]);
  }
}

degreeToRad(double degree) {
  return degree * pi / 180;
}

class StatusBorderPainter extends CustomPainter {
  int? seenValue;
  int? statusNum;
  Set<int> viewedStatusNums = Set<int>();

  StatusBorderPainter({ this.statusNum, this.seenValue});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = new Paint()
      ..isAntiAlias = true
      ..strokeWidth = 6.0;

    if ( statusNum != null) {
      if (viewedStatusNums.contains(statusNum)) {
        // Change the color for the viewed status
        paint.color = ColorConstants.green; // Change this to the desired color
      } else {
        paint.color = Colors.grey;
      }
    } else {
      paint.color = ColorConstants.greenLight;
    }

    paint.style = PaintingStyle.stroke;
    drawArc(canvas, paint, size, statusNum, seenValue);

    if ((seenValue ?? 0) > 0  && statusNum != null) {
      viewedStatusNums.add(statusNum!);
      print("Viewed Status Numbers: $viewedStatusNums");
    }
  }


  void drawArc(Canvas canvas, Paint paint, Size size, int? count, int? seenValue) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double circleRadius = size.width < size.height ? size.width / 2 : size.height / 2;
    circleRadius *= 1.05;

    if (count == 1) {
      paint.color = seenValue! > 0 ? Colors.grey : ColorConstants.green;

      double circleRadius = size.width < size.height ? size.width / 2 : size.height / 2;
      circleRadius *= 1.05; // Adjust the multiplier as needed

      canvas.drawCircle(Offset(centerX, centerY), circleRadius, paint);
    } else {
      double degree = -90;
      double arc = 360 / count!;
      for (int i = 0; i < count; i++) {
        if (i < seenValue!) {
          // Change the color for the seen parts
          paint.color = Colors.grey; // Change this to the desired color
        } else {
          // Reset the color for the remaining parts
          paint.color = ColorConstants.greenLight; // Change this to the original color
        }

        // Calculate the bounds for the arc based on the red circle's center and radius
        Rect arcBounds = Rect.fromCircle(center: Offset(centerX, centerY), radius: circleRadius);

        canvas.drawArc(arcBounds, degreeToRad(degree + 4), degreeToRad(arc - 2), false, paint);
        degree += arc;
      }
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}