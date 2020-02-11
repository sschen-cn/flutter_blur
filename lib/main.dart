import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
Future<void> main() async {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
          Transform.rotate(
            angle: pi,
            child: Image.asset(
              'assets/images/cover.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SafeArea(
                    child: BlurRectWidget(
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                      ),
                      colorO: colorO,
                      colorR: colorR,
                      colorG: colorG,
                      colorB: colorB,
                      sigmaX: double.parse(sigmaX.toString()),
                      sigmaY: double.parse(sigmaY.toString()),
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: <Widget>[
                          //       Text('camera'),
                          //       CupertinoSwitch(
                          //         value:openCamera,
                          //         onChanged: (v) {
                          //           setState(() {
                          //             openCamera = !openCamera;
                          //           });
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          intSelect('sigmaX', sigmaX, max: 50.0, onchange: (v) {
                            setState(() {
                              sigmaX = v.floor();
                            });
                          }),
                          intSelect('sigmaY', sigmaY, max: 50.0, onchange: (v) {
                            setState(() {
                              sigmaY = v.floor();
                            });
                          }),
                          intSelect('rgbo的r', colorR, onchange: (v) {
                            setState(() {
                              colorR = v.floor();
                            });
                          }),
                          intSelect('rgbo的g', colorG, onchange: (v) {
                            setState(() {
                              colorG = v.floor();
                            });
                          }),
                          intSelect('rgbo的b', colorB, onchange: (v) {
                            setState(() {
                              colorB = v.floor();
                            });
                          }),

                          doubleSelect(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]));
  }

  double colorO = 0.3;
  int sigmaX = 10;
  int sigmaY = 10;
  int colorR = 0;
  int colorG = 0;
  int colorB = 0;
  bool openCamera = false;

  Widget intSelect(text1, int intValue,
      {double max = 255, double min = 0, Function onchange}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          width: 70,
          child: Text('$text1'),
        ),
        Expanded(
          child: CupertinoSlider(
            divisions: max.floor(),
              max: max,
              min: min,
              value: double.parse(intValue.toString()),
              onChanged: (v) {
                onchange(v);
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('$intValue'),
        )
      ],
    );
  }

  Widget doubleSelect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          width: 70,
          child: Text('rgbo的o'),
        ),
        Expanded(
          child: CupertinoSlider(
            divisions: 100,
              value: colorO,
              onChanged: (v) {
                setState(() {
                  colorO = v;
                });
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${colorO.toStringAsFixed(2)}'),
        )
      ],
    );
  }
}

class BlurRectWidget extends StatelessWidget {
  final Widget widget;
  final double sigmaX;
  final double sigmaY;
  final int colorR;
  final int colorG;
  final int colorB;
  final double colorO;

  BlurRectWidget(this.widget,
      {this.sigmaX = 10,
      this.sigmaY = 10,
      this.colorR = 0,
      this.colorG = 0,
      this.colorB = 0,
      this.colorO = 0.3});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 50),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: sigmaX,
            sigmaY: sigmaY,
          ),
          child: Container(
              color: Color.fromRGBO(colorR, colorG, colorB, colorO),
              child: widget),
        ),
      ),
    );
  }
}
