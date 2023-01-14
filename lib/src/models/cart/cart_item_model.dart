import 'package:json_annotation/json_annotation.dart';

import 'package:lojateamodas/src/models/item/item_model.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {
  @JsonKey(name: 'product')
  ItemModel item;
  int quantity;
  String id;

  CartItemModel({
    required this.item,
    required this.quantity,
    required this.id,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);

  double totalPrice() => item.price * quantity;

  @override
  String toString() =>
      'CartItemModel(item: $item, quantity: $quantity, id: $id)';
}