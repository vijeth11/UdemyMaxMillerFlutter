import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kedo_food/infrastructure/page_button.dart';
import 'package:kedo_food/model/category_tile_detail.dart';
import 'package:kedo_food/model/market_item.dart';
import 'package:kedo_food/screens/category_menu.dart';
import 'package:kedo_food/screens/category_type_list.dart';
import 'package:kedo_food/screens/item_detail.dart';
import 'package:kedo_food/widgets/bottom_navigator.dart';
import 'package:kedo_food/widgets/item_card.dart';

class MyHomePage extends StatefulWidget {
  static const String routeName = '/';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userName = "Test Tester";
  int trendingItemsCount = 4;
  final int heightOfGridRow = 127;
  final PageController _controller =
      PageController(viewportFraction: 1 / 3, initialPage: 1);
  final scrollController = ScrollController();
  List<Map<String, Object>> carouselData = [
    {
      "image": const AssetImage("assets/images/recipe.png"),
      "summary": "Recomended Recipe Today"
    },
    {
      "image": const AssetImage("assets/images/recipe1.png"),
      "summary": "Fresh Fruits Delivery"
    },
    {
      "image": const AssetImage("assets/images/recipe2.png"),
      "summary": "Fresh Handpicked Vegetables"
    },
    {
      "image": const AssetImage("assets/images/recipe3.png"),
      "summary": "Best Recipe Of the Week"
    }
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 22),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: MediaQuery.of(context).viewPadding.top,
            ),
            const Text("Good Morning", style: const TextStyle(fontSize: 17)),
            const SizedBox(
              height: 10,
            ),
            Text(
              userName,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            // Image Carousal With darkened background image
            SizedBox(
              height: 220,
              child: PageView.builder(
                itemCount: carouselData.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 22.0),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.8), BlendMode.dstATop),
                        image: carouselData[index]['image'] as AssetImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22, bottom: 20.0),
                      child: Text(
                        carouselData[index]['summary'] as String,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            getSectionTitle("Categories"),
            SizedBox(
              height: 10,
            ),
            // Iamge Carousal for categories
            SizedBox(
              height: 80,
              child: PageView.builder(
                controller: _controller,
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                itemCount: categoryTiles.length,
                onPageChanged: (index) {
                  if (index == 5) _controller.jumpToPage(4);
                  if (index == 0) _controller.jumpToPage(1);
                },
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(CategoryMenu.routeName,
                        arguments: categoryTiles[index]);
                  },
                  child: Container(
                    width: 50,
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(211, 77, 179, 43)),
                    child: Center(
                      child: SvgPicture.asset(
                        categoryTiles[index].svgfile,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            getSectionTitle("Trending Deals"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                height: (heightOfGridRow * trendingItemsCount).toDouble(),
                child: GridView.builder(
                  //suppress the inner gridview scroller and allow page scroll
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: trendingItemsCount,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisExtent: 250,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5),
                  padding: EdgeInsets.only(top: 0),
                  itemBuilder: (context, index) {
                    return ItemCard(
                      item: menuItems[index],
                      isCardLeft: (index % 2) == 0,
                      onClick: () {
                        Navigator.of(context).pushNamed(ItemDetail.routeName,
                            arguments: menuItems[index]);
                      },
                    );
                  },
                )),
            SizedBox(
              height: 10,
            ),
            getPageButton("LOAD MORE", () {
              setState(() {
                if (trendingItemsCount < menuItems.length)
                  trendingItemsCount += 2;
              });
            })
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavigator(BottomIcons.Home),
    );
  }

  Widget getSectionTitle(String sectionName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(sectionName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        IconButton(
            padding: EdgeInsets.only(right: 30),
            onPressed: () {
              Navigator.of(context).pushNamed(CategoryTypeList.routeName);
            },
            icon: const Icon(
              Icons.arrow_circle_right_outlined,
              color: Color.fromARGB(201, 81, 167, 84),
              size: 40,
            ))
      ],
    );
  }
}
