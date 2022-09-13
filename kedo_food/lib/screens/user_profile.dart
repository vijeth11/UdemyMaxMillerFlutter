import 'package:flutter/material.dart';
import 'package:kedo_food/helper/utils.dart';
import 'package:kedo_food/model/user_details.dart';
import 'package:kedo_food/widgets/page_header.dart';

class UserProfile extends StatelessWidget {
  static const String routeName = 'UserProfile';
  final UserDetails userDetails = UserDetails(
      "Richard",
      "Brownlee",
      "RichBrown",
      "(+91) 123 456 7890",
      "info@test.com",
      "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu",
      'assets/images/user3.png',
      getRandomString(10));
  @override
  Widget build(BuildContext context) {
    // TODO: Edit Profile Needs to be implemented
    return Scaffold(
        body: Column(children: [
      ...getPageHeader("Profile", context, titlePladding: 80),
      SizedBox(
        height: 40,
      ),
      Center(
        child: Column(
          children: [
            Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                        image: AssetImage(
                          userDetails.image,
                        ),
                        fit: BoxFit.cover))),
            SizedBox(
              height: 40,
            ),
            Text(
              userDetails.fullName,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 20,
      ),
      ...getUserDetailRow("Full Name", userDetails.fullName),
      ...getUserDetailRow("User Name", userDetails.userName),
      ...getUserDetailRow("Phone", userDetails.phone),
      ...getUserDetailRow("Email Address", userDetails.emailAddress),
      Center(
          child: TextButton(
              onPressed: () {},
              child: Text(
                "Edit Profile",
                style: TextStyle(color: Colors.green, fontSize: 22),
              )))
    ]));
  }

  List<Widget> getUserDetailRow(String title, String data) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Text(
              data,
              style: TextStyle(
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Divider(
          height: 5,
          color: Colors.black,
        ),
      ),
    ];
  }
}
