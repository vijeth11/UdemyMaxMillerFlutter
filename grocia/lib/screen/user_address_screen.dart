import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/pages/address_edit_page.dart';
import 'package:grocia/provider/auth.provider.dart';
import 'package:grocia/widgets/back-button-appBar.dart';
import 'package:grocia/widgets/address-info-card.dart';
import 'package:provider/provider.dart';

class UserAddressScreen extends StatelessWidget {
  static const String routeName = '/userAddress';
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userAddressList = authProvider.item.addresses;
    return Scaffold(
      backgroundColor: kGreyLightColor,
      appBar: BackActionAppBar(context, "My Address", extraActions: [
        SizedBox(
          width: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 4),
            child: TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor: MaterialStateProperty.all(kGreyLightColor),
                    foregroundColor: MaterialStateProperty.all(kGreenColor),
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            side: BorderSide(color: kGreenColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5))))),
                onPressed: () {
                  Navigator.of(context).push(_createRoute());
                },
                child: const Text("Add")),
          ),
        ),
      ]),
      body: ListView.builder(
        itemCount: userAddressList.length,
        itemBuilder: (context, index) {
          final address = userAddressList[index];
          return GestureDetector(
            child: AddressInfoCard(
              address: address,
              createRoute: _createRoute,
            ),
            onTap: () {
              // TODO: code change the default
            },
          );
        },
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            AddressEditPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, -1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}
