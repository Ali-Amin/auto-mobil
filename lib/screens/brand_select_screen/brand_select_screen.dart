import 'package:flutter/material.dart';
import 'package:grad/blocs/bloc.dart';
import 'package:grad/common/custom_scaffold.dart';
import 'package:grad/models/brand.dart';
import 'package:grad/models/car.dart';
import 'package:grad/models/car_model.dart';
import 'package:provider/provider.dart';

class BrandSelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Bloc bloc = Provider.of(context);
    return CustomScaffold(
      body: Center(
        child: StreamBuilder<List<Brand>>(
            stream: bloc.brands$,
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              final List<Brand> brands = snapshot.data;
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 44),
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(bottom: 12, left: 24),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Choose Car Make",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: const EdgeInsets.only(left: 24),
                          width: 300,
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
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: brands
                          .map(
                            (brand) => StreamBuilder<Brand>(
                                stream: bloc.selectedBrand$,
                                builder: (context, snapshot) {
                                  final Brand selectedBrand = snapshot.data;
                                  return BrandCard(
                                    brand: brand,
                                    colors: brand.uid == selectedBrand?.uid
                                        ? [
                                            Theme.of(context).accentColor,
                                            Theme.of(context).primaryColorDark
                                          ]
                                        : [
                                            Color(0xFFFFFFFF),
                                            Color(0xFFAAAAAA)
                                          ],
                                    onPressed: () {
                                      bloc.selectBrand(brand);
                                    },
                                  );
                                }),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 44),
                  StreamBuilder<List<CarModel>>(
                      stream: bloc.carModels$,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data.isEmpty)
                          return Container();

                        return Column(
                          children: <Widget>[
                            Container(
                              padding:
                                  const EdgeInsets.only(bottom: 12, left: 24),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Choose Car Model",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: const EdgeInsets.only(left: 24),
                                width: 300,
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
                              ),
                            )
                          ],
                        );
                      }),
                  SizedBox(
                    height: 200,
                    child: StreamBuilder<List<CarModel>>(
                        stream: bloc.carModels$,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.data.isEmpty)
                            return Container();
                          List<CarModel> carModels = snapshot.data;
                          return ListView(
                            physics: BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: carModels
                                .map(
                                  (carModel) => CarModelCard(
                                    carModel: carModel,
                                    colors: [
                                      Color(0xFFFFFFFF),
                                      Color(0xFFAAAAAA)
                                    ],
                                    onPressed: () async {
                                      await bloc.addCar(model: carModel);
                                      Navigator.pop(context);
                                    },
                                  ),
                                )
                                .toList(),
                          );
                        }),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class CarModelCard extends StatelessWidget {
  final CarModel carModel;
  final List<Color> colors;
  final Function() onPressed;
  const CarModelCard({
    Key key,
    @required this.carModel,
    this.colors,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CustomCard(
        height: 100,
        colors: colors,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 100,
              margin: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Image.network(carModel.photoUrl),
            ),
            Text(
              carModel.name,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BrandCard extends StatelessWidget {
  final Brand brand;
  final List<Color> colors;
  final Function() onPressed;
  const BrandCard({
    Key key,
    @required this.brand,
    this.colors,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CustomCard(
        height: 400,
        colors: colors,
        child: Container(
          margin: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Image.network(brand.photoUrl),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({
    Key key,
    @required this.child,
    @required this.height,
    @required this.colors,
  }) : super(key: key);
  final Widget child;

  final double height;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(top: 20, right: 16),
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
