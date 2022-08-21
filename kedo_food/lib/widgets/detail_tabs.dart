import 'package:flutter/material.dart';

class DetailTabs extends StatefulWidget {
  const DetailTabs({Key? key}) : super(key: key);

  @override
  State<DetailTabs> createState() => _DetailTabsState();
}

class _DetailTabsState extends State<DetailTabs> with TickerProviderStateMixin {
  late TabController _controller;

  List<Tab> tabs = [
    Tab(
      child: Text('Description'),
    ),
    Tab(
      child: Text('Review'),
    ),
    Tab(
      child: Text('Disscussion'),
    )
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: TabBar(
          controller: _controller,
          indicatorColor: Colors.green.shade700,
          labelColor: Colors.black87,
          unselectedLabelColor: Colors.grey.shade500,
          tabs: tabs,
        ),
      ),
      Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: TabBarView(
          controller: _controller,
          children: [
            Center(
              child: Text("It's cloudy here"),
            ),
            Center(
              child: Text("It's rainy here"),
            ),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      )
    ]);
  }
}
