import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/color.dart';
import 'package:food_delivery_app/utils/dimension.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class ExpandadTextWidget extends StatefulWidget {
  final String text;
  ExpandadTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandadTextWidget> createState() => _ExpandadTextWidgetState();
}

class _ExpandadTextWidgetState extends State<ExpandadTextWidget> {

  late String firstHelf;
  late String secondHelf;
  bool hiddentext =true;

  double textHeight = Dimensions.screenHeight/5.31;
  @override
  void initState() {
    
    super.initState();
    if(widget.text.length > textHeight){
      firstHelf = widget.text.substring(0,textHeight.toInt());
      secondHelf = widget.text.substring(textHeight.toInt()+1, widget.text.length);
    }else{
      firstHelf = widget.text;
      secondHelf = "";

    }
  } 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHelf == ""? SmallText(size: Dimensions.font16,height: 1.8,color: AppColor.paraColor,text: firstHelf):Column(
        children: [
          SmallText(size: Dimensions.font16,height: 1.8,color: AppColor.paraColor,text: hiddentext? firstHelf+"...":(firstHelf+secondHelf)),
          InkWell(
            onTap: (){
              setState(() {
                hiddentext = !hiddentext;
              });
            },
            child: Row(
              children: [
                hiddentext?SmallText(text: 'Show more',color: AppColor.mainColor):SmallText(text: 'Show less',color: AppColor.mainColor),
                Icon(hiddentext?Icons.arrow_drop_down:Icons.arrow_drop_up,color: AppColor.mainColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}