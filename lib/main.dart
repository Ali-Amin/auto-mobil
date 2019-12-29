import 'package:flutter/material.dart';
import 'package:grad/blocs/bloc.dart';
import 'package:grad/screens/problem/problem.dart';
import 'package:grad/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Bloc bloc = Bloc();
    return Provider<Bloc>.value(
      value: bloc,
      child: MaterialApp(
        routes: {"/": _buildHome},
        theme: ThemeData(
          primaryColor: Color(0xFF1F1E5A),
          accentColor: Color(0xFFFFBC00),
          primaryColorLight: Color(0xFF464A8D),
          buttonColor: Color(0xFF00D0FC),
        ),
      ),
    );
  }

  Widget _buildHome(BuildContext context) {
    final Bloc bloc = Provider.of(context);
    return StreamBuilder<AuthState>(
      stream: bloc.authState$,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final state = snapshot.data;
        switch (state) {
          case AuthState.Unauthenticated:
            return LoginScreen();
          case AuthState.Authenticated:
            return ProblemScreen();
          default:
            return Scaffold(
              body: Center(
                child: Text(state.toString()),
              ),
            );
        }
      },
    );
  }
}
