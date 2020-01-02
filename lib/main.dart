import 'package:flutter/material.dart';
import 'package:grad/blocs/bloc.dart';
import 'package:grad/screens/confirm_screen/confirm_screen.dart';
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
          fontFamily: "Orbitron",
          primaryColor: Color(0xFF1F1E5A),
          accentColor: Color(0xFFFFDE00),
          primaryColorDark: Color(0xFFFFA500),
          primaryColorLight: Color(0xFF575B9E),
          buttonColor: Color(0xFF72E4FF),
          cardColor: Color(0xFF00BEF1),
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
          case AuthState.Reserved:
          case AuthState.InitialReserved:
            return ConfirmScreen();
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
