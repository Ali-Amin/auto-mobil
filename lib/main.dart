import 'package:flutter/material.dart';
import 'package:grad/blocs/bloc.dart';
import 'package:grad/screens/home/home.dart';
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
          primarySwatch: Colors.blue,
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
            return HomeScreen();
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
