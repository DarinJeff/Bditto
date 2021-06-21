import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/Util/validator.dart';
import 'package:movies/controller/app_state.dart';
import 'package:movies/pages/register.dart';
import 'package:movies/services/fire_auth.dart';
import 'package:movies/pages/home.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final Key _formKey = UniqueKey();
  SnackBar errorSnack = const SnackBar(
    content: Text("Invalid Email or Password provided!"),
    duration: Duration(milliseconds: 1500),
  );

  final AppState appState = GetIt.instance.get<AppState>();

  bool _isVisible = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Show Time',
          style: TextStyle(
              fontFamily: 'DelaGothic', letterSpacing: 1, fontSize: 22),
        ),
      ),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text("Email Id"),
                        TextFormField(
                          controller: _emailController,
                        ),
                        const SizedBox(height: 8.0),
                        const Text("Password"),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.orange),
                          onPressed: () async {
                            if (Validator.validateEmail(
                                    email: _emailController.text) &&
                                Validator.validatePassword(
                                    password: _passwordController.text)) {
                              setState(() {
                                _isVisible = true;
                              });
                              User? user =
                                  await FireAuth.signInUsingEmailPassword(
                                context: context,
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              if (user != null) {
                                appState.setUser(user);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DefaultTabController(
                                              length: 2,
                                              child: Home(),
                                            )));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(errorSnack);
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(errorSnack);
                            }
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.orange),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                      visible: _isVisible,
                      child: JumpingDotsProgressIndicator(
                        milliseconds: 200,
                        fontSize: 40.0,
                        color: Colors.orange,
                      ))
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
}
