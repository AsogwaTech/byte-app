//import 'package:flutter/cupertino.dart';
import 'package:etra_flutter/services/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to ByteWorks flutter onboarding'),
            SizedBox(height: 20),
          ElevatedButton(
            onPressed : () {
              Modular.to.pushNamed(Routes.LOGIN_PAGE);
            },
            child:Text('Navigate') ,
          ),
          ],
        ),
      ),
    );
  }
}
