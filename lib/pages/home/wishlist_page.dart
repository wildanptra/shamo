import 'package:flutter/material.dart';
import 'package:shamo/theme.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Wishlist Page',
        style: primaryTextStyle,
      ),
    );
  }
}