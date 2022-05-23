import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 90,
          height: 90,
          alignment: Alignment.center,
          child: GlowingProgressIndicator(
            child: Image.asset(
              'assets/images/logo-only-blue.png',
              width: 90,
              height: 90,
            ),
          ),
        ),
      ),
    );
  }
}
