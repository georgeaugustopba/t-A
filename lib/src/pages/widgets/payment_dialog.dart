import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:lojateamodas/src/models/order/order_model.dart';
import 'package:lojateamodas/src/services/utils/utils_services.dart';

class PaymentDialog extends StatelessWidget {
  final OrderModel? order;
  PaymentDialog({Key? key, required this.order}) : super(key: key);

  final UtilsServices utilsServices = UtilsServices();
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            //conteúdo
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //titulo
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Text(
                      'Pagamento com Pix',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  // QR Code
                  Image.memory(
                    utilsServices.decodeQrCodeImage(order!.qrCodeImage),
                    height: 200,
                    width: 200,
                  ),

                  //Vencimento
                  Text(
                    'Vencimento: ${utilsServices.formatDateTime(order!.overdueDateTime)}',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),

                  //total
                  Text(
                    'Total: ${utilsServices.priceToCurrency(order!.total)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  //BOTAO copia e cola
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: const BorderSide(
                        width: 2,
                        color: Colors.pink,
                      ),
                    ),
                    onPressed: () {
                      FlutterClipboard.copy(
                        order!.coyAndPaste,
                      );
                      utilsServices.showToast(
                        message: 'Código Copiado',
                      );
                    },
                    icon: const Icon(
                      Icons.copy,
                      size: 15,
                    ),
                    label: const Text(
                      'Copiar código Pix',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  )
                ],
              ),
            ),

            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ));
  }
}
