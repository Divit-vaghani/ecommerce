import 'package:ecommerce/widgets/my_cart_items.dart';
import 'package:ecommerce/widgets/shopping_mall_items.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Ecommerce());
}

class Ecommerce extends StatelessWidget {
  const Ecommerce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Shopping Mall'),
        actions: [
          IconButton(
            tooltip: 'Cart',
            splashRadius: 20.0,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MyCartScreen(),
              ),
            ),
            icon: const Icon(Icons.shopping_cart_sharp),
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: 12,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
        ),
        itemBuilder: (context, index) {
          return ShoppingMallItems(
            onPressed: () {},
            imageUrl:
                'http://205.134.254.135/~mobile/MtProject/uploads/product_image/7.jpg',
            productCount: 'Product ${index + 1}',
          );
        },
      ),
    );
  }
}

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
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 12,
        itemBuilder: (context, index) => const MyCartItems(
          imageUrl:
              'http://205.134.254.135/~mobile/MtProject/uploads/product_image/5.jpg',
          productName: 'Product 1',
          productPrice: 200,
          quantity: 1,
        ),
      ),
    );
  }
}
