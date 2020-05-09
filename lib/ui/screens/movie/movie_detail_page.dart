part of '../screen.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  final bool isComingSoon;

  const MovieDetailPage({
    Key key,
    this.movie,
    this.isComingSoon = false,
  }) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  void _navigateBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    MovieDetail movieDetail;
    List<Credit> credits;

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: FutureBuilder(
        future: MovieService.getMovieDetail(widget.movie),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            movieDetail = snapshot.data;

            return FutureBuilder(
              future: MovieService.getCredits(widget.movie.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  credits = snapshot.data;
                  return _MainView(
                    movie: movieDetail,
                    credits: credits,
                    backButtonPressed: _navigateBack,
                  );
                } else {
                  return _LoadingView(backButtonPressed: _navigateBack);
                }
              },
            );
          } else {
            return _LoadingView(backButtonPressed: _navigateBack);
          }
        },
      ),
      floatingActionButton:
          widget.isComingSoon ? null : _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2000.0),
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
      child: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Buy ticket'),
        icon: Icon(Icons.attach_money),
        backgroundColor: Colors.transparent,
        splashColor: primaryColorLight.withOpacity(0.25),
        elevation: 0.0,
        hoverElevation: 0.0,
        highlightElevation: 0.0,
        focusElevation: 0.0,
      ),
    );
  }
}

class _MainView extends StatelessWidget {
  final MovieDetail movie;
  final List<Credit> credits;
  final Function backButtonPressed;

  _MainView({
    Key key,
    @required this.movie,
    @required this.credits,
    @required this.backButtonPressed,
  }) : super(key: key);

  List<BoxShadow> _boxShadows = [
    BoxShadow(
      blurRadius: 24.0,
      color: Colors.black.withOpacity(0.22),
      offset: Offset(0, 16.0),
    ),
    BoxShadow(
      blurRadius: 6.0,
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
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 230.0 + MediaQuery.of(context).padding.top,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25.0),
                    bottomLeft: Radius.circular(25.0),
                  ),
                  image: DecorationImage(
                    image: movie.backdropPath == null
                        ? AssetImage('assets/no_image.png')
                        : NetworkImage(
                            imageBaseURL + 'w780' + movie.backdropPath),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: _boxShadows,
                ),
              ),
              SizedBox(height: 32.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  movie.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  movie.genresAndLanguage,
                  style: TextStyle(color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RatingStars(
                    voteAverage: movie.voteAverage,
                    textColor: Colors.black,
                    fontSize: 14.0,
                    starSize: 20.0,
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Cast',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  itemCount: credits.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CastCard(credit: credits[index]),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Storyline',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  movie.overview,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              SizedBox(height: 128.0),
            ],
          ),
        ),
        _BackButton(
          onPressed: backButtonPressed,
          color: Colors.white,
        ),
      ],
    );
  }
}

class _LoadingView extends StatelessWidget {
  final Function backButtonPressed;

  const _LoadingView({Key key, @required this.backButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: shimmerBaseColor,
          highlightColor: shimmerHighlightColor,
          child: Column(
            children: <Widget>[
              Container(
                height: 230.0 + MediaQuery.of(context).padding.top,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25.0),
                    bottomLeft: Radius.circular(25.0),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Container(
                height: 25.0,
                width: 125.0,
                color: Colors.white,
              ),
              SizedBox(height: 8.0),
              Container(
                height: 16.0,
                width: 170.0,
                color: Colors.white,
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RatingStars(
                    voteAverage: 9,
                    fontSize: 14.0,
                    starSize: 20.0,
                  ),
                ],
              ),
            ],
          ),
        ),
        _BackButton(onPressed: backButtonPressed),
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  final Function onPressed;
  final Color color;

  const _BackButton({
    Key key,
    @required this.onPressed,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black38,
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPressed,
                  borderRadius: BorderRadius.circular(2000.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
