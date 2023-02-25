import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:grocia/constants/colors.dart';

class ProductItemCarousal extends StatefulWidget {
  final List<String> carousalImages;

  const ProductItemCarousal({super.key, required this.carousalImages});

  @override
  State<ProductItemCarousal> createState() => _ProductItemCarousalState();
}

class _ProductItemCarousalState extends State<ProductItemCarousal> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _pageControlTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageControlTimer = getTimer();
  }

  Timer getTimer({int id = 0}) {
    return Timer.periodic(Duration(seconds: 2), (timer) {
      print(id);
      _currentPage++;
      _pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Image Carousal With darkened background image
    final imagesLength = widget.carousalImages.length;
    return SizedBox(
      height: 220,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (value) => _currentPage = value,
        itemBuilder: (context, index) => GestureDetector(
          onPanDown: (details) {
            _pageControlTimer.cancel();
          },
          onPanEnd: (details) => _pageControlTimer = getTimer(id: index),
          onPanCancel: () => _pageControlTimer = getTimer(id: index),
          child: Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: kBlackColor,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(widget.carousalImages[index % imagesLength]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageControlTimer.cancel();
  }
}
