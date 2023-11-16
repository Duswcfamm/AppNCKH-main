import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_project/components/homepage.dart';
import 'package:my_flutter_project/components/signup.dart';
import 'package:my_flutter_project/services/base_client.dart';
import 'package:my_flutter_project/services/validation.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool _showPass = false;
  final formKey1 = GlobalKey<FormState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [
                      Colors.blue.shade900,
                      Colors.blue.shade800,
                      Colors.blue.shade400
                    ])),
                child: Form(
                    key: formKey1,
                    child: SingleChildScrollView(
                        padding: EdgeInsets.all(32),
                        reverse: true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                              child: Container(
                                width: 70,
                                height: 70,
                                padding: EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('images/actvn_big_icon.png'),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: BoxShape.circle,
                                  color: Color(0xffd8d8d8),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 30),
                              ),
                            ),
                            SizedBox(height: 20),
                            Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: TextFormField(
                                controller: userController,
                                validator: (value) {
                                  if (value.toString().length < 3)
                                    return 'Username must be longer than 3 characters';
                                  else
                                    return null;
                                },
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                                decoration: InputDecoration(
                                    labelText: "USERNAME",
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 15)),
                              ),
                            ),
                            SizedBox(height: 20),
                            Form(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Stack(
                                  alignment: AlignmentDirectional.centerEnd,
                                  children: <Widget>[
                                    TextFormField(
                                      validator: (value) {
                                        if (value.toString().length < 8)
                                          return 'Passwords must be longer than 8 characters';
                                        else if (value.toString().contains(' '))
                                          return 'Passwords must not contains space';
                                        else
                                          return null;
                                      },
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                      obscureText: !_showPass,
                                      decoration: InputDecoration(
                                          labelText: "PASSWORD",
                                          labelStyle: TextStyle(
                                              color: Color(0xff000000),
                                              fontSize: 15)),
                                      controller: passController,
                                    ),
                                    GestureDetector(
                                      onTap: onToggleShowPass,
                                      child: Text(
                                        _showPass ? "HIDE" : "SHOW",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                )),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                  ),
                                  onPressed: loginMethod,
                                  child: Text(
                                    "SIGN IN",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text("Create an account",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                    onPressed: () {
                                      movetoSignup();
                                    },
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text("Forgot passwords or username?",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))))));
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void movetoHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void loginMethod() {
    final form1 = formKey1.currentState!;
    if (!form1.validate())
      showTopSnackBarFailed(context);
    else {
      login(userController.text.toString(), passController.text.toString());
      if (isSuccessLogin) {
        movetoHome();
        showTopSnackBarSuccess(context);
      }
      // else showTopSnackBarFailed(context);
    }
  }

  void showTopSnackBarFailed(BuildContext context) => Flushbar(
        shouldIconPulse: false,
        title: 'Login Failed',
        message: 'Wrong credential',
        duration: Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        onTap: (_) {
          print('Clicked bar');
        },
      )..show(context);

  void showTopSnackBarSuccess(BuildContext context) => Flushbar(
        shouldIconPulse: false,
        title: 'Login Success',
        message: 'Proceed to homepage',
        duration: Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        onTap: (_) {
          print('Clicked bar');
        },
      )..show(context);

  void movetoSignup() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => signupPage()));
  }
}
