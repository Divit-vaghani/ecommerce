import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/const/const.dart';
import 'package:ecommerce/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class ShoppingMallItems extends StatelessWidget {
  const ShoppingMallItems(
      {Key? key,
      required this.imageUrl,
      required this.onPressed,
      required this.productCount})
      : super(key: key);

  final String imageUrl;
  final void Function() onPressed;
  final String productCount;

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(6.0),
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
            ),
            Container(
              height: 45.0,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              color: const Color(0xffFAFAFA),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: CustomTextWidget(productCount, fontSize: 15),
                  ),
                  IconButton(
                    splashRadius: 20.0,
                    onPressed: onPressed,
                    color: AppColor.iconColor,
                    tooltip: 'Cart',
                    icon: const Icon(Icons.shopping_cart_sharp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
