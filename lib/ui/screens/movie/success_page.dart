part of '../screen.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final AppTransaction transaction;

  const SuccessPage({
    Key key,
    @required this.ticket,
    @required this.transaction,
  }) : super(key: key);

  Future<void> _handleTicketOrder(BuildContext context) async {
    BlocProvider.of<UserBloc>(context).add(UserPurchase(ticket.totalPrice));
    BlocProvider.of<TicketBloc>(context)
        .add(BuyTicket(ticket, transaction.userId));

    await AppTransactionService.saveTransaction(transaction);
  }

  Future<void> _handleTopUp(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
          future: ticket != null
              ? _handleTicketOrder(context)
              : _handleTopUp(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 240.0,
                    height: 240.0,
                    child: FlareActor(
                      'assets/success.flr',
                      fit: BoxFit.contain,
                      animation: 'check',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    ticket != null ? 'Enjoy Your Movie' : 'You\'re Awesome',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    ticket != null
                        ? 'You have bought the ticket successfully'
                        : 'Top up success!',
                    style: TextStyle(color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 64.0),
                  GradientFab(
                    onPressed: () {},
                    icon: Icon(Icons.label_outline),
                    label: Text(ticket != null ? 'My tickets' : 'My wallet'),
                  ),
                  SizedBox(height: 8.0),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Browse movies'),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              );
            } else {
              return _buildLoadingShimmer();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: shimmerBaseColor,
          highlightColor: shimmerHighlightColor,
          child: Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 32.0),
        Shimmer.fromColors(
          baseColor: shimmerBaseColor,
          highlightColor: shimmerHighlightColor,
          child: Container(
            width: 80.0,
            height: 24.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
