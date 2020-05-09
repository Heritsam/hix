part of 'widget.dart';

class ComingSoonCard extends StatelessWidget {
  final Movie movie;
  final Function onTap;

  final double _height = 140.0;
  final double _width = 100;

  ComingSoonCard({Key key, this.movie, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: shimmerBaseColor,
          highlightColor: shimmerHighlightColor,
          child: Container(
            height: _height,
            width: _width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              image: movie.backdropPath == null
                  ? AssetImage('assets/no_image280.png')
                  : NetworkImage(imageBaseURL + 'w780' + movie.backdropPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(15.0),
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
