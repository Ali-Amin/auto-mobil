import 'package:flutter/material.dart';
import 'package:grad/blocs/bloc.dart';
import 'package:grad/common/custom_button.dart';
import 'package:grad/common/custom_scaffold.dart';
import 'package:grad/common/custom_text_field.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Bloc bloc = Provider.of(context);
    return CustomScaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.only(top: 100),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 50),
              alignment: Alignment.topCenter,
              child: Text(
                "Create an Account",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
                width: 200,
                height: 70,
                padding: const EdgeInsets.only(left: 20),
                child: GenderSelect()),
            CustomTextField(
              hint: "Full Name",
              iconData: Icons.person,
              onChanged: bloc.changeSignUpName,
            ),
            CustomTextField(
              hint: "Phone Number",
              iconData: Icons.phone,
              keyboardType: TextInputType.number,
              onChanged: bloc.changeSignUpPhoneNumber,
            ),
            CustomTextField(
              hint: "Email",
              iconData: Icons.email,
              onChanged: bloc.changeSignUpEmail,
            ),
            CustomTextField(
              hint: "Password",
              iconData: Icons.lock_outline,
              obscure: true,
              onChanged: bloc.changeSignUpPassword,
            ),
            CustomTextField(
              hint: "Re-enter Password",
              iconData: Icons.lock,
              obscure: true,
              onChanged: bloc.changeSignUpConfirmPassword,
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
                text: "Create an Account",
                onPressed: () {
                  bloc.clearErrors();
                  bloc.signUp();
                })
          ],
        ),
      ),
    );
  }
}

class GenderSelect extends StatefulWidget {
  @override
  _GenderSelectState createState() => _GenderSelectState();
}

class _GenderSelectState extends State<GenderSelect> {
  String _selectedGender = "Mr.";
  @override
  Widget build(BuildContext context) {
    final Bloc bloc = Provider.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: RadioListTile(
            groupValue: _selectedGender,
            value: "Mr.",
            title: Text(
              "Mr.",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onChanged: (String gender) {
              bloc.changeGender(gender);
              setState(() => _selectedGender = gender);
            },
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: RadioListTile(
            groupValue: _selectedGender,
            value: "Mrs.",
            title: Text(
              "Mrs.",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onChanged: (String gender) {
              bloc.changeGender(gender);
              setState(() => _selectedGender = gender);
            },
          ),
        ),
      ],
    );
  }
}
