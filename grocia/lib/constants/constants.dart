import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';

const orderScreenTitleWidth = 120.0;
const orderScreenToolBarHeight = 30.0;
const appFontSize = 16.0;
const screenHeaderStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
BoxDecoration buttonStyle = BoxDecoration(
    borderRadius:  BorderRadius.all(Radius.circular(10)),
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kGreenColor, kGreenColor.withOpacity(0.7)]));
