import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:toggle_bar/toggle_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double height, weight, inch;

  double result = 0;
  int counter = 0;
  bool change = true;
  String text = "";
  Color _color = Colors.white;
  List<String> labels = ["Metric(kg/cm2)","Standard(lb/inch2)"];
  List<String> texts = ["Underweight", "Normal", "Overweight", "Obese"];
  List<Color> color = [
    Colors.redAccent,
    Colors.green,
    Colors.deepOrange,
    Colors.red
  ];


  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: change ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("BMI Calculator",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (!isKeyboard)
                ToggleBar(
                  labels: labels,
                  textColor: Colors.black54,
                  selectedTextColor: Colors.white,
                  backgroundColor: Colors.lightBlue,
                  onSelectionUpdated: (index) {
                    counter = index;
                  },
                ),
              SizedBox(height: 5.0),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 6.0, 0.0),
                child: Text(
                  "Metric: Put in kg and Cm\nStandard: Put in Pounds and Inches",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),


                ),

              ),
              Container(
                alignment: Alignment.topRight,
                child: Switch(
                    value: change,
                    onChanged: (val) {
                      setState(() {
                        change = val;
                      });
                    }),
              ),
              Container(
                width: 200.0,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.purpleAccent, // set border color
                      width: 3.0), // set border width
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: TextField(
                  onChanged: (value) {
                    weight = double.parse(value);
                  },
                  style: TextStyle(color: Colors.blue),
                  decoration: InputDecoration(
                    hintText: "Weight",
                    hintStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 0.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                height: 33.0,
              ),
              Container(
                width: 200.0,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.purpleAccent, // set border color
                      width: 3.0), // set border width
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: TextField(
                  onChanged: (value) {
                    height = double.parse(value);

                  },
                  style: TextStyle(color: Colors.blue),
                  decoration: InputDecoration(
                    hintText: "Height",
                    hintStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                height: 28.0,
              ),
              Container(
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (labels[counter] == "Standard(lb/inch2)") {
                          result = 703 *( weight / (height * height));

                        } else {
                          result = weight / ((height / 100) * (height / 100));

                        }
                        if (result <= 18.5) {
                          text = texts[0];
                          _color = color[0];
                        } else if (result >= 18.50 && result <= 24.99) {
                          text = texts[1];
                          _color = color[1];
                        } else if (result >= 25.00 && result <= 29.99) {
                          text = texts[2];
                          _color = color[2];
                        } else {
                          text = texts[3];
                          _color = color[3];
                        }
                      });
                    },
                    child: Text(
                      "Check",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0),
                    )),
              ),
              SizedBox(
                height: 23.0,
              ),
              Text(
                "Your BMI: ${result.toStringAsPrecision(4).toString()}",
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
              ),
              SizedBox(
                height: 23.0,
              ),
              Container(
                child: Text(
                  text,
                  style: TextStyle(
                      color: _color,
                      letterSpacing: 2.4,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
