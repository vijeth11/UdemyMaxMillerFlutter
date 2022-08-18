import 'package:flutter/material.dart';
import 'package:kedo_food/model/market_item.dart';
import 'package:kedo_food/model/tile_detail.dart';
import 'package:kedo_food/screens/category_type_list.dart';
import 'package:kedo_food/widgets/item_card.dart';
import 'package:kedo_food/widgets/search_bar_header.dart';

class CategoryMenu extends StatefulWidget {
  static const String routeName = 'CategoryName';

  CategoryMenu({Key? key}) : super(key: key);

  @override
  State<CategoryMenu> createState() => _CategoryMenuState();
}

class _CategoryMenuState extends State<CategoryMenu> {
  late List<MarketItem> menuItems;
  late TileDetail _categoryTile;
  Color iconColor = Colors.white;
  late double fixedAppBarHeight;

  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(listener);
    menuItems = List.generate(
        20,
        (index) => MarketItem(
            name: 'Avocado',
            cost: 8.8,
            isFavourite: true,
            image: 'item-brocoli.png'));
    super.initState();
  }

  void listener() {
    var offset = scrollController.offset;
    //print("offset data $offset");
    if (offset > 140 && iconColor == Colors.white) {
      //print("offset data $offset");
      setState(() {
        iconColor = Colors.black;
      });
    } else if (offset < 140 && iconColor == Colors.black) {
      setState(() {
        iconColor = Colors.white;
      });
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(listener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _categoryTile = ModalRoute.of(context)!.settings.arguments as TileDetail;
    fixedAppBarHeight = MediaQuery.of(context).padding.top + kToolbarHeight;
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            iconTheme: IconThemeData(
              color: iconColor,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(CategoryTypeList.routeName);
                    },
                    icon: const Icon(
                      Icons.menu_rounded,
                      size: 40,
                    )),
              )
            ],
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 30.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_circle_left_outlined,
                    size: 40,
                  )),
            ),
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                //print('constraints=' + constraints.toString());
                var top = constraints.biggest.height;
                //print(top);
                return FlexibleSpaceBar(
                  title: top == fixedAppBarHeight
                      ? Text(
                          _categoryTile.title,
                          style: const TextStyle(color: Colors.black),
                        )
                      : SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_categoryTile.title,
                                    style: const TextStyle(fontSize: 25)),
                                Text(
                                  '${_categoryTile.itemCount} items',
                                  style: TextStyle(fontSize: 15),
                                )
                              ]),
                        ),
                  titlePadding: top == fixedAppBarHeight
                      ? null
                      : EdgeInsets.only(left: 180 - (top / 1.8), bottom: 20),
                  //collapseMode: CollapseMode.pin,
                  centerTitle: top == fixedAppBarHeight,
                  background: Container(
                    color: Color(0xFF4CB32B),
                  ),
                );
              },
            ),
          ),
          const SearchBarHeader(),
          SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ItemCard(item: menuItems[index],isCardLeft: (index % 2) == 0,);
              }, childCount: menuItems.length),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 250,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5))
        ],
      ),
    );
  }
}
