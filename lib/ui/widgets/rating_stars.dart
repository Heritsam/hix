part of 'widget.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final double starSize;
  final double fontSize;
  final Color textColor;

  RatingStars({
    Key key,
    this.voteAverage = 0,
    this.starSize = 20.0,
    this.fontSize = 12.0,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int n = (voteAverage / 2).round();

    List<Widget> widgets = List.generate(5, (index) {
      return Icon(
        Icons.star,
        color: index < n ? accentColor : textColor.withOpacity(0.26),
        size: starSize,
      );
    });

    widgets.add(SizedBox(width: 4.0));
    widgets.add(Text(
      '$voteAverage / 10',
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
      ),
    ));

    return Row(
      children: widgets,
    );
  }
}
