import 'dart:io';

import 'package:e_commerce/models/payment_menthod_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/payment/payment_bloc.dart';
import '../../widget/widgets.dart';
import 'package:pay/pay.dart';

class PaymentScreen extends StatelessWidget {
  static const String routeName = '/payment';

  const PaymentScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const PaymentScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Payment'),
        bottomNavigationBar: const CustomeNavBar(),
        body: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            if(state is PaymentLoading){
              return const CircularProgressIndicator();
            }
            if(state is PaymentLoaded){
              return ListView(
                children: [
                  Platform.isIOS ? RawApplePayButton(
                    onPressed: () {
                      context.read<PaymentBloc>().add(
                        SelectPaymentMethod(paymentMethod: PaymentMethod.apple_pay)
                      );
                      Navigator.pop(context);
                    },
                    type: ApplePayButtonType.inStore,
                    style: ApplePayButtonStyle.black,
                  ) : const SizedBox(),
                  const SizedBox(height: 10),
                  Platform.isAndroid ?
                  RawGooglePayButton(
                    type: GooglePayButtonType.pay,
                    onPressed: () {
                      context.read<PaymentBloc>().add(
                          SelectPaymentMethod(paymentMethod: PaymentMethod.google_pay)
                      );
                      Navigator.pop(context);
                    },
                  ) : const SizedBox(),
                  ElevatedButton(
                      onPressed: (){
                        context.read<PaymentBloc>().add(
                            SelectPaymentMethod(paymentMethod: PaymentMethod.credit_card));
                        Navigator.pop(context);
                      },
                      child: const Text('Pay with Credit Card'))
                ],
              );
            }
            else{
              return const Text('Something went wrong');
            }
          },
        )
    );
  }
}


