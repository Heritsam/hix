part of 'widget.dart';

class FloatingBackButton extends StatelessWidget {
  final Function onPressed;
  final Color color;

  const FloatingBackButton({
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