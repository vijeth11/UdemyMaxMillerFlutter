import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/model/item_model.dart';

class ProductItemCard extends StatelessWidget {
  final ItemModel productItem;
  const ProductItemCard({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                productItem.itemImage,
              ),
              const SizedBox(
                height: 17,
              ),
              Text(
                productItem.itemName,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              getAmountDisplayRow(productItem.itemCost.toString())
            ],
          )),
    );
  }

  static Widget getAmountDisplayRow(String itemCost,
      {bool costColorblack = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Rs $itemCost/kg',
          style: TextStyle(
              color: !costColorblack ? kGreenColor : kBlackColor, fontSize: 18),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: kGreyLightColor, borderRadius: BorderRadius.circular(50)),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: kWhiteColor, borderRadius: BorderRadius.circular(50)),
            child: const Icon(
              Icons.add,
              color: kRedColor,
              size: 20,
            ),
          ),
        )
      ],
    );
  }
}
