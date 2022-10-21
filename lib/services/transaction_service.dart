import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shamo/models/cart_model.dart';
import 'package:shamo/models/midtrans_model.dart';
import 'package:shamo/models/user_model.dart';

class TransactionService {
  String baseUrl = 'https://shamo-backend.buildwithangga.id/api';
  String payType = '';

  Future<MidtransModel> checkout({
    required String token,
    required List<CartModel> carts,
    required double totalPrice,
    required String va,
  }) async {
    var url = '$baseUrl/checkout';

    var urlMidtrans = 'https://api.sandbox.midtrans.com/v2/charge';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var headersMidtrans = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Basic U0ItTWlkLXNlcnZlci03ZXA3V1lKSVFDWVV2OUJtV1p1VDJlS246',
    };

    var body = jsonEncode(
      {
        'address': 'Marsemoon',
        'items': carts
            .map(
              (cart) => {
                'id': cart.product.id,
                'quantity': cart.quantity,
              },
            )
            .toList(),
        'status': 'PENDING',
        'total_price': totalPrice,
        'shipping_price': 0,
      },
    );

    if (va == 'mandiri') {
      payType = 'echannel';
      va = 'bni';
    } else if (va == 'gopay') {
      payType = 'gopay';
      va = 'bni';
    } else {
      payType = 'bank_transfer';
    }

    print(payType);

    var bodyMidtrans = jsonEncode({
      'payment_type': payType,
      'bank_transfer': {'bank': va},
      'gopay': {'enable_callback': true, 'callback_url': 'someapps://callback'},
      'echannel': {'bill_info1': 'Payment For:', 'bill_info2': 'Other'},
      'transaction_details': {
        'order_id': 'order-102-101' + DateTime.now().toString(),
        'gross_amount': totalPrice
      },
      'customer_details': {
        'email': 'test@Midtrans.com',
        "first_name": "budi",
        "last_name": "utomo",
        'phone': '+628112341234'
      },
      'item_details': carts
          .map(
            (cart) => {
              'id': cart.product.id,
              'price': cart.product.price,
              'quantity': cart.quantity,
              'name': cart.product.name,
            },
          )
          .toList(),
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    var responseMidtrans = await http.post(
      Uri.parse(urlMidtrans),
      headers: headersMidtrans,
      body: bodyMidtrans,
    );

    print(response.body);
    print(responseMidtrans.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(responseMidtrans.body);
      MidtransModel midtrans = MidtransModel.fromJson(data);

      return midtrans;
    } else {
      throw Exception('Gagal melakukan checkout');
    }
  }
}
