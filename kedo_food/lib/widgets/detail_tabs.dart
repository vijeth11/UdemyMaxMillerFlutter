import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:kedo_food/model/market_item.dart';

class DetailTabs extends StatefulWidget {
  final String description;
  final String discussion;
  final List<Review> reviews;
  const DetailTabs(
      {Key? key,
      required this.description,
      required this.discussion,
      required this.reviews})
      : super(key: key);

  @override
  State<DetailTabs> createState() => _DetailTabsState();
}

class _DetailTabsState extends State<DetailTabs> with TickerProviderStateMixin {
  late TabController _controller;

  List<Widget> tabs = [
    Container(
      width: 105,
      child: const Tab(
        text: 'Description',
      ),
    ),
    Container(
      width: 65,
      child: const Tab(
        text: 'Review',
      ),
    ),
    Container(
      width: 130,
      child: const Tab(
        text: 'Disscussion',
      ),
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
      //Tab bar details
      Container(
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          controller: _controller,
          indicatorColor: Colors.green.shade700,
          labelColor: Colors.black87,
          labelStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          unselectedLabelColor: Colors.grey.shade500,
          tabs: tabs,
        ),
      ),
      Container(
        width: double.infinity,
        height: 300,
        child: TabBarView(
          controller: _controller,
          children: [
            //Discussion
            Text(
              widget.description,
              style: const TextStyle(fontSize: 20),
            ),
            //Review
            if (widget.reviews.isNotEmpty)
              ListView(
                children: [
                  ...widget.reviews.map(
                    (Review review) => ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  image: NetworkImage(review.userImage))),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    review.userName,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                RatingBar(
                                  initialRating: review.rating,
                                  minRating: 0,
                                  maxRating: 5,
                                  itemSize: 25,
                                  glow: false,
                                  ignoreGestures: true,
                                  onRatingUpdate: (double rating) {},
                                  ratingWidget: RatingWidget(
                                      empty: const Icon(Icons.star),
                                      half: const Icon(Icons.star_half),
                                      full: const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      )),
                                )
                              ],
                            ),
                            Text(
                              DateFormat('dd MMMM yyyy').format(review.date),
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              review.review,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              thickness: 2,
                            )
                          ],
                        )),
                  ),
                ],
              ),
            if (widget.reviews.isEmpty)
              Center(
                child: Text(
                  "Now reviews yet",
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
            //Discussion
            Text(
              widget.discussion,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      )
    ]);
  }
}
