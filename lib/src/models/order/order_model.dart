import 'package:json_annotation/json_annotation.dart';

import 'package:lojateamodas/src/models/cart/cart_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  String id;

  @JsonKey(name: 'createdAt')
  DateTime? createDateTime;

  @JsonKey(name: 'due')
  DateTime overdueDateTime;

  @JsonKey(defaultValue: [])
  List<CartItemModel> items;

  String qrCodeImage;

  String? status;

  @JsonKey(name: 'copiaecola')
  String coyAndPaste;

  double total;
  bool get isOverDue => overdueDateTime.isBefore(DateTime.now());

  OrderModel({
    required this.id,
    this.createDateTime,
    required this.overdueDateTime,
    required this.items,
    required this.qrCodeImage,
    this.status,
    required this.coyAndPaste,
    required this.total,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  @override
  String toString() {
    return 'OrderModel(id: $id, createDateTime: $createDateTime, overdueDateTime: $overdueDateTime, items: $items, qrCodeImage: $qrCodeImage, status: $status, coyAndPaste: $coyAndPaste, total: $total)';
  }
}
