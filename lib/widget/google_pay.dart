import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import '../models/models.dart';

class GooglePay extends StatelessWidget {
  const GooglePay({super.key,
    required this.total,
    required this.products});

  final String total;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    var _paymentItems = products
        .map((e) => PaymentItem(
      amount: e.price.toString(),
      label: e.name,
      type: PaymentItemType.item,
      status: PaymentItemStatus.final_price
    )).toList();
    _paymentItems.add(
      PaymentItem(
          amount: total,
          label: "Total",
          type: PaymentItemType.item,
          status: PaymentItemStatus.final_price)
    );
    void onGooglePayResult(paymentResult){
      debugPrint(paymentResult.toString());
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: GooglePayButton(
        onPaymentResult: onGooglePayResult,
        paymentItems: _paymentItems,
        paymentConfigurationAsset: 'default_google_pay_config.json',
        type: GooglePayButtonType.pay,
        margin: const EdgeInsets.only(top: 10),
        loadingIndicator: const CircularProgressIndicator(),
      ),
    );
  }
}
