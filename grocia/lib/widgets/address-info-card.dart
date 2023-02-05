import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/model/address_model.dart';

class AddressInfoCard extends StatelessWidget {
  const AddressInfoCard({
    Key? key,
    required this.address,
    required this.createRoute,
  }) : super(key: key);

  final AddressModel address;
  final ZoneCallback<Route> createRoute;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
              width: 2.5,
              color: address.isDefault
                  ? kGreenColor
                  : const Color.fromARGB(0, 0, 0, 0))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            AddressInfoCard.getAddressInfoTitle(
                address.addressType.name, address.isDefault),
            const SizedBox(
              height: 15,
            ),
            // address
            AddressInfoCard.getAddressInfoAddress(address.toString()),
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
                        Navigator.of(context).push(this.createRoute());
                      },
                      icon: const Icon(Icons.edit, size: 17),
                      label: const Text(
                        "Edit",
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          foregroundColor:
                              MaterialStateProperty.all(kGreenColor)),
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
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(kRedColor)),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  static Widget getAddressInfoTitle(String addressName, bool isDefault) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          addressName,
          style: const TextStyle(
              color: kBlackColor, fontSize: 19, fontWeight: FontWeight.w700),
        ),
        if (isDefault)
          Container(
            padding: const EdgeInsets.all(7.5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kGreenColor.withOpacity(0.2)),
            child: const Text(
              "Default",
              style: TextStyle(color: kGreenColor, fontWeight: FontWeight.w500),
            ),
          )
      ],
    );
  }

  static Widget getAddressInfoAddress(String address) {
    return SizedBox(
        width: 230,
        child: Text(
          address,
          softWrap: true,
          style: const TextStyle(color: kGreyColor, fontSize: 17),
        ));
  }
}
