import 'package:flutter/material.dart';
import 'package:kedo_food/infrastructure/backbutton.dart';

List<Widget> getPageHeader(String title, BuildContext context,
    {double titlePladding = 16}) {
  return [
    SizedBox(
      height: MediaQuery.of(context).viewPadding.top,
    ),
    ListTile(
      iconColor: Colors.black,
      leading: AppBackButton(context),
      title: Padding(
        padding: EdgeInsets.only(left: titlePladding, top: 10),
        child: Text(
          title,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  ];
}
