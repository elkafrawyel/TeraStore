import 'package:flutter/material.dart';
import 'package:flutter_app/view/custom_widgets/budget.dart';

class TestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: BudgetView(),
      ),
    );
  }
}
