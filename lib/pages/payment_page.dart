import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/providers/cart_provider.dart';
import 'package:shamo/providers/transaction_provider.dart';
import 'package:shamo/theme.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? va;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleCheckout() async {
      setState(() {
        isLoading = true;
      });

      if (await transactionProvider.checkout(
        authProvider.user.token!,
        cartProvider.carts,
        cartProvider.totalPrice(),
        va!,
      )) {
        cartProvider.carts = [];
        Navigator.pushNamedAndRemoveUntil(
            context, '/checkout-success', (route) => false);
      }

      setState(() {
        isLoading = false;
      });
    }

    AppBar header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Payment Details',
        ),
      );
    }

    Widget card() {
      return Container(
        width: double.infinity,
        height: 150,
        margin: EdgeInsets.all(defaultMargin),
        padding: EdgeInsets.all(defaultMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Payment',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Total Price',
              style: primaryTextStyle,
            ),
            Text('\$${cartProvider.totalPrice()}', style: priceTextStyle),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Column(
            children: [
              RadioListTile(
                toggleable: true,
                tileColor: backgroundColor6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                value: "bni",
                groupValue: va,
                onChanged: (value) {
                  setState(() {
                    va = value.toString();
                  });
                  print(value);
                },
                title: Row(
                  children: [
                    Image.network(
                      'https://seeklogo.com/images/B/bank-bni-logo-737EE0F32C-seeklogo.com.png',
                      width: 50,
                    ),
                  ],
                ),
                subtitle: const Text('Virtual Account'),
                secondary: Text('\$${cartProvider.totalPrice()}', style: purpleTextStyle),
              ),
              const SizedBox(
                height: 10,
              ),
              RadioListTile(
                toggleable: true,
                tileColor: backgroundColor6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                value: "bca",
                groupValue: va,
                onChanged: (value) {
                  setState(() {
                    va = value.toString();
                  });
                  print(value);
                },
                title: Row(
                  children: [
                    Image.network(
                      'https://seeklogo.com/images/B/bca-bank-logo-1E89320DC2-seeklogo.com.png',
                      width: 60,
                    ),
                  ],
                ),
                subtitle: const Text('Virtual Account'),
                secondary: Text('\$${cartProvider.totalPrice()}', style: purpleTextStyle),
              ),
              const SizedBox(
                height: 10,
              ),
              RadioListTile(
                toggleable: true,
                tileColor: backgroundColor6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                value: "mandiri",
                groupValue: va,
                onChanged: (value) {
                  setState(() {
                    va = value.toString();
                  });
                  print(value);
                },
                title: Row(
                  children: [
                    Image.network(
                      'https://seeklogo.com/images/B/bank_mandiri-logo-4F6233ABCC-seeklogo.com.png',
                      width: 60,
                    ),
                  ],
                ),
                subtitle: const Text('Virtual Account'),
                secondary: Text('\$${cartProvider.totalPrice()}', style: purpleTextStyle),
              ),
              const SizedBox(
                height: 10,
              ),
              RadioListTile(
                toggleable: true,
                tileColor: backgroundColor6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                value: "gopay",
                groupValue: va,
                onChanged: (value) {
                  setState(() {
                    va = value.toString();
                  });
                  print(value);
                },
                title: Row(
                  children: [
                    Image.network(
                      'https://seeklogo.com/images/G/gopay-logo-D27C1EBD0D-seeklogo.com.png',
                      width: 60,
                    ),
                  ],
                ),
                subtitle: const Text('E-Wallet'),
                secondary: Text('\$${cartProvider.totalPrice()}', style: purpleTextStyle),
              ),
            ],
          ),
      );
    }

    Widget paymentButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.all(defaultMargin),
        child: TextButton(
          onPressed: handleCheckout,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Pay Now',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: ListView(
        children: [
          card(),
          content(),
          paymentButton(),
        ],
      ),
    );
  }
}
