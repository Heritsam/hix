part of 'widget.dart';

class GradientFab extends StatelessWidget {
  final Function onPressed;
  final Text label;
  final Icon icon;

  const GradientFab({
    Key key,
    @required this.onPressed,
    @required this.label,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2000.0),
        gradient: onPressed != null
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primaryColorLight,
                  accentColor,
                ],
              )
            : LinearGradient(
                colors: [
                  Colors.red[400],
                ],
              ),
        boxShadow: onPressed != null
            ? <BoxShadow>[
                BoxShadow(
                  blurRadius: 24.0,
                  color: primaryColorLight.withOpacity(0.22),
                  offset: Offset(0, 16.0),
                ),
                BoxShadow(
                  blurRadius: 6.0,
                  color: primaryColorLight.withOpacity(0.14),
                  offset: Offset(0, 2.0),
                ),
                BoxShadow(
                  blurRadius: 1.0,
                  color: Colors.black.withOpacity(0.08),
                  offset: Offset(0, 0),
                ),
              ]
            : null,
      ),
      child: FloatingActionButton.extended(
        onPressed: onPressed ?? null,
        label: label,
        icon: icon,
        backgroundColor: Colors.transparent,
        splashColor: primaryColorLight.withOpacity(0.25),
        elevation: 0.0,
        hoverElevation: 0.0,
        highlightElevation: 0.0,
        focusElevation: 0.0,
      ),
    );
  }
}
