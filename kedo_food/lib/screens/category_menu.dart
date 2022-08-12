import 'package:flutter/material.dart';
import 'package:kedo_food/screens/category_type_list.dart';
import 'package:kedo_food/widgets/search_bar_header.dart';

class CategoryMenu extends StatelessWidget {
  static const String routeName = 'CategoryName';
  late String _categoryName;
  CategoryMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _categoryName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
                color: Colors.black,
                size: 40,
              )),
        ),
        //title: Text(_categoryName),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(CategoryTypeList.routeName);
              },
              icon: Icon(Icons.menu_rounded))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            expandedHeight: 250.0,
            primary: false,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              title: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_categoryName, style: TextStyle(fontSize: 25)),
                      Text(
                        "items: 87",
                        style: TextStyle(fontSize: 15),
                      )
                    ]),
              ),
              titlePadding: EdgeInsets.only(left: 15, bottom: 20),
              collapseMode: CollapseMode.pin,
              background: Container(
                color: Colors.green[100],
              ),
            ),
          ),
          SearchBarHeader(),
          SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('Grid Item $index'),
                );
              }, childCount: 20),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5))
        ],
      ),
    );
  }
}
