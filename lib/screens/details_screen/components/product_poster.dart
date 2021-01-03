import 'package:flutter/material.dart';
import 'package:flutter_app/helper/Constant.dart';

class ProductPoster extends StatelessWidget {
  ProductPoster({
    this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: FadeInImage.assetNetwork(
        height: MediaQuery.of(context).size.height/3,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.contain,
        placeholder: placeholder,
        image: image,
      ),
    );
  }
}
