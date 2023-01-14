import 'package:dio/dio.dart';
import 'package:lojateamodas/src/constants/endpoints/endpoints.dart';
import 'package:lojateamodas/src/models/adress/adress.dart';
import 'package:lojateamodas/src/models/cart/cart_item_model.dart';
import 'package:lojateamodas/src/models/order/order_model.dart';
import 'package:lojateamodas/src/pages/cart/result/cart_result.dart';
import 'package:lojateamodas/src/services/cep/cep_aberto.dart';
import 'package:lojateamodas/src/services/manager/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  final dio = Dio();

  Future<void> consultarCep(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final String url = 'https://viacep.com.br/ws/$cleanCep/json/';
    const address = Adress;

    Map<String, String> headers = {
      'content-type': 'application/json',
    };

    Map<String, dynamic> body = {
      "cep": "01001-000",
      "logradouro": "Praça da Sé",
      "complemento": "lado ímpar",
      "bairro": "Sé",
      "localidade": "São Paulo",
      "uf": "SP",
      "ibge": "3550308",
      "gia": "1004",
      "ddd": "11",
      "siafi": "7107"
    };

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );
      //   final adress = Adress.fromMap(response.data);
//
      //   response.data = Adress(
      //     bairro: response.data.bairro,
      //     cep: response.data.cep,
      //     ddd: response.data.ddd,
      //     cidade: response.data.cidade,
      //     complemento: response.data.complemento,
      //     estado: response.data.estado,
      //     rua: response.data.rua,
      //   );

      print(response.data);
    } on DioError {
      print('Erro na requisição');
    } catch (e) {
      print('Erro genérico');
    }
  }

  Future<void> getAddress(String cep) async {
    bool loading = true;

    final cepAbertoService = CepAbertoService();
    //final cepAbertoService = CepAbertoService();

    try {
      //final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);
      final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);

      loading = false;
    } catch (e) {
      loading = false;
      return Future.error('CEP Inválido');
    }
  }

  Future<CartResult<List<CartItemModel>>> getCartItems({
    required String token,
    required String userId,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getCartItems,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'user': userId,
      },
    );

    if (result['result'] != null) {
      //print(result['result']);
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();
      return CartResult<List<CartItemModel>>.success(data);
      //Tratar
    } else {
      //RETORNAR uma mensagem
      return CartResult.error(
          'Ocorreu um erro ao recuperar os produtos do carrinho');
      //  print('error');
    }
  }

  Future<CartResult<OrderModel>> checkoutCart({
    required String token,
    required double total,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.checkout,
      method: HttpMethods.post,
      body: {
        'total': total,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );
    if (result['result'] != null) {
      final order = OrderModel.fromJson(result['result']);

      return CartResult<OrderModel>.success(order);
    } else {
      return CartResult.error('Não foi possível realizar o pedido');
    }
  }

  Future<bool> changeItemQuantity({
    required String token,
    required String cartItemId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.changeItemQuantity,
      method: HttpMethods.post,
      body: {
        'cartItemId': cartItemId,
        'quantity': quantity,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );
    return result.isEmpty;
  }

  Future<CartResult<String>> addItemToCart({
    required String userId,
    required String token,
    required int quantity,
    required String productId,
  }) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.addItemToCart,
        method: HttpMethods.post,
        body: {
          'user': userId,
          'quantity': quantity,
          'productId': productId,
        },
        headers: {
          'X-Parse-Session-Token': token,
        });
    if (result['result'] != null) {
      //adicionamos ao carrinho
      return CartResult<String>.success(result['result']['id']);
    } else {
      //erro
      return CartResult.error(
          'Não foi passível adicionar o produto ao carrinho');
    }
  }
}
