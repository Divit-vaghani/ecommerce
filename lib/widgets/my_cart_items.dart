import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/const/const.dart';
import 'package:ecommerce/widgets/custom_text_widget.dart';
import 'package:ecommerce/widgets/information_widget.dart';
import 'package:flutter/material.dart';

class MyCartItems extends StatelessWidget {
  const MyCartItems({
    Key? key,
    required this.imageUrl,
    required this.quantity,
    required this.productPrice,
    required this.productName,
  }) : super(key: key);

  final String imageUrl;
  final int quantity;
  final double productPrice;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(7.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.longestSide * 0.15,
              height: MediaQuery.of(context).size.longestSide * 0.16,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(
                    Icons.error,
                    color: AppColor.iconColor,
                  ),
                ),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InformationWidget(
                      children: [
                        CustomTextWidget(productName),
                      ],
                    ),
                    InformationWidget(
                      children: [
                        const CustomTextWidget('Price'),
                        CustomTextWidget('₹ $productPrice'),
                      ],
                    ),
                    InformationWidget(
                      children: [
                        const CustomTextWidget('Quantity'),
                        CustomTextWidget('$quantity'),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
