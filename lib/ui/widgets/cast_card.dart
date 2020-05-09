part of 'widget.dart';

class CastCard extends StatelessWidget {
  final Credit credit;

  const CastCard({Key key, @required this.credit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: shimmerBaseColor,
              highlightColor: shimmerHighlightColor,
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: credit.profilePath == null
                      ? AssetImage('assets/logo.png')
                      : NetworkImage(
                          imageBaseURL + 'w185' + credit.profilePath,
                        ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15.0),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Container(
          width: 72.0,
          child: Text(
            credit.name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
