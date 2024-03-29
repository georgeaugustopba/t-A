import 'package:get/get.dart';
import 'package:lojateamodas/src/models/category/category_model.dart';
import 'package:lojateamodas/src/models/item/item_model.dart';
import 'package:lojateamodas/src/pages/home/repository/home_repository.dart';
import 'package:lojateamodas/src/pages/home/result/home_result.dart';
import 'package:lojateamodas/src/services/utils/utils_services.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final homeRepository = HomeRepository();

  final utilsServices = UtilsServices();
  bool isCategoryLoading = false;
  bool isProductLoading = true;

  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;

  List<ItemModel> get allProducts => currentCategory?.items ?? [];

  RxString searchTitle = ''.obs;

  //método listar os produtos por pagina
  bool get isLatPage {
    if (currentCategory!.items.length < itemsPerPage) return true;
    return currentCategory!.pagination * itemsPerPage > allProducts.length;
  }

  void setLoading(bool value, {bool isProduct = false}) {
    if (!isProduct) {
      isCategoryLoading = value;
    } else {
      isProductLoading = value;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();

    debounce(
      searchTitle,
      (_) {
        filterByTitle();
      },
      time: const Duration(milliseconds: 600),
    );

    getAllCategories();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;

    update();

    if (currentCategory!.items.isNotEmpty) return;

    getAllProducts();
  }

  Future<void> getAllCategories() async {
    setLoading(true);

    HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();

    setLoading(false);

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);

        if (allCategories.isEmpty) return;

        //adicionando a categoria todos, mostrando todos os produtos

        final allProductsCategory = CategoryModel(
          title: 'Todos Produtos',
          id: '',
          items: [],
          pagination: 0,
        );

        allCategories.insert(0, allProductsCategory);

        selectCategory(allCategories.first);

        //print("todas as cat $allCategories");
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
        //print(message);
      },
    );
  }

  void filterByTitle() {
    for (var category in allCategories) {
      category.items.clear();
      category.pagination = 0;
    }

    // if (searchTitle.value.isEmpty) {
    //   allCategories.removeAt(0);
    // } else {
    //   CategoryModel? c = allCategories.firstWhereOrNull((cat) => cat.id == '');
    //   if (c == null) {
    //     //Criar uma nova categoria com todos todos produtos
    //     final allProductCategory = CategoryModel(
    //       id: '',
    //       title: 'Todos',
    //       items: [],
    //       pagination: 0,
    //     );
    //     allCategories.insert(0, allProductCategory);
    //   } else {
    //     c.items.clear();
    //     c.pagination = 0;
    //   }
    // }
    currentCategory = allCategories.first;
    update();
    getAllProducts();
  }

  void loadMoreProducts() {
    currentCategory!.pagination++;

    getAllProducts(canLoad: false);
  }

  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isProduct: true);
    }

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'itemsPerPage': itemsPerPage,
      'categoryId': currentCategory!.id,
    };
    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;
    }

    if (currentCategory!.id == '') {
      body.remove('categoryId');
    }

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);
    setLoading(false, isProduct: true);

    result.when(
      success: (data) {
        currentCategory!.items.addAll(data);
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
        // print(message);
      },
    );
  }
}
