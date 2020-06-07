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
  MovieDetail movieDetail;
  List<Credit> credits;

  void _navigateBack() {
    Navigator.pop(context);
  }

  void _navigateToSchedulePage(MovieDetail movieDetail) {
    if (movieDetail != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SelectSchedulePage(movieDetail: movieDetail),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: widget.isComingSoon
          ? null
          : GradientFab(
              onPressed: () => _navigateToSchedulePage(movieDetail),
              label: Text('Buy ticket'),
              icon: Icon(Icons.attach_money),
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

   final List<BoxShadow> _boxShadows = [
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
        FloatingBackButton(
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
        FloatingBackButton(onPressed: backButtonPressed),
      ],
    );
  }
}
