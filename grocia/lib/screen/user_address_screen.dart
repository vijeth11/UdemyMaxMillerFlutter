import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/provider/auth.provider.dart';
import 'package:grocia/widgets/back-button-appBar.dart';
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
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    backgroundColor: MaterialStatePropertyAll(kGreyLightColor),
                    foregroundColor: MaterialStatePropertyAll(kGreenColor),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        side: BorderSide(color: kGreenColor),
                        borderRadius: BorderRadius.all(Radius.circular(5))))),
                onPressed: () {
                  // TODO: display an edit page
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
            child: Card(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                      width: 2.5,
                      color: address.isDefault
                          ? kGreenColor
                          : const Color.fromARGB(0, 0, 0, 0))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 30, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          address.addressType.name,
                          style: const TextStyle(
                              color: kBlackColor,
                              fontSize: 19,
                              fontWeight: FontWeight.w700),
                        ),
                        if (address.isDefault)
                          Container(
                            padding: const EdgeInsets.all(7.5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kGreenColor.withOpacity(0.2)),
                            child: const Text(
                              "Default",
                              style: TextStyle(
                                  color: kGreenColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // address
                    SizedBox(
                        width: 230,
                        child: Text(
                          address.toString(),
                          softWrap: true,
                          style:
                              const TextStyle(color: kGreyColor, fontSize: 17),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    // edit options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                //TODO: display an edit page
                              },
                              icon: const Icon(Icons.edit, size: 17),
                              label: const Text(
                                "Edit",
                                style: TextStyle(fontSize: 16),
                              ),
                              style: const ButtonStyle(
                                  padding:
                                      MaterialStatePropertyAll(EdgeInsets.zero),
                                  foregroundColor:
                                      MaterialStatePropertyAll(kGreenColor)),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                //TODO: delete the record
                              },
                              icon: const Icon(Icons.delete, size: 17),
                              label: const Text(
                                "Delete",
                                style: TextStyle(fontSize: 16),
                              ),
                              style: const ButtonStyle(
                                  foregroundColor:
                                      MaterialStatePropertyAll(kRedColor)),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              // TODO: code change the default
            },
          );
        },
      ),
    );
  }
}
