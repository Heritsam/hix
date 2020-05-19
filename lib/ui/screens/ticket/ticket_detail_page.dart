part of '../screen.dart';

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;

  const TicketDetailPage({Key key, @required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ticket Details'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: _buildTicketCard(context),
      ),
    );
  }

  Widget _buildTicketCard(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 12.0,
            color: Colors.black.withOpacity(0.10),
            offset: Offset(0, 6.0),
          ),
          BoxShadow(
            blurRadius: 8.0,
            color: Colors.black.withOpacity(0.08),
            offset: Offset(0, 4.0),
          ),
          BoxShadow(
            blurRadius: 1.0,
            color: Colors.black.withOpacity(0.08),
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: _buildTicketContent(context),
    );
  }

  Widget _buildTicketContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Radius radius = Radius.circular(8.0);
    double horizontalPadding = 16.0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Hero(
            tag: ticket.bookingCode,
            child: Container(
              height: size.height * .25,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: radius,
                  topLeft: radius,
                ),
                image: DecorationImage(
                  image: ticket.movieDetail.backdropPath == null
                      ? AssetImage('assets/no_image.png')
                      : NetworkImage(imageBaseURL +
                          'w780' +
                          ticket.movieDetail.backdropPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              ticket.movieDetail.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),
          SizedBox(height: 4.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              ticket.movieDetail.genresAndLanguage,
              style: TextStyle(color: Colors.black54),
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: RatingStars(
              voteAverage: ticket.movieDetail.voteAverage,
              textColor: Colors.black,
              fontSize: 14.0,
              starSize: 20.0,
            ),
          ),
          SizedBox(height: 32.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Cinema', style: TextStyle(color: Colors.black54)),
                Text(ticket.theater.name),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Date & Time', style: TextStyle(color: Colors.black54)),
                Text(ticket.time.dateAndTime),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Seat Numbers', style: TextStyle(color: Colors.black54)),
                Text(ticket.seatsInString),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Order ID', style: TextStyle(color: Colors.black54)),
                Text(ticket.bookingCode),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Divider(indent: horizontalPadding, endIndent: horizontalPadding),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Name',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ticket.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Paid',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: "id_ID",
                            decimalDigits: 0,
                            symbol: "IDR ",
                          ).format(ticket.totalPrice),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                QrImage(
                  version: 6,
                  foregroundColor: Colors.black,
                  errorCorrectionLevel: QrErrorCorrectLevel.M,
                  padding: EdgeInsets.all(0),
                  size: 100,
                  data: ticket.bookingCode,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
