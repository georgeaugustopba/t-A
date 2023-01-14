import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lojateamodas/src/services/cep/cep_aberto_adress.dart';

const token = 'ca1eb27560d0e21c382aa09c101121a5';

class CepAbertoService {
  Future<CepAbertoAddress> getAddressFromCep(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final endpoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";

    final Dio dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try {
      final response = await dio.get<Map<String, dynamic>>(endpoint);

      if (response.data!.isEmpty) {
        return Future.error('CEP Inválido');
      }

      final CepAbertoAddress address = CepAbertoAddress.fromMap(response.data!);

      return address;
      print(address);
    } on DioError {
      return Future.error('Erro ao buscar CEP');
    }
  }
}
