// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Adress _$AdressFromJson(Map<String, dynamic> json) => Adress(
      rua: json['rua'] as String,
      ddd: json['ddd'] as String,
      bairro: json['bairro'] as String,
      cep: json['cep'] as String,
      cidade: json['cidade'] as String,
      estado: json['estado'] as String,
      complemento: json['complemento'] as String,
    );

Map<String, dynamic> _$AdressToJson(Adress instance) => <String, dynamic>{
      'rua': instance.rua,
      'ddd': instance.ddd,
      'bairro': instance.bairro,
      'complemento': instance.complemento,
      'cep': instance.cep,
      'cidade': instance.cidade,
      'estado': instance.estado,
    };
