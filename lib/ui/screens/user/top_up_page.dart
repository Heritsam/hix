import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:hix/blocs/bloc.dart';
import 'package:hix/extensions/extension.dart';
import 'package:hix/models/model.dart';
import 'package:hix/shared/shared.dart';
import 'package:hix/ui/screens/screen.dart';
import 'package:hix/ui/widgets/money_card.dart';
import 'package:hix/ui/widgets/widget.dart';

class TopUpPage extends StatefulWidget {
  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController _amountController = MoneyMaskedTextController(
    decimalSeparator: '',
    thousandSeparator: '.',
    precision: 0,
    initialValue: 0,
  );
  int _selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    double cardWidth =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 40) / 3;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Top Up'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  _selectedAmount = int.parse(_amountController.text);
                });
              },
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Top up amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixText: 'IDR ',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Divider(),
                  Text(
                    '\t\tor\t\t',
                    style: TextStyle(
                      color: Colors.black54,
                      background: Paint()
                        ..color = Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ],
              ),
            ),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: <Widget>[
                _buildMoneyCard(amount: 50000, width: cardWidth),
                _buildMoneyCard(amount: 100000, width: cardWidth),
                _buildMoneyCard(amount: 150000, width: cardWidth),
                _buildMoneyCard(amount: 200000, width: cardWidth),
                _buildMoneyCard(amount: 250000, width: cardWidth),
                _buildMoneyCard(amount: 500000, width: cardWidth),
                _buildMoneyCard(amount: 1000000, width: cardWidth),
                _buildMoneyCard(amount: 2500000, width: cardWidth),
                _buildMoneyCard(amount: 5000000, width: cardWidth),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFab(),
    );
  }

  MoneyCard _buildMoneyCard({int amount, double width}) {
    return MoneyCard(
      onTap: () {
        setState(() {
          if (_selectedAmount != amount) {
            _selectedAmount = amount;
          } else {
            _selectedAmount = 0;
            _amountController.text = '0';
          }

          _amountController.text = _selectedAmount.toString();
        });
      },
      amount: amount,
      width: width,
      isSelected: amount == _selectedAmount,
    );
  }

  Widget _buildFab() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return GradientFab(
          onPressed: _selectedAmount > 0 && _selectedAmount != null
              ? () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessPage(
                        ticket: null,
                        transaction: AppTransaction(
                          userId: (state as UserLoadSuccess).user.userId,
                          title: 'Top Up Wallet',
                          total: _selectedAmount,
                          subtitle:
                              '${DateTime.now().dayName}, ${DateTime.now().day} ${DateTime.now().monthName} ${DateTime.now().year}',
                          time: DateTime.now(),
                        ),
                      ),
                    ),
                  );
                }
              : null,
          label: Text('Continue to payment'),
          icon: Icon(Icons.payment),
        );
      },
    );
  }
}
