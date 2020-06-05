import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final double size;
  final EdgeInsets padding;
  final String label;
  final Color labelBackground;
  final double height;

  CustomLoading(
      {Key key,
      this.size = 30,
      this.padding,
      this.label,
      this.labelBackground,
      this.height = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
        padding: padding ?? EdgeInsets.symmetric(vertical: 15),
        child: Column(children: <Widget>[
          SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).accentColor))),
          label == null
              ? SizedBox(
                  height: height,
                )
              : Container(
                  color: labelBackground,
                  margin: EdgeInsets.only(top: 7),
                  padding: EdgeInsets.all(3),
                  child: Text(label, style: Theme.of(context).textTheme.bodyText1),
                )
        ]),
      )),
    );
  }
}
