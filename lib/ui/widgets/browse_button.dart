part of 'widget.dart';

class BrowseButton extends StatelessWidget {
  final String genre;
  final double size;

  BrowseButton({Key key, this.genre, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blueGrey[100].withOpacity(0.4),
                  ),
                  child: Container(
                    height: 24.0,
                    width: 24.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(_getMovieIcon(genre)),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8.0),
                      splashColor: Colors.black12,
                      highlightColor: Colors.black.withOpacity(0.06),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.0),
            Text(genre),
          ],
        ),
      ),
    );
  }

  String _getMovieIcon(String genre) {
    String icon;

    switch (genre) {
      case 'Music':
        icon = 'assets/music.png';
        break;
      case 'Horror':
        icon = 'assets/horror.png';
        break;
      case 'Drama':
        icon = 'assets/drama.png';
        break;
      case 'Action':
        icon = 'assets/action.png';
        break;
      default:
        icon = 'assets/documenter.png';
    }

    return icon;
  }
}
