import 'package:flutter/material.dart';
import 'package:kedo_food/model/market_item.dart';

class ItemCard extends StatelessWidget {
  final MarketItem item;
  final bool isCardLeft;
  final VoidCallback onClick;
  const ItemCard(
      {super.key,
      required this.item,
      required this.isCardLeft,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          isCardLeft ? 20.0 : 5.0, 9.0, isCardLeft ? 5.0 : 20.0, 9.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GridTile(
          header: GridTileBar(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
                color: item.isFavourite ? Colors.red : Colors.white,
                size: 30,
              ),
            ),
          ),
          footer: Container(
              //color: const Color.fromARGB(83, 8, 8, 8),
              child: Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  "\$ ${item.cost}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          )),
          child: GestureDetector(
              onTap: onClick,
              child: Container(
                // gradient background needs to be given
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(1.0), BlendMode.softLight),
                        image: NetworkImage(item.image),
                        fit: BoxFit.cover)),
              )),
        ),
      ),
    );
  }
}
