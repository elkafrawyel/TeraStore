import 'package:tera/a_repositories/product_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/helper/data_resource.dart';

class SearchController extends MainController {
  List<ProductModel> searchProducts = [];

  Future<void> search(String searchText) async {
    loading.value = true;
    update();
    searchProducts.clear();
    ProductRepo().getFilteredProducts(
      searchText,
      state: (dataResource) {
        if (dataResource is Success) {
          searchProducts.addAll(dataResource.data as List<ProductModel>);
          print('search  => ${searchProducts.length} items');
          loading.value = false;
          empty.value = searchProducts.isEmpty;
          update();
        } else if (dataResource is Failure) {
          print(dataResource.errorMessage);
          loading.value = false;
          error.value = true;
          update();
        }
      },
    );
  }
}
