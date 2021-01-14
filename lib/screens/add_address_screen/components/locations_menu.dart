import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/general_controller.dart';
import 'package:tera/data/responses/locations_response.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

class LocationsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
      init: GeneralController(),
      builder: (controller) => controller.loading.value
          ? CircularProgressIndicator()
          : Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Center(
                    child: DropdownButton<Location>(
                      iconDisabledColor: Colors.grey,
                      isExpanded: true,
                      iconSize: 40,
                      onChanged: (Location locationModel) {
                        controller.setLocation(locationModel);
                      },
                      value: controller.selectedLocation,
                      hint: Center(
                        child: CustomText(
                          text: 'المحافظة'.tr,
                          color: Colors.grey.shade500,
                          fontSize: 16,
                          alignment: AlignmentDirectional.center,
                        ),
                      ),
                      items: controller.locationsResponse.locations
                          .map<DropdownMenuItem<Location>>(
                            (model) => DropdownMenuItem<Location>(
                              value: model,
                              child: Center(
                                child: Text(
                                  model.governorate,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Center(
                    child: DropdownButton<City>(
                      iconDisabledColor: Colors.grey,
                      isExpanded: true,
                      iconSize: 40,
                      onChanged: (City cityModel) {
                        controller.setCity(cityModel);
                      },
                      value: controller.selectedCity,
                      hint: Center(
                        child: CustomText(
                          text: 'المدينة'.tr,
                          color: Colors.grey.shade500,
                          fontSize: 16,
                          alignment: AlignmentDirectional.center,
                        ),
                      ),
                      items: controller.cities
                          .map<DropdownMenuItem<City>>(
                            (model) => DropdownMenuItem<City>(
                              value: model,
                              child: Center(
                                child: Text(
                                  model.city,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
