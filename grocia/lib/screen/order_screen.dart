import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/constants/constants.dart';
import 'package:grocia/model/order_detail_model.dart';
import 'package:grocia/widgets/bottom_navigator.dart';
import 'package:grocia/widgets/order_list.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '/order';
  static const int iconIndex = 2;
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabBar tabBar = const TabBar(
        indicatorColor: kGreenColor,
        labelColor: kGreenColor,
        labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: appFontSize),
        unselectedLabelColor: kGreyColor,
        unselectedLabelStyle: TextStyle(fontSize: appFontSize),
        tabs: [
          Tab(text: "Completed"),
          Tab(text: "On Progress"),
          Tab(text: "Canceled")
        ]);

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: kGreyLightColor,
                leading: const Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Text(
                    'My Order',
                    style: TextStyle(
                        color: kBlackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                leadingWidth: orderScreenTitleWidth,
                toolbarHeight: orderScreenToolBarHeight,
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                        color: kBlackColor,
                      ))
                ],
                bottom: tabBar,
              ),
            ];
          },
          body: TabBarView(children: [
            OrderList(
              orders: dummyOrderList,
            ),
            OrderList(
              orders: dummyOrderList,
            ),
            OrderList(
              orders: dummyOrderList,
            )
          ]),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(
        activeItemIndex: iconIndex,
      ),
    );
  }
}
