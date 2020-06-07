part of '../screen.dart';

class HomePage extends StatefulWidget {
  final int currentIndex;

  const HomePage({Key key, this.currentIndex = 0}) : super(key: key);
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex;
  PageController _pageController;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.blueGrey[50],
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: <Widget>[
          MoviePage(),
          TicketPage(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColorLight,
            accentColor,
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 24.0,
            color: primaryColorLight.withOpacity(0.22),
            offset: Offset(0, 16.0),
          ),
          BoxShadow(
            blurRadius: 6.0,
            color: primaryColorLight.withOpacity(0.14),
            offset: Offset(0, 2.0),
          ),
          BoxShadow(
            blurRadius: 1.0,
            color: Colors.black.withOpacity(0.08),
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TopUpPage(),
          ));
        },
        child: Icon(Icons.account_balance_wallet),
        backgroundColor: Colors.transparent,
        splashColor: primaryColorLight.withOpacity(0.25),
        elevation: 0.0,
        hoverElevation: 0.0,
        highlightElevation: 0.0,
        focusElevation: 0.0,
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            _pageController.jumpToPage(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.video_library),
              title: Text('Movies'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_play),
              title: Text('My Tickets'),
            ),
          ],
        ),
      ),
    );
  }
}
