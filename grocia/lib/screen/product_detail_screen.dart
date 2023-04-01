import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/model/item_model.dart';
import 'package:grocia/provider/productItem.provider.dart';
import 'package:grocia/widgets/back-button-appBar.dart';
import 'package:grocia/widgets/half_filled_icon.dart';
import 'package:grocia/widgets/product-item-grid.dart';
import 'package:grocia/widgets/product_item_card.dart';
import 'package:grocia/widgets/product_item_carousal.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final int itemId;
  static String routeName = "/product-detail";
  const ProductDetailScreen({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    var productItemProvider =
        Provider.of<ProductItemProvider>(context, listen: false);
    ItemModel selectedItem = productItemProvider.getItemById(itemId);
    List<ItemModel> similarItems = productItemProvider.items
        .where((element) => element.itemCategory == selectedItem.itemCategory)
        .toList();
    double screenWidth = MediaQuery.of(context).size.width;
    double heightOfBottomSheet = 60.0;
    return Scaffold(
      appBar: BackActionAppBar(context, '', backgroundColor: kWhiteColor),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getProductDetailHeaderSection(selectedItem),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              color: kGreyLightColor,
              child: ProductItemCarousal(
                  carousalImages: selectedItem.slidingImages),
            ),
            getAvailableOptions(selectedItem),
            const SizedBox(
              height: 10,
            ),
            getProductDescription(selectedItem),
            const SizedBox(
              height: 20,
            ),
            getSimilarProducts(similarItems),
            // display complete similar containers
            SizedBox(
              height: heightOfBottomSheet + 30,
            )
          ],
        ),
      ),
      bottomSheet: Row(
        children: [
          GestureDetector(
            child: Container(
              height: heightOfBottomSheet,
              width: screenWidth * 0.3,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5)),
                color: kYellowColor,
              ),
              child: const Icon(
                Icons.shopping_cart,
                color: kBlackColor,
              ),
            ),
            onTap: () => {
              // add to cart
            },
          ),
          GestureDetector(
            child: Container(
              height: heightOfBottomSheet,
              width: screenWidth * 0.7,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(5)),
                color: kGreenColor.withOpacity(0.8),
              ),
              child: const Text(
                "Buy",
                style: TextStyle(color: kWhiteColor),
              ),
            ),
            onTap: () => {
              // display cart section and payment
            },
          )
        ],
      ),
    );
  }

  Widget getProductDetailHeaderSection(ItemModel selectedItem) {
    Widget getWrappingContainerForRating(Widget child) {
      return Container(
          decoration: BoxDecoration(
              color: kBlackColor, borderRadius: BorderRadius.circular(5)),
          child: child);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            selectedItem.itemName,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Product MRP :Rs${selectedItem.itemCost}",
          ),
          const SizedBox(
            height: 10,
          ),
          // display rating of the product
          Row(
            children: [
              RatingBar(
                ratingWidget: RatingWidget(
                  full: getWrappingContainerForRating(
                    const Icon(
                      Icons.star,
                      color: kOrangeColor,
                    ),
                  ),
                  empty: getWrappingContainerForRating(const Icon(
                    Icons.star,
                    color: kWhiteColor,
                  )),
                  half: getWrappingContainerForRating(HalfFilledIcon(
                    icon: Icons.star,
                    primaryColor: kOrangeColor,
                    secondaryColor: kWhiteColor,
                    size: 20,
                  )),
                ),
                itemCount: 5,
                initialRating: selectedItem.rating,
                itemSize: 20,
                allowHalfRating: true,
                direction: Axis.horizontal,
                itemPadding: const EdgeInsets.all(2),
                onRatingUpdate: (double value) {},
              ),
              const SizedBox(
                width: 10,
              ),
              Text("(${selectedItem.reviews.length} Reviews)")
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          // ignore: prefer_const_literals_to_create_immutables
          Row(children: [
            const Text(
              "Delivery",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Free",
              style: TextStyle(color: kGreyColor, fontSize: 20),
            )
          ])
        ],
      ),
    );
  }

  Widget getAvailableOptions(ItemModel selectedItem) {
    Widget getAvailableButtons(String text, {bool isSelected = false}) {
      return Container(
        alignment: Alignment.center,
        child: Text(text),
        padding: const EdgeInsets.all(10),
        width: 70,
        decoration: BoxDecoration(
            color: isSelected ? kYellowColor : null,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: kYellowColor)),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      color: kWhiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Available in:",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
                children: selectedItem.availableTypes.isNotEmpty
                    ? [
                        ...selectedItem.availableTypes.map((element) {
                          return [
                            getAvailableButtons(element.keys.first,
                                isSelected: selectedItem.availableTypes
                                        .indexOf(element) ==
                                    0),
                            const SizedBox(
                              width: 10,
                            )
                          ];
                        }).toList()
                      ].reduce((value, element) {
                        value.addAll(element);
                        return value;
                      })
                    : [getAvailableButtons("1 kg")])
          ]),
          ProductItemCard.getQuantityController(initialQuant: 1)
        ],
      ),
    );
  }

  Widget getProductDescription(ItemModel selectedItem) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Product Details",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            const SizedBox(
              height: 5,
            ),
            Text.rich(
              TextSpan(
                  text: selectedItem.description,
                  style: const TextStyle(color: kGreyColor)),
              softWrap: true,
            )
          ],
        ),
      ),
    );
  }

  Widget getSimilarProducts(List<ItemModel> similarItems) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text("May be You Like this.",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
      ),
      const SizedBox(
        height: 10,
      ),
      getProductItemsGrid(similarItems, sizedHeight: 770)
    ]);
  }
}
