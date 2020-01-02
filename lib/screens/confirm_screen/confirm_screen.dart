import 'package:flutter/material.dart';
import 'package:grad/blocs/bloc.dart';
import 'package:grad/common/custom_button.dart';
import 'package:grad/common/custom_scaffold.dart';
import 'package:grad/models/car.dart';
import 'package:provider/provider.dart';

class ConfirmScreen extends StatefulWidget {
  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  bool appointmentNotSet = true;
  TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    final Bloc bloc = Provider.of(context);
    return WillPopScope(
      onWillPop: () async {
        return appointmentNotSet;
      },
      child: CustomScaffold(
        body: StreamBuilder<AuthState>(
            stream: bloc.authState$,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              AuthState state = snapshot.data;
              if (state == AuthState.Reserved ||
                  state == AuthState.InitialReserved) {
                appointmentNotSet = false;
              }
              return ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 44),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        alignment: Alignment.topLeft,
                        child: StreamBuilder<String>(
                          stream: bloc.problem$,
                          builder: (_, snapshot) {
                            if (!snapshot.hasData) return Container();
                            final String problem = snapshot.data;
                            return Column(
                              children: <Widget>[
                                FittedBox(
                                  child: Text(
                                    "Issue:\n$problem",
                                    style: style,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  width: double.infinity,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).buttonColor,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).buttonColor,
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      StreamBuilder<Car>(
                          stream: bloc.selectedCar$,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Container();
                            final Car car = snapshot.data;
                            return Column(
                              children: <Widget>[
                                Container(
                                  child: Image.network(
                                    car.model.photoUrl,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                  ),
                                ),
                                Text(
                                  "${car.brand.name} ${car.model.name}",
                                  style: style,
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                  SizedBox(height: 44),
                  Container(
                    height: 200,
                    child: StreamBuilder<String>(
                        stream: bloc.comment$,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            controller.text = snapshot.data;
                          }
                          return TextField(
                            maxLines: 20,
                            controller: controller,
                            onChanged: bloc.setComment,
                            enabled: appointmentNotSet,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              fillColor: appointmentNotSet
                                  ? Colors.white
                                  : Color(0xFFDDDDDD),
                              filled: true,
                              border: InputBorder.none,
                              labelText: "Comments",
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 44),
                  StreamBuilder<DateTime>(
                      stream: bloc.appointmnetDate$,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return Container();
                        DateTime date = snapshot.data;

                        return Text(
                          "Your reservation is set on ${date.day}.${date.month}.${date.year}\n${date.hour}:00",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white.withAlpha(250), fontSize: 18),
                        );
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  StreamBuilder<DateTime>(
                      stream: bloc.appointmnetDate$,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                            alignment: Alignment.bottomCenter,
                            child: CustomButton(
                              onPressed: () async {
                                setState(() {
                                  appointmentNotSet = false;
                                });
                                await bloc.setAppointment();
                              },
                              colors: [
                                Theme.of(context).accentColor,
                                Theme.of(context).primaryColorDark
                              ],
                              text: "Confirm",
                            ),
                          );
                        } else {
                          return Visibility(
                            visible: DateTime.now()
                                .add(Duration(days: 1))
                                .isBefore(snapshot.data),
                            child: GestureDetector(
                              onTap: () async {
                                await showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        contentPadding:
                                            const EdgeInsets.all(24),
                                        titlePadding: const EdgeInsets.all(24),
                                        title: Text("Warning"),
                                        content: Text(
                                            "Are you sure you want to cancel this reservation?"),
                                        actions: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              bloc.cancelAppointment();
                                              Navigator.pop(context);
                                              if (state !=
                                                  AuthState.InitialReserved) {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                bottom: 16,
                                                right: 16,
                                              ),
                                              child: Text(
                                                "YES",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                bottom: 16,
                                                right: 16,
                                              ),
                                              child: Text(
                                                "NO",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: Text(
                                "cancel",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey.withAlpha(200),
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          );
                        }
                      })
                ],
              );
            }),
      ),
    );
  }
}
