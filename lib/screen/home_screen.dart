import 'package:ecommerce/blocs/shopping_bloc.dart';
import 'package:ecommerce/const/const.dart';
import 'package:ecommerce/model/shopping_mall.dart';
import 'package:ecommerce/screen/my_cart_screen.dart';
import 'package:ecommerce/widgets/lottie_widget.dart';
import 'package:ecommerce/widgets/shopping_mall_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void addEvent(BuildContext context, ShoppingEvent shoppingEvent) =>
      context.read<ShoppingBloc>().add(shoppingEvent);

  @override
  void initState() {
    context.read<ShoppingBloc>().add(GetShoppingList());
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
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => const MyCartScreen()))
                .whenComplete(
                  () => addEvent(
                    context,
                    GetShoppingList(),
                  ),
                ),
            icon: const Icon(Icons.shopping_cart_sharp),
          )
        ],
      ),
      body: BlocListener<ShoppingBloc, ShoppingState>(
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
                itemCount: state.products.length,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                ),
                itemBuilder: (context, index) {
                  Datum shoppingItems = state.products[index];
                  return ShoppingMallItems(
                    onPressed: () =>
                        shoppingItems.cart == null || shoppingItems.cart == 0
                            ? addEvent(
                                context,
                                AddToCart(
                                  datum: Datum.carts(
                                    cart: 1,
                                    id: shoppingItems.id,
                                    status: '1',
                                  ),
                                ),
                              )
                            : addEvent(
                                context,
                                RemoveFromCart(
                                  datum: Datum.carts(
                                      cart: 0,
                                      id: shoppingItems.id,
                                      status: '1'),
                                ),
                              ),
                    color: shoppingItems.cart == null || shoppingItems.cart == 0
                        ? AppColor.iconColor
                        : Theme.of(context).primaryColor,
                    imageUrl: "${shoppingItems.featuredImage}",
                    productCount: "${shoppingItems.title}",
                  );
                },
              );
            } else if (state is ShoppingError) {
              return const LottieWidget(path: Assets.error);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
