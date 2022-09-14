import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget noShopsFound(String text){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.w),
    child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey)
        ),
        child: Center(child: Text(text),)),
  );
}