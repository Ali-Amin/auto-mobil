import 'package:flutter/material.dart';
import 'package:grad/blocs/bloc.dart';
import 'package:grad/screens/screens.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCont;
  TextEditingController passCont;

  @override
  void initState() {
    emailCont = TextEditingController();
    passCont = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailCont.dispose();
    passCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Bloc bloc = Provider.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailCont,
              decoration: InputDecoration(hintText: "Email"),
            ),
            TextField(
              controller: passCont,
              decoration: InputDecoration(hintText: "Password"),
            ),
            MaterialButton(
              child: Text("Sign In"),
              onPressed: () => bloc.signIn(
                email: emailCont.text,
                password: passCont.text,
              ),
            ),
            MaterialButton(
              child: Text("Sign Up"),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SignUpScreen(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
