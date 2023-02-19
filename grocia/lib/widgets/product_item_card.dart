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
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                productItem.itemImage,
              ),
              Text(productItem.itemName),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rs${productItem.itemCost}/kg'),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: kGreyLightColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(Icons.add),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
