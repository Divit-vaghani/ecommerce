import 'package:ecommerce/blocs/shopping_bloc.dart';
import 'package:ecommerce/const/const.dart';
import 'package:ecommerce/model/shopping_mall.dart';
import 'package:ecommerce/widgets/custom_text_widget.dart';
import 'package:ecommerce/widgets/my_cart_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  void addEvent(BuildContext context, ShoppingEvent shoppingEvent) =>
      context.read<ShoppingBloc>().add(shoppingEvent);

  @override
  void initState() {
    context.read<ShoppingBloc>().add(GetCartList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 0,
        title: const Text('My Cart'),
      ),
      body: BlocBuilder<ShoppingBloc, ShoppingState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartLoaded) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 500,
                mainAxisExtent: 150,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                Datum cartItems = state.products[index];
                return MyCartItems(
                  onAdd: () => addEvent(
                    context,
                    AddItem(
                      datum: Datum.addRemove(
                        id: cartItems.id,
                        status:
                            "${int.parse("${cartItems.status}") >= 25 ? 25 : int.parse("${cartItems.status}") + 1}",
                      ),
                    ),
                  ),
                  onRemove: () => addEvent(
                    context,
                    RemoveItem(
                      datum: Datum.addRemove(
                        id: cartItems.id,
                        status:
                            "${int.parse("${cartItems.status}") <= 1 ? 1 : int.parse("${cartItems.status}") - 1}",
                      ),
                    ),
                  ),
                  imageUrl: "${cartItems.featuredImage}",
                  productName: "${cartItems.slug?.replaceAll("_", " ")}",
                  productPrice: cartItems.price!.toDouble(),
                  quantity: int.parse("${cartItems.status}"),
                );
              },
            );
          } else if (state is CartEmpty) {
            return const Center(child: CustomTextWidget("Cart is Empty"));
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: BlocBuilder<ShoppingBloc, ShoppingState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            return Container(
              color: Theme.of(context).primaryColor,
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget(
                    "Total items : ${state.totalItems}",
                    color: AppColor.white,
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                  ),
                  Flexible(
                    child: CustomTextWidget(
                      "Grand Total : ₹ ${state.totalPrice}",
                      color: AppColor.white,
                      margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CartEmpty) {
            return const SizedBox();
          }
          return const SizedBox();
        },
      ),
    );
  }
}
