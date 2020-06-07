import 'package:flutter/material.dart';
import 'package:hix/shared/shared.dart';
import 'package:intl/intl.dart';

class MoneyCard extends StatelessWidget {
  final double width;
  final bool isSelected;
  final int amount;
  final Function onTap;

  const MoneyCard({
    Key key,
    this.width,
    this.isSelected = false,
    this.amount = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? null,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: width,
        height: 64.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: isSelected ? primaryColorLight : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.transparent : Color(0xFFE4E4E4),
            width: 2.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'IDR',
              style: TextStyle(color: Colors.black54),
            ),

            Text(
              NumberFormat.currency(
                locale: 'id_ID',
                decimalDigits: 0,
                symbol: '',
              ).format(amount),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
