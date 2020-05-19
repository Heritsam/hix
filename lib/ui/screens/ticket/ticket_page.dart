part of '../screen.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: Column(
          children: <Widget>[
            _buildPageHeader(),
            BlocBuilder<TicketBloc, TicketState>(
              // ignore: missing_return
              builder: (context, state) {
                return Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      _TicketListView(
                        tickets: state.tickets
                            .where((ticket) =>
                                !ticket.time.isBefore(DateTime.now()))
                            .toList(),
                      ),
                      _TicketListView(
                        tickets: state.tickets
                            .where((ticket) =>
                                ticket.time.isBefore(DateTime.now()))
                            .toList(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageHeader() {
    List<BoxShadow> boxShadows = [
      BoxShadow(
        blurRadius: 24.0,
        color: primaryColorLight.withOpacity(0.22),
        offset: Offset(0, 16.0),
      ),
      BoxShadow(
        blurRadius: 6.0,
        color: primaryColor.withOpacity(0.14),
        offset: Offset(0, 2.0),
      ),
      BoxShadow(
        blurRadius: 1.0,
        color: Colors.black.withOpacity(0.08),
        offset: Offset(0, 0),
      ),
    ];

    return Container(
      height: 150.0 + MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor,
            primaryColor,
            primaryColorLight,
            accentColor,
          ],
        ),
        boxShadow: boxShadows,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: AppBar(
            centerTitle: true,
            title: Text(
              'My Tickets',
              style: TextStyle(color: Colors.white),
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text('Active'),
                ),
                Tab(
                  child: Text('Past'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TicketListView extends StatelessWidget {
  final List<Ticket> tickets;

  const _TicketListView({Key key, @required this.tickets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Ticket> sortedTickets = tickets;

    sortedTickets
        .sort((ticket1, ticket2) => ticket1.time.compareTo(ticket2.time));

    if (sortedTickets.length == 0) {
      return Padding(
        padding: EdgeInsets.only(bottom: 64.0),
        child: EmptyState(
          label: 'Oops! it looks like you don\'t have any tickets',
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(top: 16.0, bottom: 98.0),
      itemCount: sortedTickets.length,
      itemBuilder: (context, index) {
        return _buildRow(context, sortedTickets[index]);
      },
    );
  }

  Widget _buildRow(BuildContext context, Ticket ticket) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TicketDetailPage(ticket: ticket),
        ));
      },
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
                Hero(
                  tag: ticket.bookingCode,
                  child: Container(
                    width: 70.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          imageBaseURL + 'w500' + ticket.movieDetail.posterPath,
                        ),
                        fit: BoxFit.cover,
                      ),
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
                    ticket.movieDetail.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    ticket.movieDetail.genresAndLanguage,
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text(
                    ticket.theater.name,
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
