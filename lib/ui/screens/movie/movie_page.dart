part of '../screen.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {

  void _navigateToProfilePage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProfilePage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildPageHeader(),
          SizedBox(height: 32.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Text(
              'Now Playing',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16.0),
          _buildNowPlayingMovie(),
          SizedBox(height: 32.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Text(
              'Browse Movie',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16.0),
          _buildBrowseMovie(),
          SizedBox(height: 32.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Text(
              'Coming Soon',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16.0),
          _buildComingSoonMovie(),
          SizedBox(height: 32.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Text(
              'It\'s Your Lucky Day!',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16.0),
          _buildListPromo(),
          SizedBox(height: 80.0),
        ],
      ),
    );
  }

  Widget _buildListPromo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        children: dummyPromos.map((item) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: PromoCard(promo: item),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildComingSoonMovie() {
    return SizedBox(
      height: 140.0,
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoaded) {
            List<Movie> movies = state.upcomingMovies.sublist(10);

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ComingSoonCard(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(
                            movie: movies[index],
                            isComingSoon: true,
                          ),
                        ),
                      );
                    },
                    movie: movies[index],
                  ),
                );
              },
            );
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: shimmerBaseColor,
                highlightColor: shimmerHighlightColor,
                child: Container(
                  height: 140.0,
                  width: 210.0,
                  margin: EdgeInsets.only(left: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBrowseMovie() {
    final double size = MediaQuery.of(context).size.width / 4 - 24;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              if (state is UserLoadSuccess) {
                return BrowseButton(genre: state.user.selectedGenres[index]);
              }

              return Shimmer.fromColors(
                baseColor: shimmerBaseColor,
                highlightColor: shimmerHighlightColor,
                child: Container(
                  height: size,
                  width: size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildNowPlayingMovie() {
    return SizedBox(
      height: 140.0,
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoaded) {
            List<Movie> movies = state.movies.sublist(0, 9);

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: MovieCard(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(
                            movie: movies[index],
                          ),
                        ),
                      );
                    },
                    movie: movies[index],
                  ),
                );
              },
            );
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: shimmerBaseColor,
                highlightColor: shimmerHighlightColor,
                child: Container(
                  height: 140.0,
                  width: 210.0,
                  margin: EdgeInsets.only(left: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              );
            },
          );
        },
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
      child: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              32.0, 32.0 + MediaQuery.of(context).padding.top, 32.0, 32.0),
          child: BlocBuilder<UserBloc, UserState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is UserLoadSuccess) {
                if (imageFileToUpload != null) {
                  uploadImage(imageFileToUpload).then((downloadUrl) {
                    imageFileToUpload = null;
                    BlocProvider.of<UserBloc>(context).add(
                      UserUpdate(profileImage: downloadUrl),
                    );
                  });
                }

                return Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => _navigateToProfilePage(),
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white38,
                            width: 2.0,
                          ),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Shimmer.fromColors(
                              baseColor: shimmerBaseColor,
                              highlightColor: shimmerHighlightColor,
                              child: Container(
                                height: 50.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: state.user.profilePicture == ''
                                      ? AssetImage(
                                          'assets/profile_picture.png',
                                        )
                                      : NetworkImage(
                                          state.user.profilePicture,
                                        ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin -
                              78 -
                              16,
                          child: Text(
                            state.user.name,
                            style: GoogleFonts.nunitoSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: 'id_ID',
                            decimalDigits: 0,
                            symbol: 'IDR ',
                          ).format(state.user.balance),
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }

              if (state is UserInitial) {
                return Row(
                  children: <Widget>[
                    Shimmer.fromColors(
                      baseColor: shimmerBaseColor,
                      highlightColor: shimmerHighlightColor,
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Shimmer.fromColors(
                          baseColor: shimmerBaseColor,
                          highlightColor: shimmerHighlightColor,
                          child: Container(
                            height: 25.0,
                            width: 138.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Shimmer.fromColors(
                          baseColor: shimmerBaseColor,
                          highlightColor: shimmerHighlightColor,
                          child: Container(
                            height: 19.0,
                            width: 80.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
