import 'package:flutter/material.dart';
import 'package:grad/common/custom_scaffold.dart';

class ProblemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          shrinkWrap: true,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 12),
                  alignment: Alignment.topCenter,
                  child: Text(
                    "What problems are you having?",
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
            Container(
              alignment: Alignment(0.6, -0.8),
              child: Icon(
                Icons.settings,
                size: 100,
                color: Theme.of(context).buttonColor,
              ),
            ),
            ProblemCard(
                text: "Gear Box",
                colors: [Color(0xFFFFFFFF), Color(0xFFAAAAAA)],
                photoUrl:
                    "https://5.imimg.com/data5/AJ/CU/US/SELLER-18015244/planetary-gearbox-500x500.png"),
            ProblemCard(
              text: "Brakes",
              photoUrl:
                  "https://www.volkswagen-me.com/content/dam/vw-ngw/international-mastersite/after-sales/parts/brakes/Teas_genuine_brake_discs_16-9.png/_jcr_content/renditions/original.transform/med/img.png",
            ),
            ProblemCard(
              text: "Air Conditioning",
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColorDark
              ],
              photoUrl:
                  "https://img1.exportersindia.com/product_images/bc-full/dir_16/472790/car-ac-compressor-1711153.png",
            ),
            ProblemCard(
                text: "Wipers",
                colors: [Color(0xFFFFFFFF), Color(0xFFAAAAAA)],
                photoUrl:
                    "https://images.squarespace-cdn.com/content/v1/54ca715ce4b0b8273342e1c8/1429816523167-QH1PF17Y2UTTLQWS9KFN/ke17ZwdGBToddI8pDm48kAERmMHmAK28yECkpFZcvRdZw-zPPgdn4jUwVcJE1ZvWQUxwkmyExglNqGp0IvTJZUJFbgE-7XRK3dMEBRBhUpx9VOgboofc7CbcNgjLg9IJYf1cF6wm3XAm8tSzM8F2ok10X-eUFnFOLPMSA1h1SDQ/image-asset.png"),
            ProblemCard(
                text: "Headlights",
                colors: [
                  Theme.of(context).buttonColor,
                  Theme.of(context).cardColor
                ],
                photoUrl:
                    "https://cdn.autoteiledirekt.de/uploads/generic/direkt/600x600/259.png"),
            ProblemCard(
              text: "Engine",
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColorDark
              ],
              photoUrl: "http://www.pngmart.com/files/10/Car-Engine-PNG-HD.png",
            ),
            ProblemCard(
                text: "Oil Change",
                colors: [Color(0xFFFFFFFF), Color(0xFFAAAAAA)],
                photoUrl:
                    "https://i.pinimg.com/originals/f5/00/5c/f5005c732ac9ad96ffcb4ac2732ce478.png"),
            ProblemCard(
                text: "Suspension",
                colors: [
                  Theme.of(context).buttonColor,
                  Theme.of(context).cardColor
                ],
                photoUrl:
                    "http://theautopartsstation.com/wp-content/uploads/2018/05/Shock-absorbers-1.png"),
            ProblemCard(
              text: "Diagnosis",
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColorDark
              ],
              photoUrl:
                  "https://a1-auto-body.com/wp-content/uploads/2018/10/service-tab.png",
            ),
          ],
        ),
      ),
    );
  }
}

class ProblemCard extends StatelessWidget {
  final String text;
  final String photoUrl;
  final List<Color> colors;
  const ProblemCard(
      {Key key, @required this.text, @required this.photoUrl, this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      height: 200,
      colors: colors,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 12, right: 20, left: 20),
            alignment: Alignment.center,
            child: ProblemInfo(
              text: text,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 90,
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
    @required this.height,
    @required this.colors,
  }) : super(key: key);
  final Widget child;

  final double height;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 20, right: 16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: colors == null
                    ? Theme.of(context).buttonColor
                    : colors.first,
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

class ProblemInfo extends StatelessWidget {
  final String text;

  const ProblemInfo({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          height: 50,
          child: FittedBox(
            child: Text(
              text,
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
        // Container(
        //   alignment: Alignment.bottomLeft,
        //   padding: const EdgeInsets.only(left: 12),
        //   height: 30,
        //   child: Text(
        //     "model",
        //     style: TextStyle(
        //       fontSize: 20,
        //       fontWeight: FontWeight.w300,
        //       color: Colors.black.withAlpha(200),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
