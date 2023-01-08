import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/pages/address_edit_page.dart';
import 'package:grocia/provider/auth.provider.dart';
import 'package:grocia/widgets/back-button-appBar.dart';
import 'package:grocia/widgets/address-info-card.dart';
import 'package:grocia/widgets/create_animated_router.dart';
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
                  Navigator.of(context).push(CreateRoute(AddressEditPage()));
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
              createRoute: () => CreateRoute(AddressEditPage()),
            ),
            onTap: () {
              // TODO: code change the "default" address
            },
          );
        },
      ),
    );
  }
  
}
