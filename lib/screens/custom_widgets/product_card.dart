import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    this.onFavouriteClicked,
    this.onCartClicked,
  }) : super(key: key);

  final int itemIndex;
  final ProductModel product;
  final Function press;
  final Function onFavouriteClicked;
  final Function onCartClicked;
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
      height: 200,
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
                    height: 200,
                    width: 150,
                    child: LocalStorage().isArabicLanguage()
                        ? ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(22),
                              bottomRight: Radius.circular(22),
                              bottomLeft: Radius.circular(0),
                            ),
                            child: FadeInImage.assetNetwork(
                              image: product.image,
                              placeholder: placeholder,
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
                            child: FadeInImage.assetNetwork(
                              image: product.image,
                              placeholder: placeholder,
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
                            fontSize: fontSizeBig_18,
                            maxLines: 1,
                            fontWeight: FontWeight.bold,
                            alignment: AlignmentDirectional.topEnd,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RatingBar.readOnly(
                                    initialRating:
                                        double.parse(product.rate.toString()),
                                    isHalfAllowed: true,
                                    size: 16,
                                    halfFilledColor: Colors.amber,
                                    maxRating: 5,
                                    filledColor: Colors.amber,
                                    halfFilledIcon: Icons.star_half,
                                    filledIcon: Icons.star,
                                    emptyIcon: Icons.star_border,
                                  ),
                                  CustomText(
                                    text:
                                        '(${product.commentCount.toString()})',
                                    fontSize: fontSizeSmall_16 - 4,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: kDefaultPadding / 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  product.isFav
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            onFavouriteClicked.call();
                                          })
                                      : IconButton(
                                          icon: Icon(
                                            Icons.favorite,
                                            color: Colors.grey,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            onFavouriteClicked.call();
                                          }),
                                  !product.inCart
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.add_shopping_cart_rounded,
                                            color: Colors.grey,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            onCartClicked.call();
                                          })
                                      : IconButton(
                                          icon: Icon(
                                            Icons.shopping_cart_outlined,
                                            color: Colors.green,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            onCartClicked.call();
                                          }),
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
                  width: 50,
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
                      fontSize: fontSizeSmall_16 - 2,
                      alignment: AlignmentDirectional.center,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${product.discountPrice} ' + 'currency'.tr,
                      style: TextStyle(
                        fontSize: fontSizeSmall_16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Visibility(
                      visible: product.discountType == 'percent',
                      child: SizedBox(
                        width: kDefaultPadding / 2,
                      ),
                    ),
                    Visibility(
                      visible: product.discountType == 'percent',
                      child: Text(
                        '${product.price} ' + 'currency'.tr,
                        style: TextStyle(
                            fontSize: fontSizeSmall_16 - 2,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.black,
                            decorationColor: Colors.red,
                            decorationThickness: 30.0,
                            decorationStyle: TextDecorationStyle.solid),
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
