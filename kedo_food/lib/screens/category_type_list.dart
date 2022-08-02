import 'package:flutter/material.dart';
import 'package:kedo_food/model/tile_detail.dart';
import 'package:kedo_food/widgets/category_tile.dart';

class CategoryTypeList extends StatelessWidget {
  static const String routeName = 'category'; 

  CategoryTypeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).viewPadding.top,
          ),
          Card(
            elevation: 0,
            child: ListTile(
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
                title: Row(children: const [
                  SizedBox(width: 50),
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ])),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ...categoryTiles.map<CategoryTile>((element) {
                    return CategoryTile(categoryTileData: element);
                  }).toList()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
