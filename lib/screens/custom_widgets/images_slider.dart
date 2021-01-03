import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/image_model.dart';

class ImagesSliders extends StatelessWidget {
  final List<ImageModel> images;

  ImagesSliders({this.images});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        scrollDirection: Axis.horizontal,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        autoPlayInterval: Duration(seconds: 10),
      ),
      items: images
          .map(
            (item) => Container(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      placeholder: placeholder,
                      image: item.url),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
