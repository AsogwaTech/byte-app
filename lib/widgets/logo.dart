import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/**
 * @author Gibah Joseph
 * email: gibahjoe@gmail.com
 * Jul, 2021
 **/
class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'assets/svg/eckopay_logo.svg',
        child: SvgPicture.asset(
          'assets/svg/eckopay_logo.svg',
        ));
  }
}
