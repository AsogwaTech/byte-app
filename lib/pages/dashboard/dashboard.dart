import 'dart:async';
//import 'dart:html';
import 'dart:math' as math;

import 'package:api/api.dart';
import 'package:etra_flutter/app_config.dart';
import 'package:etra_flutter/database/database.dart';
import 'package:etra_flutter/extension/extensions.dart';
import 'package:etra_flutter/services/routes.dart';
import 'package:etra_flutter/services/session.dart';
import 'package:etra_flutter/utils/utils.dart';
import 'package:etra_flutter/widgets/custom/drawer_item.dart';
import 'package:etra_flutter/widgets/custom/organization_logo.dart';
import 'package:etra_flutter/widgets/message_status_dialog.dart';
import 'package:etra_flutter/widgets/pagination_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

import '../../../image_constant.dart';

class Dashboard extends StatefulWidget {
  final String User_nameSecond;
  //final String username, password, fullname;
  const Dashboard({Key? key, required this.User_nameSecond}) : super(key: key);
  //Dashboard({Key? key, required this.username,required this.password,required this.fullname}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState(User_nameSecond);
}

enum StatPeriod { today, thisMonth, allTime }

class _DashboardState extends State<Dashboard> {

  final String User_nameSecond;
  _DashboardState(this.User_nameSecond);


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // refreshDashboard(refreshProfile: false, refreshHistory: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){},
        ),
        title: Text('${User_nameSecond} DashBoard'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            children: [
              const SizedBox(height: 20,),
              Center(
                child: (
                CircleAvatar(
                  radius: 65.0,
                  backgroundImage: AssetImage('assets/images/Logo.png'),
                )
                ),
              ),
              SizedBox(
                height: 600,
                child: GridView.count(
                  childAspectRatio: 1.0,
                  padding: const EdgeInsets.all(4),
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 8.0),
                        child: (
                        Container(
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue,
                                offset: const Offset(10, 10),
                                spreadRadius: 0.0,
                                blurRadius: 0.0,
                              ),
                            ],
                          ),
                          child: Text(''),
                        )
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: (
                          Container(
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue,
                                  offset: const Offset(10, 10),
                                  spreadRadius: 0.0,
                                  blurRadius: 0.0,
                                ),
                              ],
                            ),
                            child: Text(''),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Modular.to.pushNamed(Routes.CUSTOM_DASHBOARD);
                  },
                  child: const Text('List Of Contacts')),
            ],
        ),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Text('Welcome to Byteworks flutter onboarding ${User_nameSecond} '),
      //       ElevatedButton(
      //           onPressed: () {
      //             Modular.to.pushNamed(Routes.CUSTOM_DASHBOARD);
      //           },
      //           child: const Text('List Of Contacts'))
      //     ],
      //   ),
      // ),
    );
  }
}
