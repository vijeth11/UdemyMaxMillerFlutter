import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/model/item_model.dart';
import 'package:grocia/provider/productItem.provider.dart';
import 'package:grocia/widgets/page-app-bar.dart';
import 'package:grocia/widgets/product-item-carousal-card.dart';
import 'package:provider/provider.dart';

class RecommendedItems extends StatelessWidget {
  const RecommendedItems({super.key});

  @override
  Widget build(BuildContext context) {
    List<ItemModel> productItems =
        Provider.of<ProductItemProvider>(context).items;
    return Scaffold(
      appBar: getPageAppBar("Recommend for You", context,
          backGroundColor: kGreyLightColor),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...productItems
                .where((element) => element.slidingImages.isNotEmpty)
                .map((item) => [
                      const SizedBox(
                        height: 5,
                      ),
                      getCarousalItemCard(item, context)
                    ])
                .reduce((value, element) {
              value.addAll(element);
              return value;
            })
          ],
        ),
      ),
    );
  }
}
