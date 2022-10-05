import 'package:flutter/material.dart';
import 'package:kedo_food/providers/auth_provider.dart';
import 'package:kedo_food/screens/message_bot.dart';
import 'package:kedo_food/screens/my_orders.dart';
import 'package:kedo_food/screens/user_profile.dart';
import 'package:kedo_food/widgets/page_header.dart';
import 'package:provider/provider.dart';

class UserProfileOption extends StatelessWidget {
  static const String routeName = 'UserProfileOption';

  final List<Map<String, IconData>> options = [
    {'MY PROFILE': Icons.account_circle_sharp},
    {'MY ORDERS': Icons.shopping_bag},
    {'MESSAGE': Icons.announcement},
    {'LOGOUT': Icons.assignment_return_rounded}
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var authProvider = Provider.of<Auth>(context, listen: false);
    return Scaffold(
        body: Column(children: [
      ...getPageHeader('User', context, titlePladding: 85),
      const SizedBox(
        height: 40,
      ),
      ...options.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFF43B23B)),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () =>
                      navigateToPage(context, e.keys.first, authProvider),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Icon(
                            e.values.first,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            e.keys.first,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    ]));
  }

  void navigateToPage(BuildContext context, String name, Auth provider) {
    switch (name) {
      case 'MY PROFILE':
        Navigator.of(context).pushNamed(UserProfile.routeName);
        break;
      case 'MY ORDERS':
        Navigator.of(context).pushNamed(MyOrders.routeName);
        break;
      case 'MESSAGE':
        Navigator.of(context).pushNamed(MessageBot.routeName);
        break;
      case 'LOGOUT':
        // TODO: logout and display a sign in page
        provider.logout();
        Navigator.of(context).pop();
        break;
    }
  }
}
