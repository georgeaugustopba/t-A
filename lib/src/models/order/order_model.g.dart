// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String,
      createDateTime: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      overdueDateTime: DateTime.parse(json['due'] as String),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      qrCodeImage: json['qrCodeImage'] as String,
      status: json['status'] as String?,
      coyAndPaste: json['copiaecola'] as String,
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createDateTime?.toIso8601String(),
      'due': instance.overdueDateTime.toIso8601String(),
      'items': instance.items,
      'qrCodeImage': instance.qrCodeImage,
      'status': instance.status,
      'copiaecola': instance.coyAndPaste,
      'total': instance.total,
    };
