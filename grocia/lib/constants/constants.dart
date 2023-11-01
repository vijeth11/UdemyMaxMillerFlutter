import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';

const orderScreenTitleWidth = 120.0;

enum ReviewType { Bad, Better, Good }

const orderScreenToolBarHeight = 30.0;
const appFontSize = 16.0;
const screenHeaderStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
BoxDecoration buttonStyle = BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [kGreenColor, kGreenColor.withOpacity(0.7)]));
const iconImagePath = "assets/images/grocia-logo.png";
const iconImageSize = 50.0;
const categoryImages = {
  "Fruits": "assets/images/fruits.svg",
  "Vegetables": "assets/images/vegetables.svg",
  "Diary": "assets/images/diary.svg",
  "Frozen": "assets/images/frozen.svg",
  "Bread": "assets/images/bread.svg",
  "Meat": "assets/images/meat.svg",
  "Sea Food": "assets/images/seafood.svg",
  "Organic": "assets/images/organic.svg"
};
const snackBarEdgeInsets = EdgeInsets.symmetric(vertical: 10, horizontal: 5);
