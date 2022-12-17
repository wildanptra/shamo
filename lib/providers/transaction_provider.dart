import 'package:flutter/material.dart';
import 'package:shamo/models/cart_model.dart';
import 'package:shamo/models/midtrans_model.dart';
import 'package:shamo/services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  late MidtransModel _midtrans;

  MidtransModel get midtrans => _midtrans;

  set midtrans(MidtransModel midtrans) {
    _midtrans = midtrans;
    notifyListeners();
  }

  Future<bool> checkout(
    String token,
    List<CartModel> carts,
    double totalPrice,
    String va,
  ) async {
    try {
      MidtransModel midtrans = await TransactionService()
          .checkout(token: token, carts: carts, totalPrice: totalPrice, va: va);

      _midtrans = midtrans;

      return true;
    } catch (e) {
      print(e);

      return false;
    }
  }
}
