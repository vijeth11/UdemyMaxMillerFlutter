import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kedo_food/helper/utils.dart';
import 'package:kedo_food/infrastructure/page_button.dart';
import 'package:kedo_food/model/market_item.dart';
import 'package:kedo_food/model/orderDetail.dart';
import 'package:kedo_food/providers/auth_provider.dart';
import 'package:kedo_food/providers/products.dart';
import 'package:kedo_food/screens/my_orders.dart';
import 'package:kedo_food/widgets/page_header.dart';
import 'package:provider/provider.dart';

class OrderItemReview extends StatefulWidget {
  static const String routeName = 'OrderItemReview';
  const OrderItemReview({Key? key}) : super(key: key);

  @override
  State<OrderItemReview> createState() => _OrderItemReviewState();
}

class _OrderItemReviewState extends State<OrderItemReview> {
  final _formKey = GlobalKey<FormState>();
  double itemRating = 0;
  bool isUploadingReview = false;
  Review newReview = Review(
      userName: "",
      review: "",
      rating: 0.0,
      date: DateTime.now(),
      userImage: "",
      productId: "");
  late Products productProvider;

  Future<void> submit() async {
    _formKey.currentState!.validate();
    _formKey.currentState!.save();
    setState(() {
      isUploadingReview = true;
    });
    newReview = newReview.copyTo(rating: itemRating);
    await productProvider.addProductReview(newReview);
    showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromTop,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        builder: (ctx) {
          return SimpleDialog(
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Image(
                  image: AssetImage("assets/images/feedback.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Thanks for sharing your thoughts, we appriciate yout feedback",
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Give Another Feedback",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).popUntil((route) =>
                              route.settings.name == MyOrders.routeName);
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
              )
            ],
          );
        });
    setState(() {
      isUploadingReview = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Auth user = Provider.of<Auth>(context, listen: false);
    productProvider = Provider.of<Products>(context, listen: false);
    newReview = newReview.copyTo(
        userName: user.userDetails.userName, userImage: user.userDetails.image);
    OrderDetail order =
        ModalRoute.of(context)!.settings.arguments as OrderDetail;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...getPageHeader("Order Review", context, titlePladding: 55),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                child: Text(
                  "Select the Item",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: DropdownButtonFormField<String>(
                  items: order.orderItems
                      .map((e) => DropdownMenuItem<String>(
                          value: e.itemId, child: Text(e.itemName)))
                      .toList(),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onChanged: (value) {},
                  onSaved: (value) {
                    newReview = newReview.copyTo(productId: value);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                child: Text(
                  "Rating",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: RatingBar(
                  minRating: 0,
                  maxRating: 5,
                  itemSize: 50,
                  allowHalfRating: true,
                  initialRating: itemRating,
                  glow: true,
                  ignoreGestures: false,
                  onRatingUpdate: (double rating) {
                    setState(() {
                      itemRating = rating;
                    });
                  },
                  ratingWidget: RatingWidget(
                      empty: const Icon(Icons.star),
                      half: const Icon(Icons.star_half, color: Colors.amber),
                      full: const Icon(
                        Icons.star,
                        color: Colors.amber,
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                child: Text(
                  "Your Review",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: getTextInput(
                    maxLines: 4,
                    saved: (value) {
                      newReview = newReview.copyTo(review: value);
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: isUploadingReview
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : getPageButton("Submit Review", submit))
            ],
          ),
        ),
      ),
    );
  }
}
