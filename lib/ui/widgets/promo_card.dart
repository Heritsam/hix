part of 'widget.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;

  final double borderRadius = 15.0;

  PromoCard({Key key, this.promo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 80,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
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
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    promo.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    promo.description,
                    style: TextStyle(color: Colors.white70, fontSize: 14.0),
                  ),
                ],
              ),
              RichText(
                textAlign: TextAlign.end,
                text: TextSpan(
                  style: GoogleFonts.nunitoSans(color: Colors.white, fontSize: 24.0),
                  children: [
                    TextSpan(
                      text: 'OFF ',
                    ),
                    TextSpan(
                      text: '${promo.discount}%',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: () {},
              splashColor: Colors.black12,
              highlightColor: Colors.black.withOpacity(0.06),
            ),
          ),
        ),
      ],
    );
  }
}
