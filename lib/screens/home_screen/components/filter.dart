import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

class FilterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          CustomText(
            text: 'sortBy'.tr,
            alignment: AlignmentDirectional.center,
            fontSize: fontSizeSmall_16,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
                end: kDefaultPadding * 2, start: kDefaultPadding * 2),
            child: Divider(
              thickness: 2,
              color: Colors.grey,
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Latest Radio
                  Row(
                    children: [
                      Radio<ProductFilters>(
                        value: ProductFilters.Latest,
                        groupValue: controller.filter,
                        onChanged: (value) {
                          controller.filter = value;
                          controller.update();
                        },
                      ),
                      Text(
                        ProductFilters.Latest.text,
                        style: TextStyle(fontSize: fontSizeSmall_16 - 2),
                      ),
                    ],
                  ),
                  //High Rate Radio

                  Padding(
                    padding:
                        const EdgeInsetsDirectional.only(end: kDefaultPadding),
                    child: Row(
                      children: [
                        Radio(
                          value: ProductFilters.HighRate,
                          groupValue: controller.filter,
                          onChanged: (value) {
                            controller.filter = value;
                            controller.update();
                          },
                        ),
                        Text(
                          ProductFilters.HighRate.text,
                          style: TextStyle(fontSize: fontSizeSmall_16 - 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //High Price Radio

                  Row(
                    children: [
                      Radio(
                        value: ProductFilters.HighPrice,
                        groupValue: controller.filter,
                        onChanged: (value) {
                          controller.filter = value;
                          controller.update();
                        },
                      ),
                      Text(
                        ProductFilters.HighPrice.text,
                        style: TextStyle(fontSize: fontSizeSmall_16 - 2),
                      ),
                    ],
                  ),
                  //Low Price Radio
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        end: kDefaultPadding + 8),
                    child: Row(
                      children: [
                        Radio(
                          value: ProductFilters.LowPrice,
                          groupValue: controller.filter,
                          onChanged: (value) {
                            controller.filter = value;
                            controller.update();
                          },
                        ),
                        Text(
                          ProductFilters.LowPrice.text,
                          style: TextStyle(fontSize: fontSizeSmall_16 - 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //Price Radio
              Column(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: ProductFilters.Range,
                        groupValue: controller.filter,
                        onChanged: (value) {
                          controller.filter = value;
                          controller.update();
                        },
                      ),
                      Text(
                        ProductFilters.Range.text,
                        style: TextStyle(fontSize: fontSizeSmall_16 - 2),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: kDefaultPadding, end: kDefaultPadding),
                    child: Column(
                      children: [
                        FlutterSlider(
                          values: [
                            controller.lowerValue,
                            controller.upperValue
                          ],
                          disabled: controller.filter != ProductFilters.Range,
                          trackBar: FlutterSliderTrackBar(
                            inactiveTrackBar: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black12,
                              border: Border.all(width: 3, color: Colors.blue),
                            ),
                            activeTrackBar: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.blue.withOpacity(0.5)),
                          ),
                          max: 20000,
                          min: 0,
                          selectByTap: true,
                          rtl: LocalStorage().isArabicLanguage(),
                          rangeSlider: true,
                          tooltip: FlutterSliderTooltip(
                            textStyle: TextStyle(
                                fontSize: 30,
                                color: LocalStorage().primaryColor()),
                          ),
                          handlerAnimation: FlutterSliderHandlerAnimation(
                              curve: Curves.elasticOut,
                              duration: Duration(milliseconds: 700),
                              scale: 1.4),
                          onDragging: (handlerIndex, lowerValue, upperValue) {
                            controller.lowerValue = lowerValue;
                            controller.upperValue = upperValue;
                            controller.update();
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'from'.tr +
                                  ' : ${controller.lowerValue.toString()}',
                              fontSize: fontSizeSmall_16 - 2,
                            ),
                            CustomText(
                              text: 'to'.tr +
                                  ' : ${controller.upperValue.toString()}',
                              fontSize: fontSizeSmall_16 - 2,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
              controller.filterProducts();
              CommonMethods()
                  .showSnackBar('${'sortBy'.tr} ${controller.filter.text}');
            },
            child: Container(
                width: MediaQuery.of(context).size.width / 2,
                padding: EdgeInsets.only(
                    top: kDefaultPadding, bottom: kDefaultPadding),
                decoration: BoxDecoration(
                  color: LocalStorage().primaryColor(),
                  borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                ),
                child: CustomText(
                  text: "ok".tr,
                  fontSize: fontSizeBig_18,
                  color: Colors.white,
                  alignment: AlignmentDirectional.center,
                )),
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
        ],
      ),
    );
  }
}
