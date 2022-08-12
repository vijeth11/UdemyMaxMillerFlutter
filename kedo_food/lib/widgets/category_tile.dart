import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kedo_food/model/tile_detail.dart';
import 'package:kedo_food/screens/category_menu.dart';

class CategoryTile extends StatelessWidget {
  final TileDetail categoryTileData;

  const CategoryTile({Key? key, required this.categoryTileData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(CategoryMenu.routeName,
                  arguments: categoryTileData.title);
            },
            child: Card(
              elevation: 0,
              color: Color.fromARGB(211, 77, 179, 43),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              categoryTileData.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            )),
                        Text(
                          '${categoryTileData.itemCount} items',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                    SvgPicture.asset(
                      categoryTileData.svgfile,
                      height: 40,
                      width: 40,
                    )
                  ],
                ),
              ),
            )));
  }
}
