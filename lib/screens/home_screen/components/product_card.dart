import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.itemIndex,
    this.product,
    this.press,
    this.showActions = false,
  }) : super(key: key);

  final int itemIndex;
  final ProductModel product;
  final Function press;
  final bool showActions;

  @override
  Widget build(BuildContext context) {
    // It  will provide us total height and width of our screen
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding / 2,
        vertical: kDefaultPadding / 2,
      ),
      // color: Colors.blueAccent,
      height: 250,
      child: GestureDetector(
        onTap: press,
        child: Stack(
          children: <Widget>[
            // Those are our background
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: itemIndex.isEven ? kBlueColor : kSecondaryColor,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsetsDirectional.only(start: 10),
                decoration: BoxDecoration(
                  color: kCardColor,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // our product image
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Row(
                children: [
                  SizedBox(
                    width: kDefaultPadding / 2,
                  ),
                  Container(
                    height: 250,
                    width: 180,
                    child: LocalStorage().isArabicLanguage()
                        ? ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(22),
                              bottomRight: Radius.circular(22),
                              bottomLeft: Radius.circular(0),
                            ),
                            child: Image.network(
                              product.image,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(22),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(22),
                              bottomRight: Radius.circular(0),
                            ),
                            child: Image.network(
                              product.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: kDefaultPadding,
                          end: kDefaultPadding / 2,
                          bottom: kDefaultPadding * 2,
                          start: kDefaultPadding / 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomText(
                            text: product.name,
                            fontSize: 20,
                            maxLines: 2,
                            fontWeight: FontWeight.bold,
                            alignment: AlignmentDirectional.topEnd,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RatingBar.readOnly(
                                    initialRating: 3,
                                    isHalfAllowed: true,
                                    size: 20,
                                    halfFilledColor: Colors.amber,
                                    maxRating: 5,
                                    filledColor: Colors.amber,
                                    halfFilledIcon: Icons.star_half,
                                    filledIcon: Icons.star,
                                    emptyIcon: Icons.star_border,
                                  ),
                                  CustomText(
                                    text: '(210)',
                                  )
                                ],
                              ),
                              SizedBox(
                                height: kDefaultPadding / 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      onPressed: () {}),
                                  IconButton(
                                      icon: Icon(
                                        Icons.add_shopping_cart,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      onPressed: () {}),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // product discount value
            Visibility(
              visible: product.discountType == 'percent',
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(22),
                        topEnd: Radius.circular(0),
                        bottomStart: Radius.circular(0),
                        bottomEnd: Radius.circular(10),
                      ),
                      color: Colors.red),
                  child: Center(
                    child: CustomText(
                      text: '${product.discountValue}%',
                      fontSize: 20,
                      alignment: AlignmentDirectional.center,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            // // product actions
            // Align(
            //   alignment: AlignmentDirectional.centerEnd,
            //   child: Container(
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         IconButton(
            //             icon: Icon(
            //               Icons.favorite,
            //               color: Colors.red,
            //               size: 30,
            //             ),
            //             onPressed: () {}),
            //         IconButton(
            //             icon: Icon(
            //               Icons.add_shopping_cart,
            //               color: Colors.black,
            //               size: 30,
            //             ),
            //             onPressed: () {}),
            //       ],
            //     ),
            //   ),
            // ),
            // our price
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, // 30 padding
                  vertical: kDefaultPadding / 4, // 5 top and bottom
                ),
                decoration: BoxDecoration(
                  color: product.discountType == 'percent'
                      ? kSecondaryColor
                      : kBlueColor,
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(22),
                    topStart: Radius.circular(22),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      visible: product.discountType == 'percent',
                      child: Text(
                        '\$${product.price}',
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: product.discountType == 'percent',
                      child: SizedBox(
                        width: kDefaultPadding / 2,
                      ),
                    ),
                    Text(
                      '\$${product.discountPrice}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
