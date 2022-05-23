import 'package:api/api.dart';
import 'package:etra_flutter/app_config.dart';
import 'package:etra_flutter/database/database.dart';
import 'package:etra_flutter/extension/extensions.dart';
import 'package:etra_flutter/pages/dashboard/custom_dashboard.dart';
import 'package:etra_flutter/services/routes.dart';
import 'package:etra_flutter/services/session.dart';
import 'package:etra_flutter/utils/utils.dart';
import 'package:etra_flutter/widgets/app_reactive_form_field.dart';
import 'package:etra_flutter/widgets/async_submit_button.dart';
import 'package:etra_flutter/widgets/show_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../dashboard/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FormGroup _form = FormGroup({});
  // TextEditingController _username = TextEditingController();
  // TextEditingController _password = TextEditingController();
  // TextEditingController _fullname = TextEditingController();
  late Session _session;
  late Database _database;
  final int _year = DateTime.now().year;
  String get username => this._form.control('username').value;

  @override
  void initState() {
    _form = FormGroup({
      'username':
          FormControl<String>(validators: [Validators.required], value: '' ,) ,
      'password':
          FormControl<String>(validators: [Validators.required], value: ''),
      'fullname':
          FormControl<String>(validators: [Validators.required, Validators.minLength(4)], value: ''),
    });
    // @override
    // Widget build(BuildContext context) {
    //   return ReactiveForm(
    //     formGroup: this._form,
    //     child: Column(
    //       children: <Widget>[
    //         ReactiveTextField(
    //           controller: _username,
    //           formControlName: 'username',
    //           textInputAction: TextInputAction.next,
    //           onSubmitted: () => this._form.focus('password'),
    //         ),
    //         ReactiveTextField(
    //           controller: _password,
    //           formControlName: 'password',
    //           textInputAction: TextInputAction.next,
    //           onSubmitted: () => this._form.focus('fullname'),
    //         ),
    //         ReactiveTextField(
    //           controller: _fullname,
    //           formControlName: 'fullname',
    //           obscureText: true,
    //         ),
    //       ],
    //     ),
    //   );
    // }

    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    _session = Provider.of(context);
    _database = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ReactiveForm(
                formGroup: _form,
                child: Column(
                  children: [
                    SizedBox(
                      height: getScreen(context).height * .07,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Column(
                      children: const [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Hello.",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            // 'Welcome back',
                            // style: TextStyle(
                            //   fontSize: 18,
                            //   fontWeight: FontWeight.bold,
                            // ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Welcome Back',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    LabeledInput(
                      label: '',
                      child: AppReactiveTextInput(
                        formControlName: 'username',
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(
                              fontStyle: FontStyle.italic
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Username',
                        validationMessages: const {
                          ValidationMessage.required: 'Username is required'
                        },
                      ),
                    ),
                    LabeledInput(
                      label: '',
                      child: AppReactiveTextInput(
                        formControlName: 'password',
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(
                              fontStyle: FontStyle.italic
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        hintText: 'Password',
                        validationMessages: const {
                          ValidationMessage.required: 'Password is required'
                        },
                      ),
                    ),
                    LabeledInput(
                      label: '',
                      child: AppReactiveTextInput(
                        formControlName: 'fullname',
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(
                              fontStyle: FontStyle.italic
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        hintText: 'Fullname',
                        validationMessages: const {
                          ValidationMessage.required: 'fullname is required'
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Column(
                    //   children: const [
                    //     Padding(
                    //       padding: EdgeInsets.all(8.0),
                    //       child: Align(
                    //         alignment: Alignment.topRight,
                    //         child: Text(
                    //           "Forgot Password?",
                    //           style: TextStyle(
                    //             color: appPrimaryColor,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: AsyncSubmitButton(
                              onPressed: () async {
                                //_database.insertOrUpdate(entity);
                                //print(username);
                                String User_nameSecond = username;
                                //Modular.to.pushNamed(Routes.DASHBOARD , arguments: username);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(User_nameSecond: username)));
                                //arguments: {_username.text,_password.text,_fullname.text});

                              },
                              child: Text('Login'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.01,
              left: 70,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Copyright $_year. All Rights Reserved',
                  style: const TextStyle(
                    color: appPrimaryColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
