import 'package:flutter/material.dart';

class ProductPoster extends StatelessWidget {
  ProductPoster({
    this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // height: MediaQuery.of(context).size.height / 3,
      // width: MediaQuery.of(context).size.width,
      // decoration: BoxDecoration(
      //   color: Colors.black,
      // ),
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        image,
        // height: MediaQuery.of(context).size.height / 3,
        // width: MediaQuery.of(context).size.width,
        fit: BoxFit.contain,
      ),
    );
  }
}
