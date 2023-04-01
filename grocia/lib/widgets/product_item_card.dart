import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/model/item_model.dart';
import 'package:grocia/screen/product_detail_screen.dart';
import 'package:routemaster/routemaster.dart';

class ProductItemCard extends StatelessWidget {
  final ItemModel productItem;
  const ProductItemCard({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => Routemaster.of(context)
          .push("${ProductDetailScreen.routeName}/${productItem.id}"),
      child: Card(
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
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
                getAmountDisplayRow(productItem.itemCost.toString())
              ],
            )),
      ),
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
        getQuantityController()
      ],
    );
  }

  static Widget getQuantityController({int initialQuant = 0}) {
    Widget iconButton(IconData icon) {
      return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: kWhiteColor, borderRadius: BorderRadius.circular(50)),
        child: Icon(
          icon,
          color: kRedColor,
          size: 20,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: kGreyLightColor, borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: [
          iconButton(Icons.add),
          if (initialQuant > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                initialQuant.toString(),
                style: TextStyle(fontSize: 18),
              ),
            ),
          if (initialQuant > 0) iconButton(Icons.remove)
        ],
      ),
    );
  }
}
