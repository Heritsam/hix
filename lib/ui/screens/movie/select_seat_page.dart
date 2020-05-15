part of '../screen.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;

  const SelectSeatPage({Key key, this.ticket}) : super(key: key);

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> _selectedSeats = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.ticket.movieDetail.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 64.0),
        child: Column(
          children: <Widget>[
            _CinemaScreen(),
            SizedBox(height: 64.0),
            _generateSeats(),
          ],
        ),
      ),
      floatingActionButton: GradientFab(
        onPressed: _selectedSeats.length > 0
            ? () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CheckoutPage(
                    ticket: widget.ticket.copyWith(seats: _selectedSeats),
                  ),
                ));
              }
            : null,
        label: Text('Continue to payment'),
        icon: Icon(Icons.payment),
      ),
    );
  }

  Widget _generateSeats() {
    List<int> numberOfSeats = <int>[5, 5, 5, 5, 3];
    List<Widget> widgets = [];

    for (int i = 0; i < numberOfSeats.length; i++) {
      widgets.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            numberOfSeats[i],
            (index) => Padding(
              padding: EdgeInsets.all(8.0),
              child: SelectableBox(
                label: '${String.fromCharCode(i + 65)}${index + 1}',
                width: 40.0,
                height: 40.0,
                isSelected: _selectedSeats.contains(
                  '${String.fromCharCode(i + 65)}${index + 1}',
                ),
                isEnabled: index != 0,
                onTap: () {
                  String seatNumber =
                      '${String.fromCharCode(i + 65)}${index + 1}';

                  setState(() {
                    if (_selectedSeats.contains(seatNumber)) {
                      _selectedSeats.remove(seatNumber);
                    } else {
                      _selectedSeats.add(seatNumber);
                    }
                  });
                },
              ),
            ),
          ),
        ),
      );
    }

    widgets = widgets.reversed.toList();

    return Column(children: widgets);
  }
}

class _CinemaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/screen.png'),
        ),
      ),
    );
  }
}
