part of 'widget.dart';

class SelectableBox extends StatelessWidget {
  final bool isSelected;
  final bool isEnabled;
  final double height;
  final double width;
  final String label;
  final Function onTap;
  final TextStyle textStyle;

  const SelectableBox({
    Key key,
    this.isSelected = false,
    this.isEnabled = true,
    this.height = 60,
    this.width = 144,
    this.label,
    this.onTap,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null && isEnabled) {
          onTap();
        }
      },
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: !isEnabled
              ? Colors.grey[300]
              : isSelected ? primaryColorLight : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.transparent : Color(0xFFE4E4E4),
            width: 2.0,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: textStyle ??
                GoogleFonts.nunitoSans(fontSize: 16.0, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
