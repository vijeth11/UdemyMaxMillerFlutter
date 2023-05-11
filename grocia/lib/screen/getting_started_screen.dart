import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/screen/home_screen.dart';
import 'package:grocia/widgets/flutter_custom_icons.dart';
import 'package:grocia/widgets/save_changes_button.dart';
import 'package:routemaster/routemaster.dart';

class GettingStartedScreen extends StatefulWidget {
  static const String routeName = "/getting-started";
  GettingStartedScreen({super.key});

  @override
  State<GettingStartedScreen> createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<Widget> slider = [
    {
      "image": FlutterCustomIcons.sale_discount,
      "title": "Best Prices & Offers",
      "description":
          "Cheaper prices than your local supermarket, get cashback offers to top it off."
    },
    {
      "image": FlutterCustomIcons.cart,
      "title": "Wide Assortment",
      "description":
          "Choose from 5000+ products across food, personal care, household & other categories."
    },
    {
      "image": FlutterCustomIcons.support_faq,
      "title": "Easy Returns",
      "description":
          "Not satisfied with a product? Return it at the doorstep & get a refund within hours."
    }
  ]
      .map((e) => Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Icon(
                e["image"] as IconData,
                color: kGreenColor,
                size: 45,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                e["title"] as String,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                e["description"] as String,
                textAlign: TextAlign.center,
                style: TextStyle(color: kGreyColor),
                softWrap: true,
              )
            ],
          )))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          width: double.infinity,
          child: CarouselSlider(
            items: slider,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 3,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: slider.asMap().entries.map((entry) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? kGreyColor
                          : kBlackColor)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            );
          }).toList(),
        ),
      ]),
      bottomSheet: SaveChangesButton(
        onPress: () => {Routemaster.of(context).replace(HomeScreen.routeName)},
        title: "Get Started",
      ),
    );
  }
}
