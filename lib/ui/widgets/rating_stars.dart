part of 'widget.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final double starSize;
  final double fontSize;

  RatingStars({
    Key key,
    this.voteAverage = 0,
    this.starSize = 20.0,
    this.fontSize = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int n = (voteAverage / 2).round();

    List<Widget> widgets = List.generate(5, (index) {
      return Icon(
        Icons.star,
        color: index < n ? accentColor : Color(0xFFE5E5E5).withOpacity(0.54),
        size: starSize,
      );
    });

    widgets.add(SizedBox(width: 4.0));
    widgets.add(Text(
      '$voteAverage / 10',
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
      ),
    ));

    return Row(
      children: widgets,
    );
  }
}
