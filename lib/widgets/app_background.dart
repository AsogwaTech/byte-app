import 'package:etra_flutter/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**
 * @author Gibah Joseph
 * email: gibahjoe@gmail.com
 * Jul, 2021
 **/
class AppBackground extends StatelessWidget {
  final Widget child;
  final SystemUiOverlayStyle overlayStyle;

  const AppBackground(
      {Key? key,
      required this.child,
      this.overlayStyle = const SystemUiOverlayStyle(
        systemNavigationBarColor: appPrimaryColor, // navigation bar color
        statusBarBrightness: Brightness.light, // navigation bar color
        //statusBarColor: Colors.pink, // status bar color
      )})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover)),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: child,
        )
      ]),
    );
  }
}
