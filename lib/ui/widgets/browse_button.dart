part of 'widget.dart';

class BrowseButton extends StatelessWidget {
  final String genre;

  BrowseButton({Key key, this.genre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(genre);
  }
}
