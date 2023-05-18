import 'package:flutter/material.dart';
import 'package:ible/theme.dart';

class SubCategoryTabWidget extends StatelessWidget {
  const SubCategoryTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     
        margin: EdgeInsets.only(left: 32, right: 32),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: ThemeColors.greyECECEC,
            borderRadius: BorderRadius.circular(8)),
      child: Stack(children: [
       
       Center( child:Text(
        "Subcategory",
        style:TextStyle(
            fontFamily: 'San Francisco',
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Colors.black,
          ),)),
        //PillTabIndicator()
      ],)
    );
  }
}