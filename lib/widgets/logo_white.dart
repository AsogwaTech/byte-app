import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/**
 * @author Gibah Joseph
 * email: gibahjoe@gmail.com
 * Jul, 2021
 **/
class LogoWhite extends StatelessWidget {
  const LogoWhite({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'assets/svg/logo_white.svg',
        child: SvgPicture.asset(
          'assets/svg/logo_white.svg',
        ));
  }
}
