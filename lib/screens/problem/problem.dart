import 'package:flutter/material.dart';
import 'package:grad/screens/car_select_screen/car_select_screen.dart';

class ProblemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CarSelectScreen(),
                  ),
                );
              },
              child: Container(
                color: Colors.blue,
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Breaks",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Engine",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Suspension",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Oil Change",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Body Work",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Onboard Computer",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Interior",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Gauges",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Breaks",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Breaks",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Breaks",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Breaks",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Breaks",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Breaks",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Breaks",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Breaks",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Breaks",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.blue,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Breaks",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
