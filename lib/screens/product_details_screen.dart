import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/cart_controller.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/controllers/product_details_controller.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/screens/custom_widgets/data_state_views/loading_view.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_widgets/button/custom_cart_button.dart';
import 'custom_widgets/text/custom_description_text.dart';
import 'custom_widgets/text/custom_text.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  _loadDetails() async {
    await Get.put(ProductDetailsController()).getProductById(productId);
  }

  ProductDetailsScreen(this.productId) {
    _loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<ProductDetailsController>(
          builder: (controller) => controller.loading.value
              ? LoadingView()
              : Container(
                  child: Column(
                    children: [
                      _header(context, controller),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: CustomText(
                                        text: controller.productModel.name,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.productModel.price.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomText(
                                      fontSize: 22,
                                      text: controller
                                          .productModel.discountPrice
                                          .toString(),
                                      fontWeight: FontWeight.bold,
                                      color: Get.find<MainController>()
                                          .primaryColor,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    RatingBar.readOnly(
                                      initialRating: 3.5,
                                      isHalfAllowed: true,
                                      size: 30,
                                      filledColor: Colors.amber,
                                      halfFilledIcon: Icons.star_half,
                                      filledIcon: Icons.star,
                                      emptyIcon: Icons.star_border,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CustomText(
                                      text: '1253 ${'reviews'.tr}',
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    )
                                  ],
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: CustomCartButton(
                                    onPressed: () {
                                      _addToCart(controller.productModel);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            _ownerView(controller),
                            SizedBox(
                              height: 20,
                            ),
                            CustomText(
                              text: 'description'.tr,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomDescription(
                                text: controller.productModel.description,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, ProductDetailsController controller) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 320,
          color: Colors.grey.shade300,
          child: Image.network(
            controller.productModel.image,
            fit: BoxFit.contain,
          ),
        ),
        Visibility(
          visible: true,
          child: PositionedDirectional(
            bottom: 0,
            end: 15,
            child: Image.asset(
              newImage,
              width: 60,
              height: 40,
            ),
          ),
        ),
        PositionedDirectional(
            child: AppBar(
          backgroundColor: Colors.transparent,
          toolbarOpacity: 1,
          elevation: 0.0,
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 20),
                child: controller.productModel.isFav
                    ? GestureDetector(
                        onTap: () {
                          //remove
                          controller.removeFromFavourites(productId);
                        },
                        child: Icon(
                          Icons.favorite_outlined,
                          color: Colors.red,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          //add
                          controller.addToFavourites(productId);
                        },
                        child: Icon(
                          Icons.favorite_outline,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ))
      ],
    );
  }

  Widget _ownerView(ProductDetailsController controller) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage:
                      NetworkImage(controller.productModel.owner.photo),
                  radius: 50,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(top: 10),
              child: Column(
                children: [
                  CustomText(
                    text: controller.productModel.owner.name,
                    fontSize: 18,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.message,
                            color: LocalStorage().primaryColor(),
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          var phone = controller.productModel.owner.phone;
                          _launchCaller(phone);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.call,
                            color: LocalStorage().primaryColor(),
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _launchCaller(String phone) async {
    phone == null
        ? CommonMethods().showMessage('message'.tr, 'userHaveNoPhone'.tr)
        : await canLaunch("tel:$phone")
            ? await launch("tel:$phone")
            : throw 'Could not launch ${"tel:$phone"}';
  }

  void _addToCart(ProductModel productModel) async {
    Get.put(CartController()).addToCart(productModel).then((value) {
      CommonMethods().showMessage(productModel.name, 'addedToCart'.tr);
    });
  }
}
