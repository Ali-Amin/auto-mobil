import 'package:flutter/material.dart';
import 'package:grad/common/custom_scaffold.dart';

class CarSelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          children: <Widget>[
            CarCard(
              make: "lorem",
              model: "epsum",
              photoUrl:
                  "https://www.hyundai.com/content/dam/hyundai/au/en/models/tucson/2019/06/active-x/MY18-Tucson-Front34-ActiveX-PureWhite_1000x667.png",
            ),
          ],
        ),
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
      width: 255,
      height: 175,
      color: Theme.of(context).accentColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
    @required this.color,
  }) : super(key: key);
  final Widget child;
  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 20, right: 16),
        decoration: BoxDecoration(
          color: color,
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
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(left: 12),
          height: 30,
          child: Text(
            model,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: Colors.black.withAlpha(200),
            ),
          ),
        )
      ],
    );
  }
}
