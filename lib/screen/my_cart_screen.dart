import 'package:ecommerce/widgets/my_cart_items.dart';
import 'package:flutter/material.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 0,
        title: const Text('My Cart'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 500,
          mainAxisExtent: 150,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: 0,
        itemBuilder: (context, index) => const MyCartItems(
          imageUrl:
              'http://205.134.254.135/~mobile/MtProject/uploads/product_image/5.jpg',
          productName: '',
          productPrice: 100,
          quantity: 1,
        ),
      ),
    );
  }
}
