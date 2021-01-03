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
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      // color: Colors.blueAccent,
      height: 200,
      child: GestureDetector(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            // Those are our background
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: itemIndex.isEven ? kBlueColor : primaryColor,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: kDefaultPadding / 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // our product image
            Positioned.fill(
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      width: 200,
                      child: Image.network(
                        product.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                            end: kDefaultPadding / 2, top: kDefaultPadding * 2),
                        child: CustomText(
                          text: product.name,
                          fontSize: 18,
                          alignment: AlignmentDirectional.topStart,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Container(
                  padding: EdgeInsetsDirectional.only(
                      start: kDefaultPadding,
                      end: kDefaultPadding,
                      top: kDefaultPadding / 2,
                      bottom: kDefaultPadding / 2),
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                  ),
                  child: Text(
                    "\$${product.price}",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
