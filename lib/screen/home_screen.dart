import 'package:ecommerce/blocs/shopping_bloc.dart';
import 'package:ecommerce/const/const.dart';
import 'package:ecommerce/model/shopping_mall.dart';
import 'package:ecommerce/screen/my_cart_screen.dart';
import 'package:ecommerce/widgets/error_widget.dart';
import 'package:ecommerce/widgets/shopping_mall_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ShoppingBloc shoppingBloc = ShoppingBloc();

  @override
  void initState() {
    shoppingBloc.add(GetShoppingList());
    super.initState();
  }

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
                MaterialPageRoute(builder: (context) => const MyCartScreen())),
            icon: const Icon(Icons.shopping_cart_sharp),
          )
        ],
      ),
      body: BlocProvider<ShoppingBloc>(
        create: (context) => shoppingBloc,
        child: BlocListener<ShoppingBloc, ShoppingState>(
          listener: (context, state) {
            if (state is ShoppingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${state.message}"),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
          },
          child: BlocBuilder<ShoppingBloc, ShoppingState>(
            builder: (context, state) {
              if (state is ShoppingLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ShoppingLoaded) {
                return GridView.builder(
                  itemCount: state.shoppingMall.data!.length,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                  ),
                  itemBuilder: (context, index) {
                    Datum shoppingItems = state.shoppingMall.data![index];
                    return ShoppingMallItems(
                      onPressed: () {},
                      imageUrl: "${shoppingItems.featuredImage}",
                      productCount: "${shoppingItems.title}",
                    );
                  },
                );
              } else if (state is ShoppingError) {
                return const LoadingErrorWidget(error: Assets.error);
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
