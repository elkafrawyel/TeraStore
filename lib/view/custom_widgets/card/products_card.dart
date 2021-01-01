import 'package:flutter/material.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:get/get.dart';

import '../../product_details_screen.dart';
import '../text/custom_text.dart';

class ProductsCard extends StatelessWidget {
  final ProductModel product;

  ProductsCard({this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductDetailsScreen(product));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade200),
        child: Card(
          elevation: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.height * 0.6,
                    child: Container(
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.height * 0.6,
                        height: 150,
                        placeholder: placeholder,
                        image: product.image,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: PositionedDirectional(
                      top: 0,
                      end: 5,
                      child: Image.asset(
                        newImage,
                        width: 50,
                        height: 40,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    fontSize: 14,
                    text: product.name,
                    alignment: AlignmentDirectional.topStart,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    product.price.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomText(
                    text: product.discountPrice.toString(),
                    alignment: AlignmentDirectional.topStart,
                    color: primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
