import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'adress.g.dart';

@JsonSerializable()
class Adress {
  String rua;
  String ddd;
  String bairro;
  String complemento;
  String cep;
  String cidade;
  String estado;

  Adress({
    required this.rua,
    required this.ddd,
    required this.bairro,
    required this.cep,
    required this.cidade,
    required this.estado,
    required this.complemento,
  });

  factory Adress.fromMap(Map<String, dynamic> map) {
    return Adress(
      rua: map['logradouro'] as String,
      ddd: map['ddd'] as String,
      bairro: map['bairro'] as String,
      cep: map['cep'] as String,
      cidade: map['localidade'] as String,
      estado: map['uf'] as String,
      complemento: map['complemento'] as String,
    );
  }

  factory Adress.fromJson(String source) => Adress.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Adress(complemento: $complemento, logradouro: $rua, ddd: $ddd, bairro: $bairro, cep: $cep, localidade: $cidade, uf: $estado)';
  }
}
