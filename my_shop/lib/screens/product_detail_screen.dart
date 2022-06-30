import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-detail';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ScrollController _scrollController;
  bool visible = true;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_setTitleVisibility);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_setTitleVisibility);
    super.dispose();
  }

  void _setTitleVisibility() {
    if (_scrollController.offset > 235) {
      if (visible) {
        setState(() {
          visible = false;
        });
      }
    } else {
      if (!visible) {
        setState(() {
          visible = true;
        });
      }
    }
    print(_scrollController.offset);
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments;
    // if listen is set to false any change on items in Products will not be listened
    // by default listen is true in Provider
    final productsProvider = Provider.of<Products>(context, listen: false);
    final Product item = productsProvider.findById(productId as String);
    return Scaffold(
      /*appBar: AppBar(
        title: Text(item.title),
      ),*/
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            title: !visible ? Text(item.title) : null,
            flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(bottom: 0, top: 110),
                title: Visibility(
                  visible: visible,
                  child: Container(
                      width: 130,
                      color: Colors.black54,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(item.title)),
                ),
                background: Hero(
                    tag: productId,
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                    ))),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(
              height: 10,
            ),
            Text(
              '\$${item.price}',
              style: const TextStyle(color: Colors.grey, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  item.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                )),
            SizedBox(
              height: 800,
            )
          ]))
        ],
      ),
    );
  }
}
