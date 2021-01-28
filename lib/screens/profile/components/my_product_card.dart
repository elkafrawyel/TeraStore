import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/profile_controller.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';
import 'package:tera/screens/edit_product_screen.dart';

class MyProductCard extends StatelessWidget {
  const MyProductCard({
    Key key,
    this.itemIndex,
    this.product,
    this.press,
  }) : super(key: key);

  final int itemIndex;
  final ProductModel product;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding / 2,
        vertical: kDefaultPadding / 2,
      ),
      // color: Colors.blueAccent,
      height: 150,
      child: GestureDetector(
        onTap: press,
        child: Stack(
          children: <Widget>[
            // Those are our background
            Container(
              height: 150,
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
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Row(
                children: [
                  SizedBox(
                    width: kDefaultPadding / 1.5,
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
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
                          end: kDefaultPadding,
                          start: kDefaultPadding / 2),
                      child: CustomText(
                        text: product.name,
                        fontSize: fontSizeSmall_16 - 2,
                        maxLines: 2,
                        alignment: AlignmentDirectional.topStart,
                      ),
                    ),
                  ),
                  _buildActions()
                ],
              ),
            ),
            // our price
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 4,
                ),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(22),
                    topStart: Radius.circular(22),
                  ),
                ),
                child: Text(
                  "\$${product.discountPrice}",
                  style: TextStyle(
                    fontSize: fontSizeSmall_16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildActions() {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            edit(product);
          },
          icon: Icon(
            Icons.edit,
            size: 30,
          ),
          color: Colors.grey,
        ),
        IconButton(
          onPressed: () {
            delete();
          },
          icon: Icon(
            Icons.delete,
            size: 30,
          ),
          color: Colors.red,
        ),
      ],
    );
  }

  delete() {
    CommonMethods().customAlert(
        message: 'deleteMessage'.tr,
        title: 'delete'.tr,
        action: () {
          Get.find<ProfileController>().delete(product);
        });
  }

  edit(ProductModel product) {
    Get.to(EditProductScreen(
      productModel: product,
    ));
  }
}
