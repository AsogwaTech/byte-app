import 'package:etra_flutter/app_config.dart';
import 'package:etra_flutter/app_module.dart';
import 'package:etra_flutter/database/database.dart';
import 'package:etra_flutter/services/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void init() {
  WidgetsFlutterBinding.ensureInitialized();//to ensure database initialization. It should be at the top of the widget
  runApp(ModularApp(
    module: AppModule(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
    return MultiProvider(
      providers: [//ChangeNotifierProvider(create:(_) => UserNotifier()),// added by me for list provider
        Provider(
          create: (_) {
            return Database();
            dispose:(context, Database database) => database.close();// added by me
            //return UserNotifier();
          },
        ),
        FutureProvider<SharedPreferences?>(
          initialData: null,
          create: (_) {
            return SharedPreferences.getInstance();
          },
        ),
        ChangeNotifierProxyProvider2<Database?, SharedPreferences?, Session>(
          create: (_) {
            return Session();
          },
          update: (context, db, sharedPreferences, session) {
            return (session ?? Session())
              ..sharedPreferences = sharedPreferences
              ..database = db;
          },
        ),
      ],
      child: MaterialApp(
        title: 'ETRA',
        navigatorKey: navigatorKey,//The global navigation key
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: appPrimaryColor,
          errorColor: Colors.red,
          // Color of error thrown
          //Useful for text input color
          // colorScheme: ColorScheme.light(
          //   onSurface: Color.fromARGB(255, 234, 76, 98),
          // ),
          fontFamily: GoogleFonts.openSans().fontFamily,
          // When text is selected for cut or copy
          hintColor: Colors.black26,
          appBarTheme: const AppBarTheme(
            // color: Colors.white,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: appPrimaryColor,
            centerTitle: true,
          ),
          //for the counter bellow the border (if you have a counter)
          textTheme: GoogleFonts.openSansTextTheme(),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: appPrimaryColor,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              textStyle: null,
              elevation: 5,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(4))),
              onSurface: HSLColor.fromColor(appPrimaryColor)
                  .withLightness(0.3)
                  .toColor(),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: appPrimaryColor,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              textStyle: null,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            floatingLabelStyle: TextStyle(
              color: Color(0xff3b747e),
              fontSize: 12,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            fillColor: Colors.transparent,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: appPrimaryColor),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: appPrimaryColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: appPrimaryColor),
                borderRadius: BorderRadius.all(Radius.circular(6))),
          ),
          // textSelectionTheme: TextSelectionThemeData(
          //   cursorColor: Color.fromARGB(255, 234, 76, 98),
          //   selectionColor: Color.fromARGB(255, 234, 76, 98),
          // ),
        ),
      ).modular(),
    );
  }
}
