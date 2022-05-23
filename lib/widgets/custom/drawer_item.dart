import 'package:flutter/material.dart';

/**
 * @author Gibah Joseph
 * email: gibahjoe@gmail.com
 * Nov, 2021
 **/
class DrawerItem extends StatefulWidget {
  final Widget icon;
  final String label;
  final Function onTap;

  const DrawerItem(
    this.icon,
    this.onTap, {
    this.label = '',
    Key? key,
  }) : super(key: key);

  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.icon != null) widget.icon,
              if (widget.icon != null)
                SizedBox(
                  width: 10,
                ),
              Text(
                widget.label,
                style: TextStyle(
                  color: Color(0xffe5e5e5),
                  fontSize: 16,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
