import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/model/item_model.dart';
import 'package:grocia/provider/productItem.provider.dart';
import 'package:grocia/widgets/page-app-bar.dart';
import 'package:grocia/widgets/product-item-grid.dart';
import 'package:provider/provider.dart';

class TopPicks extends StatelessWidget {
  const TopPicks({super.key});

  @override
  Widget build(BuildContext context) {
    List<ItemModel> productItems =
        Provider.of<ProductItemProvider>(context).topPickItems();
    return Scaffold(
      appBar: getPageAppBar("Pick's Today", context,
          backGroundColor: kGreyLightColor),
      backgroundColor: kGreyLightColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: getProductItemsGrid(productItems),
      ),
    );
  }
}
