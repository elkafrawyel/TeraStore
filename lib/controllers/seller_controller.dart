import 'package:get/get.dart';
import 'package:tera/a_repositories/product_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/data/models/user_model.dart';
import 'package:tera/data/responses/seller_info_response.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';

class SellerController extends MainController {
  UserModel userModel;
  SellerInformation sellerInformation;
  List<ProductModel> products = [];

  getSellerProducts() async {
    loading.value = true;
    products.clear();
    ProductRepo().getSellerProducts(
      userId: userModel.id.toString(),
      state: (dataResource) {
        if (dataResource is Success) {
          products.addAll((dataResource.data as List<ProductModel>));
          loading.value = false;
          update();
        } else if (dataResource is Failure) {
          CommonMethods().showSnackBar('error'.tr);
          loading.value = false;
          update();
        }
      },
    );
  }

  getSellerInformation() async {
    loading.value = true;
    ProductRepo().getSellerInformation(
      userId: userModel.id.toString(),
      state: (dataResource) {
        if (dataResource is Success) {
          sellerInformation = dataResource.data as SellerInformation;
          loading.value = false;
          update();
        } else if (dataResource is Failure) {
          CommonMethods().showSnackBar('error'.tr);
          loading.value = false;
          update();
        }
      },
    );
  }
}
