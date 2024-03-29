import 'package:get/get.dart';
import 'package:tera/a_repositories/product_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/data/responses/seller_info_response.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';

class ProfileController extends MainController {
  //will contain user data, edit profile, myProducts

  List<ProductModel> _products = [];

  SellerInformation myInformation;

  List<ProductModel> get products => _products;

  getMyProducts() async {
    loading.value = true;
    _products.clear();
    ProductRepo().getMyProducts(
      state: (dataResource) {
        if (dataResource is Success) {
          _products.addAll((dataResource.data as List<ProductModel>));
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
      userId: Get.find<MainController>().user.id.toString(),
      state: (dataResource) {
        if (dataResource is Success) {
          myInformation = dataResource.data as SellerInformation;
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

  delete(ProductModel productModel) {
    ProductRepo().deleteProduct(
      productModel.id.toString(),
      state: (dataResource) {
        if (dataResource is Success) {
          _products.remove(productModel);
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
