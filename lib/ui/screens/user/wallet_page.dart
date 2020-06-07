import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hix/blocs/bloc.dart';
import 'package:hix/models/model.dart';
import 'package:hix/services/service.dart';
import 'package:hix/shared/shared.dart';
import 'package:hix/ui/screens/user/top_up_page.dart';
import 'package:hix/ui/widgets/transaction_card.dart';
import 'package:hix/ui/widgets/widget.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Wallet'),
      ),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        return SingleChildScrollView(
          child: _WalletView(bloc: context, state: state),
        );
      }),
      floatingActionButton: GradientFab(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => TopUpPage(),
          ));
        },
        icon: Icon(Icons.account_balance_wallet),
        label: Text('Top up'),
      ),
    );
  }
}

class _WalletView extends StatelessWidget {
  final BuildContext bloc;
  final UserState state;

  const _WalletView({Key key, this.bloc, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _CardView(bloc: bloc, state: state),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Text(
            'Recent Transactions',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _TransactionList(bloc: bloc, state: state),
      ],
    );
  }
}

class _TransactionList extends StatelessWidget {
  final BuildContext bloc;
  final UserState state;

  const _TransactionList({Key key, this.bloc, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppTransactionService.getTransactions(
          (state as UserLoadSuccess).user.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.length > 0) {
            return _buildTransactionRows(snapshot.data);
          } else {
            return EmptyState(label: 'Hmm... There is no recent transactions');
          }
        }

        return _buildShimmerListView(context);
      },
    );
  }

  Widget _buildTransactionRows(List<AppTransaction> transactions) {
    transactions.sort((first, second) => second.time.compareTo(first.time));

    return ListView.builder(
      padding: EdgeInsets.only(bottom: 16.0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return TransactionCard(transaction: transactions[index]);
      },
    );
  }

  Widget _buildShimmerListView(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: Row(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: shimmerBaseColor,
                highlightColor: shimmerHighlightColor,
                child: Container(
                  width: 56.0,
                  height: 56.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Shimmer.fromColors(
                baseColor: shimmerBaseColor,
                highlightColor: shimmerHighlightColor,
                child: Container(
                  width: MediaQuery.of(context).size.width -
                      56 -
                      2 * defaultMargin -
                      16,
                  height: 56.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CardView extends StatelessWidget {
  final BuildContext bloc;
  final UserState state;

  const _CardView({Key key, this.bloc, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = 185.0;
    double _width = double.infinity;
    BorderRadius _borderRadius = BorderRadius.circular(15.0);
    List<BoxShadow> _boxShadows = <BoxShadow>[
      BoxShadow(
        blurRadius: 12.0,
        color: primaryColorLight.withOpacity(0.22),
        offset: Offset(0, 6.0),
      ),
      BoxShadow(
        blurRadius: 8.0,
        color: primaryColorLight.withOpacity(0.14),
        offset: Offset(0, 4.0),
      ),
      BoxShadow(
        blurRadius: 2.0,
        color: Colors.black.withOpacity(0.08),
        offset: Offset(0, 1.0),
      ),
    ];

    return Container(
      height: _height,
      width: _width,
      margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColorLight,
            primaryColor,
          ],
        ),
        boxShadow: _boxShadows,
      ),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: _CardReflectionClipper(),
            child: Container(
              height: _height,
              width: _width,
              decoration: BoxDecoration(
                borderRadius: _borderRadius,
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    Colors.white.withOpacity(0.19),
                    Colors.white.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 16.0,
                      height: 16.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(.38),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(.55),
                      ),
                    ),
                  ],
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'id_ID',
                    symbol: 'IDR ',
                    decimalDigits: 0,
                  ).format((state as UserLoadSuccess).user.balance),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 22.0,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _buildCardInfo(
                        caption: 'Card Holder',
                        title: (state as UserLoadSuccess).user.name,
                      ),
                    ),
                    Expanded(
                      child: _buildCardInfo(
                        caption: 'Card ID',
                        title: (state as UserLoadSuccess)
                            .user
                            .userId
                            .substring(0, 10)
                            .toUpperCase(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardInfo({String caption, String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          caption,
          style: TextStyle(
            color: Colors.white.withOpacity(0.87),
            fontWeight: FontWeight.bold,
            fontSize: 10.0,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(width: 4.0),
            Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white38,
              ),
              child: Icon(
                Icons.check_circle,
                size: 12.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CardReflectionClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 12);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
