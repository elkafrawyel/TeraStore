import 'package:flutter/material.dart';
import 'package:flutter_app/core/view_model/explore_view_model.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/view/add_product_screen.dart';
import 'package:flutter_app/view/custom_widgets/card/products_card.dart';
import 'package:flutter_app/view/custom_widgets/custom_appbar.dart';
import 'package:flutter_app/view/custom_widgets/data_state_views/loading_view.dart';
import 'package:flutter_app/view/custom_widgets/directional_widget.dart';
import 'package:flutter_app/view/custom_widgets/images_slider.dart';
import 'package:flutter_app/view/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/view/sub_category_screen.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ExploreScreen extends StatelessWidget {
  ExploreViewModel _exploreViewModel;
  @override
  Widget build(BuildContext context) {
    _exploreViewModel = Get.put(ExploreViewModel());
    return DirectionalWidget(
      pageUi: GetBuilder<ExploreViewModel>(
        builder: (controller) => Scaffold(
          appBar: CustomAppBar(
            text: 'home'.tr,
            actions: [
              GestureDetector(
                onTap: (){
                  Get.to(AddProductScreen());
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 20),
                child: Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
              child: controller.loading.value
                  ? LoadingView()
                  : Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ImagesSliders(
                            images: Get.find<ExploreViewModel>().images,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 10),
                            child: CustomText(
                              alignment: AlignmentDirectional.centerStart,
                              text: 'categories'.tr,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _listViewCategories(),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(start: 10),
                                child: CustomText(
                                  text: 'bestSelling'.tr,
                                  fontSize: 18,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: CustomText(
                                  text: 'seeAll'.tr,
                                  color: primaryColor,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _listViewProducts(),
                        ],
                      ),
                    )),
        ),
      ),
    );
  }

  Widget _listViewCategories() {
    return Container(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Get.find<ExploreViewModel>().categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(SubCategoryScreen(
                categoryModel: Get.find<ExploreViewModel>().categories[index],
              ));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Card(
                child: Column(
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.height * 0.5,
                          height: 150,
                          placeholder: placeholder,
                          image: Get.find<ExploreViewModel>()
                              .categories[index]
                              .image,
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomText(
                        text: Get.find<ExploreViewModel>()
                            .categories[index]
                            .displayName,
                        fontSize: 14,
                        alignment: AlignmentDirectional.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _listViewProducts() {
    return GetBuilder<ExploreViewModel>(
      builder: (controller) => Container(
        height: 300,
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            width: 5,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            return ProductsCard(
              product: controller.products[index],
            );
          },
        ),
      ),
    );
  }
}
