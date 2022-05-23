import 'dart:async';

import 'package:api/api.dart';
import 'package:etra_flutter/app_config.dart';
import 'package:etra_flutter/database/database.dart';
import 'package:etra_flutter/image_constant.dart';
import 'package:etra_flutter/services/routes.dart';
import 'package:etra_flutter/services/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  var _opacity = 0.0;
  String? token;

  SharedPreferences? _sharedPreferences;
  Session? _session;
  Database? _database;

  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 5),
    //     () => Modular.to.pushReplacementNamed(Routes.DASHBOARD));
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      away();
    });
  }

  @override
  Widget build(BuildContext context) {
    _sharedPreferences = Provider.of(context);
    _database = Provider.of(context);
    _session = Provider.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.bottomLeft,
              child: SvgPicture.asset('assets/svg/error.svg')),
          ],
      ),

    );
  }

  void away() async {
    print(_sharedPreferences?.getBool('ONBOARDED'));
    var user = await _database?.getUser();
    if (user != null) {
      print(user);
      etraApi.setApiKey('ApiKey', 'Bearer ${user.token}');
      var res = await Future.wait([
        Future.delayed(Duration(seconds: 5)),
        etraApi
            .getUserControllerApi()
            .getAppUserProfile()
            .then((value) => value.data?.data)
      ]).catchError((e) {
        print(e);
        return List.empty();
      });
      for (var response in res) {
        print(response);
        if (response is AppUserProfilePojo) {
          _session?.appUser = response;
          if ((_sharedPreferences?.getBool('ONBOARDED') ?? false)) {
            Modular.to.pushReplacementNamed(Routes.DASHBOARD);
          } else {
            Modular.to.pushReplacementNamed(Routes.DASHBOARD);
          }
          return;
        }
      }
    }
    if ((_sharedPreferences?.getBool('ONBOARDED') ?? false)) {
      Modular.to.pushReplacementNamed(Routes.DASHBOARD);
    } else {
      //Modular.to.pushReplacementNamed(Routes.DASHBOARD);
    }
  }
}
