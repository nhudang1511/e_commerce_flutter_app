import 'package:equatable/equatable.dart';
import 'models.dart';

class Cart extends Equatable{

  final List<Product> products;
  const Cart({this.products = const <Product>[]});

  double get subtotal => products.fold(0, (total, current) => total + current.price);
  double deliveryFee(subtotal){
    if(subtotal >= 30.0){
      return 0.0;
    }
    else{
      return 10.0;
    }
  }

  Map productQuantity(products){
    var quantity = Map();
    products.forEach((element) {
      if(!quantity.containsKey(element)){
        quantity[element] = 1;
      }
      else{
        quantity[element] += 1;
      }
    });
    return quantity;
  }

  double total(subtotal, deliveryFee){
    return subtotal + deliveryFee(subtotal);
  }

  String feeDelivery(subtotal){
    if(subtotal >= 30.0){
      return 'You have Free Delivery';
    }
    else{
      double missing = 30.0 - subtotal;
      return 'Add \$${missing.toStringAsFixed(2)} for FREE DELIVERY';
    }
  }

  String get subtotalString => subtotal.toStringAsFixed(2);
  String get deliveryFeeString => deliveryFee(subtotal).toStringAsFixed(2);
  String get feeDeliveryString => feeDelivery(subtotal);
  String get totalString => total(subtotal, deliveryFee).toStringAsFixed(2);

  @override
  List<Object?> get props => [products];
}