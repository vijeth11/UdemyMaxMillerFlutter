import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/model/item_model.dart';
import 'package:grocia/screen/product_detail_screen.dart';
import 'package:grocia/widgets/product_item_card.dart';
import 'package:grocia/widgets/product_item_carousal.dart';
import 'package:routemaster/routemaster.dart';

Widget getCarousalItemCard(ItemModel item, BuildContext context) {
  return Card(
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getItemCarousal(item, context),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ProductItemCard.getAmountDisplayRow(item.itemCost.toString(),
                costColorblack: true),
          )
        ],
      ),
    ),
  );
}

Widget getItemCarousal(ItemModel item, BuildContext context) {
  return GestureDetector(
    onTap: () => Routemaster.of(context)
        .push("${ProductDetailScreen.routeName}/${item.id}"),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductItemCarousal(carousalImages: item.slidingImages),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              item.itemName,
              style: const TextStyle(
                  color: kGreenColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              item.description,
              style: const TextStyle(color: kGreyColor, fontSize: 15),
            ),
          ),
        )
      ],
    ),
  );
}
