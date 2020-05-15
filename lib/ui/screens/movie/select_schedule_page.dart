part of '../screen.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;

  SelectSchedulePage({Key key, @required this.movieDetail}) : super(key: key);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> _dates;
  DateTime _selectedDate;
  int _selectedTime;
  Theater _selectedTheater;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();

    _dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    _selectedDate = _dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.movieDetail.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Choose Date',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
              ),
            ),
            SizedBox(height: 16.0),
            _generateDateTimes(),
            SizedBox(height: 32.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Choose Theater',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
              ),
            ),
            SizedBox(height: 8.0),
            _generateTimeTable(),
            SizedBox(height: 64.0),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return GradientFab(
          onPressed: !_isValid
              ? null
              : () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SelectSeatPage(
                  ticket: Ticket(
                    movieDetail: widget.movieDetail,
                    theater: _selectedTheater,
                    time: DateTime(
                      _selectedDate.year,
                      _selectedDate.month,
                      _selectedDate.day,
                      _selectedTime,
                    ),
                    bookingCode:
                    randomAlphaNumeric(12).toUpperCase(),
                    totalPrice: null,
                    name: (state as UserLoadSuccess).user.name,
                    seats: null,
                  ),
                ),
              ),
            );
          },
          label: Text('Next'),
          icon: Icon(Icons.chevron_right),
        );
      },
    );
  }

  Widget _generateDateTimes() {
    return SizedBox(
      height: 90.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: _dates.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: DateCard(
              onTap: () {
                setState(() {
                  _selectedDate = _dates[index];
                });
              },
              date: _dates[index],
              isSelected: _selectedDate == _dates[index],
            ),
          );
        },
      ),
    );
  }

  Widget _generateTimeTable() {
    List<int> schedule = List.generate(7, (index) => 10 + index + 2);
    List<Widget> widgets = <Widget>[];

    for (var theater in dummyTheaters) {
      widgets.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 8.0),
        child: Text(theater.name, style: TextStyle(fontSize: 18.0)),
      ));

      widgets.add(Container(
        height: 50.0,
        margin: EdgeInsets.only(bottom: 16.0),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: schedule.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: SelectableBox(
                onTap: () {
                  setState(() {
                    _selectedTheater = theater;
                    _selectedTime = schedule[index];
                    _isValid = true;
                  });
                },
                label: '${schedule[index]}:00',
                height: 50.0,
                isSelected: _selectedTheater == theater &&
                    _selectedTime == schedule[index],
                isEnabled: schedule[index] > DateTime.now().hour ||
                    _selectedDate.day != DateTime.now().day,
              ),
            );
          },
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
