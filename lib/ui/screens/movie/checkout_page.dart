part of '../screen.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;

  CheckoutPage({Key key, @required this.ticket}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    int total = 26500 * widget.ticket.seats.length;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Checkout'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          User user = (state as UserLoadSuccess).user;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              children: <Widget>[
                _MovieDescription(ticket: widget.ticket),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
                _TicketDetail(ticket: widget.ticket, total: total),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('My Wallet', style: TextStyle(color: Colors.black54)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        NumberFormat.currency(
                          locale: 'id_ID',
                          decimalDigits: 0,
                          symbol: 'IDR ',
                        ).format(user.balance).toString(),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color:
                              user.balance >= total ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TicketDetail extends StatelessWidget {
  final Ticket ticket;
  final int total;

  const _TicketDetail({Key key, @required this.ticket, @required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Order ID', style: TextStyle(color: Colors.black54)),
            Text(ticket.bookingCode),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Cinema', style: TextStyle(color: Colors.black54)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Text(
                ticket.theater.name,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Date & Time', style: TextStyle(color: Colors.black54)),
            Text(
              ticket.time.dateAndTime,
              textAlign: TextAlign.end,
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Seat Numbers', style: TextStyle(color: Colors.black54)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Text(
                ticket.seatsInString,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Price', style: TextStyle(color: Colors.black54)),
            Text('IDR 25.000 x ${ticket.seats.length}'),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Fee', style: TextStyle(color: Colors.black54)),
            Text('IDR 1.500 x ${ticket.seats.length}'),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Total', style: TextStyle(color: Colors.black54)),
            Text(
              NumberFormat.currency(
                locale: 'id_ID',
                decimalDigits: 0,
                symbol: 'IDR ',
              ).format(total).toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ],
    );
  }
}

class _MovieDescription extends StatelessWidget {
  final Ticket ticket;

  _MovieDescription({Key key, @required this.ticket}) : super(key: key);

  List<BoxShadow> _boxShadows = [
    BoxShadow(
      blurRadius: 8.0,
      color: Colors.black.withOpacity(0.22),
      offset: Offset(0, 4.0),
    ),
    BoxShadow(
      blurRadius: 4.0,
      color: Colors.black.withOpacity(0.14),
      offset: Offset(0, 2.0),
    ),
    BoxShadow(
      blurRadius: 1.0,
      color: Colors.black.withOpacity(0.08),
      offset: Offset(0, 0),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: shimmerBaseColor,
              highlightColor: shimmerHighlightColor,
              child: Container(
                height: 100.0,
                width: 80.0,
                color: Colors.white,
              ),
            ),
            Container(
              height: 100.0,
              width: 80.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: _boxShadows,
                image: DecorationImage(
                  image: NetworkImage(
                    imageBaseURL + 'w342' + ticket.movieDetail.posterPath,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 16.0),
        SizedBox(
          width:
              MediaQuery.of(context).size.width - 2 * defaultMargin - 80 - 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                ticket.movieDetail.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              Text(
                ticket.movieDetail.genresAndLanguage,
                style: TextStyle(color: Colors.black54, fontSize: 13.0),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.0),
              RatingStars(
                voteAverage: ticket.movieDetail.voteAverage,
                textColor: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
