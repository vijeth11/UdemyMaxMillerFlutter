import 'package:flutter/material.dart';

class SearchBarHeader extends StatelessWidget {
  const SearchBarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: Delegate(),
      pinned: true,
      floating: false,
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  Delegate();
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
      child: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade300),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // replace with text input
                Text(
                  'Search here',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 20),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey.shade700,
                      size: 35,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 120;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
