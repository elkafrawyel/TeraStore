import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';

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
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      // color: Colors.blueAccent,
      height: 160,
      child: GestureDetector(
        onTap: press,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: 136,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: itemIndex.isEven ? kBlueColor : kSecondaryColor,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsetsDirectional.only(start: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // our product image
            PositionedDirectional(
              top: 0,
              start: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 160,
                // image is square but we add extra 20 + 20 padding thats why width is 200
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            // Product title and price
            PositionedDirectional(
              bottom: 0,
              end: 0,
              child: SizedBox(
                height: 136,
                // our image take 200 width, thats why we set out total width - 200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Container(
                        width: size.width - 230,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding / 4),
                          child: CustomText(
                            text: product.name,
                            fontSize: 14,
                            maxLines: 4,
                            alignment: AlignmentDirectional.center,
                          ),
                        ),
                      ),
                    ),
                    // it use the available space
                    Spacer(),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 1.5, // 30 padding
                          vertical: kDefaultPadding / 4, // 5 top and bottom
                        ),
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(22),
                            topStart: Radius.circular(22),
                          ),
                        ),
                        child: Text(
                          "\$${product.price}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
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
