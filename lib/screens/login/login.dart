import 'package:flutter/material.dart';
import 'package:grad/blocs/bloc.dart';
import 'package:grad/common/custom_button.dart';
import 'package:grad/common/custom_scaffold.dart';
import 'package:grad/common/custom_text_field.dart';
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
    return CustomScaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.only(top: 100),
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 100),
            CustomTextField(
              controller: emailCont,
              hint: "Email",
              iconData: Icons.email,
            ),
            CustomTextField(
              controller: passCont,
              hint: "Password",
              obscure: true,
              iconData: Icons.lock,
            ),
            SizedBox(height: 35),
                        Align(
              alignment: Alignment.center,
              child: StreamBuilder<String>(
                  stream: bloc.error$,
                  builder: (context, snapshot) {
                    return Visibility(
                      visible: snapshot.hasData,
                      child: Text(
                        snapshot.data ?? "",
                        style: TextStyle(
                          color: Colors.red[500],
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 35),

            CustomButton(
              text: "Sign In",
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColorDark
              ],
              onPressed: () => bloc.signIn(
                email: emailCont.text,
                password: passCont.text,
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              text: "Create an Account",
              onPressed: () {
                bloc.clearErrors();
                return Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SignUpScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
