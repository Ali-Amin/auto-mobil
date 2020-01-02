import 'package:flutter/material.dart';
import 'package:grad/blocs/bloc.dart';
import 'package:grad/common/custom_scaffold.dart';
import 'package:grad/models/user.dart';
import 'package:grad/screens/brand_select_screen/brand_select_screen.dart';
import 'package:grad/screens/confirm_screen/confirm_screen.dart';
import 'package:provider/provider.dart';

class CarSelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Bloc bloc = Provider.of(context);
    return CustomScaffold(
      body: Center(
        child: StreamBuilder<User>(
            stream: bloc.user$,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              final User user = snapshot.data;
              return ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: 20),
                children: [
                  Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(bottom: 12),
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Choose your vehicle",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
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
                  ),
                  ...user.cars
                      .map(
                        (car) => GestureDetector(
                          onTap: () {
                            bloc.selectCar(car);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ConfirmScreen(),
                            ));
                          },
                          child: Center(
                            child: CarCard(
                              model: car.model.name,
                              make: car.brand.name,
                              photoUrl: car.model.photoUrl,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BrandSelectScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: CarCard(
                          make: "Add   ",
                          model: "Add a car",
                          photoUrl:
                              "https://clipartion.com/wp-content/uploads/2015/12/car-clipart-free-830x305.png"),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class CarCard extends StatelessWidget {
  final String make;
  final String model;
  final String photoUrl;
  const CarCard({
    Key key,
    @required this.make,
    @required this.model,
    @required this.photoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      width: 400,
      height: 175,
      colors: [
        Theme.of(context).accentColor,
        Theme.of(context).primaryColorDark
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 160,
            child: CarInfo(
              make: make,
              model: model,
            ),
          ),
          Container(
            width: 200,
            height: 140,
            alignment: Alignment.centerLeft,
            child: Image.network(photoUrl),
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({
    Key key,
    @required this.child,
    @required this.width,
    @required this.height,
    this.colors,
  }) : super(key: key);
  final Widget child;
  final double width;
  final double height;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color:
                  colors == null ? Theme.of(context).buttonColor : colors.first,
              blurRadius: 2),
        ],
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors ??
                [
                  Theme.of(context).buttonColor,
                  Theme.of(context).cardColor,
                ]),
        borderRadius: BorderRadius.circular(20),
      ),
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          child,
          Align(
            alignment: Alignment.bottomRight,
            child: _ArrowIcon(),
          ),
        ],
      ),
    );
  }
}

class _ArrowIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(40),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Icon(
        Icons.arrow_forward,
        color: Colors.white.withAlpha(200),
      ),
    );
  }
}

class CarInfo extends StatelessWidget {
  final String make;
  final String model;

  const CarInfo({
    Key key,
    @required this.make,
    @required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 100,
          padding: const EdgeInsets.only(top: 8, left: 12),
          child: FittedBox(
            child: Text(
              make,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(left: 12),
          height: 20,
          child: Text(
            model,
            maxLines: 3,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).primaryColor.withAlpha(200),
            ),
          ),
        )
      ],
    );
  }
}
