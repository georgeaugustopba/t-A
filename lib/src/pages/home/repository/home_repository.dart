import 'package:lojateamodas/src/constants/endpoints/endpoints.dart';
import 'package:lojateamodas/src/models/category/category_model.dart';
import 'package:lojateamodas/src/models/item/item_model.dart';
import 'package:lojateamodas/src/pages/home/result/home_result.dart';
import 'package:lojateamodas/src/services/manager/http_manager.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllCategories,
      method: HttpMethods.post,
    );
    if (result['result'] != null) {
      //ista
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();
      return HomeResult<CategoryModel>.success(data);
    } else {
      //Erro
      return HomeResult.error(
        "Ocorreu um erro ao recuperar as categorias",
      );
    }
  }

  Future<HomeResult<ItemModel>> getAllProducts(
      Map<String, dynamic> body) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllProducts,
      method: HttpMethods.post,
      body: body,
    );
    if (result['result'] != null) {
      List<ItemModel> data = (List<Map<String, dynamic>>.from(result['result']))
          .map(ItemModel.fromJson)
          .toList();
      return HomeResult<ItemModel>.success(data);
    } else {
      return HomeResult.error('ocorreu um erro ao recuperar os items');
    }
  }
}
