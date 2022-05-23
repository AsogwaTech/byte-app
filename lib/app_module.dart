import 'package:etra_flutter/pages/batches/batch_list_page.dart';
import 'package:etra_flutter/pages/dashboard/custom_dashboard.dart';
import 'package:etra_flutter/pages/dashboard/dashboard.dart';
import 'package:etra_flutter/pages/dashboard/welcome_dashboard.dart';
import 'package:etra_flutter/pages/destination_page/destination_page.dart';
import 'package:etra_flutter/pages/login/login_page.dart';
import 'package:etra_flutter/pages/splashscreen/splash_screen_page.dart';
import 'package:etra_flutter/services/routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  // TODO: implement binds
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute,
        child: (_, __) => LoginPage(), /*SplashScreenPage(),*//*Welcome(),*/ /*LoginPage(),*/
        transition: TransitionType.rightToLeft),
    /*ChildRoute(Routes.DASHBOARD,
        child: (_, __) => Dashboard(),
        transition: TransitionType.rightToLeft),
    ChildRoute(Routes.LOGIN,
        child: (_, __) => LoginPage(),
        transition: TransitionType.rightToLeft),
    ChildRoute(Routes.TICKET_BATCH_LIST,
        child: (_, __) => BatchListPage(),
        transition: TransitionType.rightToLeft),*/
    ChildRoute(Routes.DESTINATION_PAGE,
           child: (_,__) =>destination_page(),
  transition: TransitionType.rightToLeftWithFade),
    // ChildRoute(Routes.DASHBOARD,//LOGIN_PAGE,
    //     child: (_,__) =>Dashboard(User_nameSecond: username),
    //     transition: TransitionType.rightToLeftWithFade),
    ChildRoute(Routes.CUSTOM_DASHBOARD,
        child: (_,__)=>custom_dashboard(), transition: TransitionType.rightToLeftWithFade),
  ];

  //get username => username;
}
