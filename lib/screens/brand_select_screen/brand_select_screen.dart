import 'package:flutter/material.dart';
import 'package:grad/blocs/bloc.dart';
import 'package:grad/common/custom_scaffold.dart';
import 'package:grad/models/brand.dart';
import 'package:grad/screens/problem/problem.dart';
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Choose Brand"),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: brands
                          .map(
                            (brand) => BrandCard(
                              brand: brand,
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ProblemScreen(),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class BrandCard extends StatelessWidget {
  final Brand brand;
  final Function() onPressed;
  const BrandCard({Key key, @required this.brand, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: 200,
        alignment: Alignment.center,
        child: Image(
          image: NetworkImage(brand.photoUrl),
        ),
      ),
    );
  }
}
