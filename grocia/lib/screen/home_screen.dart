import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/constants/constants.dart';
import 'package:grocia/pages/recommended_items_page.dart';
import 'package:grocia/pages/top_picks_page.dart';
import 'package:grocia/provider/productItem.provider.dart';
import 'package:grocia/screen/category_items_screen.dart';
import 'package:grocia/widgets/bottom_navigator.dart';
import 'package:grocia/widgets/create_animated_router.dart';
import 'package:grocia/widgets/form_textbox.dart';
import 'package:grocia/widgets/product-item-carousal-card.dart';
import 'package:grocia/widgets/product-item-grid.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/shop';
  static const int iconIndex = 0;

  HomeScreen({super.key});

  final appBar = AppBar(
    backgroundColor: kGreyLightColor,
    leading: Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            iconImagePath,
            height: iconImageSize,
            width: iconImageSize,
            fit: BoxFit.cover,
          )),
    ),
    title: const Text(
      "Grocia",
      style: TextStyle(color: kGreenColor, fontSize: 25),
    ),
    elevation: 0,
  );

  @override
  Widget build(BuildContext context) {
    final productItems =
        Provider.of<ProductItemProvider>(context, listen: false).items;
    return Scaffold(
      appBar: appBar,
      body: Container(
        color: kGreyLightColor,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getSearchBar(),
              const SizedBox(
                height: 10,
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: kGreyColor.withOpacity(0.4),
              ),
              const SizedBox(
                height: 15,
              ),
              addPadding(
                const Text(
                  "What are you looking for?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              addPadding(getCategoryItemGrid(context)),
              const SizedBox(
                height: 10,
              ),
              getSectionTitle("Pick's Today", () {
                Navigator.of(context).push(CreateRoute(const TopPicks()));
              }),
              const SizedBox(
                height: 10,
              ),
              addPadding(getProductItemsGrid(productItems.sublist(0, 6))),
              getSectionTitle("Recommend for You", () {
                Navigator.of(context)
                    .push(CreateRoute(const RecommendedItems()));
              }),
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
      ),
      bottomNavigationBar: const BottomNavigation(
        activeItemIndex: iconIndex,
      ),
    );
  }

  Widget addPadding(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: child,
    );
  }

  Widget getSearchBar() {
    const searchBarBorderRadius = 10.0;
    const searchBarPadding = 10.0;
    return Container(
      margin: const EdgeInsets.all(searchBarPadding),
      decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(searchBarBorderRadius),
          boxShadow: const [
            BoxShadow(color: kGreyColor, offset: Offset(0, 1))
          ]),
      child: getInputForm(
        "Search for Products...",
        icon: Icons.search,
        isSuffix: false,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(searchBarBorderRadius),
            borderSide: const BorderSide(width: 5)),
        onIconPress: () {
          // TODO take to items page
        },
      )[1],
    );
  }

  Widget getCategoryItemGrid(BuildContext context) {
    const childCardWidthPercent = 100.0;
    const childCardHeightPercent = 111.0;

    return SizedBox(
      height: 220,
      // to increase GridView size to wrap arround the size of child elemnts
      // use childAspectRatio
      child: GridView.count(
        crossAxisCount: 4,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: (childCardWidthPercent / childCardHeightPercent),
        children: categoryImages.keys
            .map((name) => getCategoryItemGridCard(name, context))
            .toList(),
      ),
    );
  }

  Widget getSectionTitle(String title, VoidCallback seeMore) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            TextButton(
                onPressed: seeMore,
                child: const Text(
                  "See more",
                  style: TextStyle(color: kGreenColor),
                ))
          ],
        ));
  }

  Widget getCategoryItemGridCard(String itemName, BuildContext context) {
    const categoryImageSize = 50.0;
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            children: [
              SvgPicture.asset(
                categoryImages[itemName]!,
                height: categoryImageSize,
                width: categoryImageSize,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(itemName)
            ],
          ),
        ),
      ),
      onTap: () => Routemaster.of(context)
          .push("${CategoryItemScreen.routeName}/${itemName}"),
    );
  }
}
