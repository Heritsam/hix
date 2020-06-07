import 'package:flutter/material.dart';
import 'package:hix/models/model.dart';
import 'package:hix/shared/shared.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final AppTransaction transaction;
  final double width;

  const TransactionCard({Key key, @required this.transaction, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: 70.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[300],
                  ),
                ),
                Container(
                  width: 70.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: transaction.picture != null
                          ? NetworkImage(
                              imageBaseURL + 'w500' + transaction.picture,
                            )
                          : AssetImage('assets/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.0),
            SizedBox(
              width: MediaQuery.of(context).size.width -
                  2 * defaultMargin -
                  70 -
                  16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transaction.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: 'id_ID',
                      symbol: 'IDR ',
                      decimalDigits: 0,
                    ).format(
                      transaction.total < 0
                          ? -transaction.total
                          : transaction.total,
                    ),
                    style: TextStyle(
                      color: transaction.total > 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    transaction.subtitle,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
