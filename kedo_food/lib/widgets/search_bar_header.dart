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
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          "add a search bar",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
