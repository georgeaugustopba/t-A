import 'package:lojateamodas/src/models/cart/cart_item_model.dart';
import 'package:lojateamodas/src/models/item/item_model.dart';
import 'package:lojateamodas/src/models/order/order_model.dart';
import 'package:lojateamodas/src/models/user/user_model.dart';

ItemModel apple = ItemModel(
  //category: [],
  description:
      'A melhor maçã da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  imgUrl: 'assets/fruits/apple.png',
  itemName: 'Maçã vermelha',
  price: 5.5,
  unit: 'kg',
  id: '1234567',
);

ItemModel grape = ItemModel(
  //category: [],
  imgUrl: 'assets/fruits/grape.png',
  itemName: 'Uva do Sul',
  price: 7.4,
  unit: 'kg',
  id: '1234567',
  description:
      'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel guava = ItemModel(
  //category: [],
  imgUrl: 'assets/fruits/guava.png',
  itemName: 'Goiaba verde',
  price: 11.5,
  unit: 'kg',
  id: '1234567',
  description:
      'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel kiwi = ItemModel(
  //category: [],
  imgUrl: 'assets/fruits/kiwi.png',
  itemName: 'Kiwi top',
  price: 2.5,
  unit: 'un',
  id: '1234567',
  description:
      'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel mango = ItemModel(
  //category: [],
  imgUrl: 'assets/fruits/mango.png',
  itemName: 'Manga do Norte',
  price: 2.5,
  unit: 'un',
  id: '1234567',
  description:
      'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel papaya = ItemModel(
  //category: [],
  imgUrl: 'assets/fruits/papaya.png',
  itemName: 'Mamão papaya',
  price: 8,
  id: '1234567',
  unit: 'kg',
  description:
      'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

// Lista de produtos
List<ItemModel> items = [
  apple,
  grape,
  guava,
  kiwi,
  mango,
  papaya,
];
List<String> categorias = [
  'Roupas Térmicas',
  'Outono/Inverno',
  'Blusas Segunda Pele',
  'Primavera Verão',
  'Calças Segunda Pele',
  'Conjuntos Térmico',
];

List<CartItemModel> cartItems = [
  CartItemModel(
    item: apple,
    quantity: 1,
    id: '',
  ),
  CartItemModel(
    item: grape,
    quantity: 3,
    id: '',
  ),
  CartItemModel(
    item: kiwi,
    quantity: 4,
    id: '',
  ),
];

UserModel user = UserModel(
  name: 'George Augusto ',
  email: ' george@gmail.com',
  phone: '48 9 8828-3942',
  cpf: '040.079.751-83',
  password: '123456',
);

List<OrderModel> orders = [
  //pedido 1
  OrderModel(
    qrCodeImage:
        'data:image/png;base64,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',
    id: '54321',
    createDateTime: DateTime.parse(
      '2023-11-03 11:34:10.565',
    ),
    items: [
      CartItemModel(
        id: '',
        item: apple,
        quantity: 2,
      ),
    ],
    overdueDateTime: DateTime.parse(
      '2023-06-08 11:34:10.456',
    ),
    status: 'pending_payment',
    coyAndPaste: '54321',
    total: 0,
  ),

  //pedido 2
  OrderModel(
    qrCodeImage:
        'data:image/png;base64,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',
    id: '123456',
    createDateTime: DateTime.parse('2023-11-03 11:34:10.565'),
    items: [
      CartItemModel(
        id: '',
        item: kiwi,
        quantity: 3,
      ),
      CartItemModel(
        id: '',
        item: papaya,
        quantity: 3,
      ),
    ],
    overdueDateTime: DateTime.parse('2023-11-02 11:34:10.456'),
    status: 'delivered',
    coyAndPaste: '123456',
    total: 0,
  ),
];
