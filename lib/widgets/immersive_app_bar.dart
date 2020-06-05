import 'package:flutter/material.dart';

class ImmersiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ImmersiveAppBar({
    Key key,
    @required this.boxDecoration,
    this.title,
    this.height = 50,
    this.isCenter = false,
    this.type = Brightness.light,
    this.actions,
    this.showBackup = true,
    this.bottom,
    this.reverseLeadingColor = false,
    this.backupFunc,
  }) : super(key: key);

  final Widget title;
  final double height;
  final BoxDecoration boxDecoration;
  final bool isCenter;
  final Brightness type;
  final List<Widget> actions;
  final bool showBackup;
  final Widget bottom;
  final bool reverseLeadingColor;
  final Function backupFunc;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        title: title,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black87),
        leading: showBackup
            ? Padding(
                padding: EdgeInsets.only(top: 17, bottom: 15),
                child: GestureDetector(
                  child: reverseLeadingColor
                      ? Icon(Icons.arrow_back_ios)
                      : Icon(Icons.arrow_back_ios),
                  onTap: () {
                    if (backupFunc != null) {
                      backupFunc();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ))
            : SizedBox(),
        actions: actions,
        brightness: type,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: isCenter,
        automaticallyImplyLeading: false,
        bottom: bottom,
      ),
      decoration: boxDecoration,
    );
  }
}
