import 'package:flutter/material.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';

class ShippingAddresses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CustomText(text: 'empty',
        alignment: AlignmentDirectional.center,),
      ),
    );
  }
}
