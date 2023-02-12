import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimension.dart';

class BigText extends StatelessWidget {

    Color? color;
  final String text;
  double size;
  TextOverflow textOverFlow;
   BigText({Key? key, this.color = const Color(0xFF332d2b), required this.text, this.size =0, this.textOverFlow = TextOverflow.ellipsis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: textOverFlow,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size==0?Dimensions.font20: size,
        fontWeight: FontWeight.w400
      ),
    );
  }
}