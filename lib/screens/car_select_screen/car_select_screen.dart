import 'package:flutter/material.dart';

class CarSelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          children: <Widget>[
            CarCard(),
            CarCard(),
            CarCard(),
            ProductCard(
              width: 255,
              height: 175,
              color: Colors.blueGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 120,
                    child: HotProductInfo(),
                  ),
                  Container(
                    width: 160,
                    height: 140,
                    alignment: Alignment.centerLeft,
                    child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/grad-f304f.appspot.com/o/addcar3.png?alt=media&token=71a233e2-c5c2-4d26-adac-524c8b769c29",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarCard extends StatelessWidget {
  const CarCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductCard(
      width: 255,
      height: 175,
      color: Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 120,
            child: HotProductInfo(),
          ),
          Container(
            width: 160,
            height: 140,
            alignment: Alignment.centerLeft,
            child: Image.network(
              "https://www.hyundai.com/content/dam/hyundai/au/en/models/tucson/2019/06/active-x/MY18-Tucson-Front34-ActiveX-PureWhite_1000x667.png",
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  ProductCard({
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

class HotProductInfo extends StatelessWidget {
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
              "Hyundai",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
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
            "Tuscon",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: Colors.white.withAlpha(200),
            ),
          ),
        )
      ],
    );
  }
}
