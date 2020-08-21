import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/scheduler.dart';
import 'package:confetti/confetti.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  double _sizeH = 0;
  double _sizeW = 0;
  double result;

  double bmiResult() {
    _sizeH /= 100;
    result = _sizeW / (_sizeH * _sizeH);
    return result;
  }

  var _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(
      duration: const Duration(seconds: 10),
    );
    timeDilation = 3;
  }

  @override
  void dispose() {
    super.dispose();
    timeDilation = 1;
    _controller.dispose();
  }

  String tagM = 'male';
  String tagF = 'female';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
            child: Container(
              color: Color.fromARGB(255, 39, 60, 177),
              height: 120,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 0, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'lib/images/male.png',
                          height: 45,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          'BMI Calculator',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 15, 4),
                      child: Text(
                        'Gender',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.indigoAccent,
                            fontWeight: FontWeight.w400),
                      )),
                  Flexible(child: _gender())
                ],
              )),
          Flexible(child: _heightBody()),
          Expanded(child: _weightBody()),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Material(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Color.fromARGB(255, 39, 60, 177),
              child: InkWell(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                splashColor: Colors.indigo[100],
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => _result()));
                  // _controller.play();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    // color: Colors.deepPurple[700]
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  // margin: const EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: Text(
                      'See Result',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _confetti() {
    return ConfettiWidget(
      confettiController: _controller,
      blastDirection: -pi / 2.2,
      particleDrag: 0.05,
      emissionFrequency: 0.03,
      numberOfParticles: 15,
      maxBlastForce: 200,
      minBlastForce: 50,
      gravity: 0.1,
      shouldLoop: false,
      colors: [Colors.pink, Colors.teal, Colors.yellow, Colors.blue],
    );
  }

  Color genderColor = Colors.indigoAccent;
  Color textColor = Colors.white;
  Color genderColor2 = Colors.indigo[100];
  Color textColor2 = Colors.white70;

  bool pressM = true;
  bool pressF = false;

  Widget _gender() {
    print('Gender: M= $pressM F= $pressF');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              if (genderColor == Colors.indigoAccent) {
                pressM = true;
                pressF = false;
                tagM = tagM;
                setState(() {
                  Flushbar(
                          message: 'This has already been selected',
                          backgroundColor: Colors.pink[400],
                          animationDuration: Duration(seconds: 1),
                          duration: Duration(seconds: 3),
                          flushbarPosition: FlushbarPosition.TOP,
                          flushbarStyle: FlushbarStyle.GROUNDED)
                      .show(context);
                });
              } else if (genderColor != Colors.indigoAccent) {
                pressM = true;
                pressF = false;
                tagM = tagM;
                setState(() {
                  genderColor = Colors.indigoAccent;
                  textColor = Colors.white;
                  genderColor2 = Colors.indigo[100];
                  textColor2 = Colors.white70;
                });
              }
            },
            child: Container(
                decoration: BoxDecoration(
                    color: genderColor,
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 8),
                    Flexible(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Hero(
                          tag: tagM,
                          child: Image(
                            image: AssetImage('lib/images/male.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Male',
                        style: TextStyle(
                            fontSize: 16,
                            color: textColor,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 8),
                  ],
                )),
          )),
          Expanded(
              child: GestureDetector(
            onTap: () {
              if (genderColor == Colors.indigoAccent) {
                pressM = false;
                pressF = true;
                tagF = tagF;
                setState(() {
                  genderColor = Colors.indigo[100];
                  textColor = Colors.white70;
                  genderColor2 = Colors.indigoAccent;
                  textColor2 = Colors.white;
                });
              } else if (genderColor != Colors.indigoAccent) {
                pressF = true;
                pressM = false;
                tagF = tagF;
                setState(() {
                  Flushbar(
                          message: 'This has already been selected',
                          backgroundColor: Colors.pink[400],
                          animationDuration: Duration(seconds: 1),
                          duration: Duration(seconds: 3),
                          flushbarPosition: FlushbarPosition.TOP,
                          flushbarStyle: FlushbarStyle.GROUNDED)
                      .show(context);
                });
              }
            },
            child: Container(
                decoration: BoxDecoration(
                    color: genderColor2,
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 8),
                    Flexible(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Hero(
                          tag: tagF,
                          child: Image(
                            image: AssetImage('lib/images/female.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Female',
                        style: TextStyle(
                            fontSize: 16,
                            color: textColor2,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 8),
                  ],
                )),
          ))
        ],
      ),
    );
  }

  _heightBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            // border: Border.all(color: Colors.indigoAccent),
            color: Colors.indigoAccent,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Height',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(height: 8),
            Flexible(
              child: Text(
                (_sizeH.toString().length >= 5)
                    ? _sizeH.toString().replaceAll('.', ',').substring(0, 5) +
                        ' cm'
                    : _sizeH.toString().replaceAll('.', ',') + ' cm',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Flexible(
              child: Slider(
                  value: _sizeH.toDouble(),
                  activeColor: Colors.white,
                  min: 0,
                  max: 200,
                  divisions: 200,
                  inactiveColor: Colors.white70,
                  onChanged: (double value) {
                    setState(() {
                      _sizeH = value;
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _weightBody() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        decoration: BoxDecoration(
            // border: Border.all(color: Colors.indigoAccent),
            color: Colors.indigoAccent,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Weight',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(height: 8),
            Flexible(
              child: Text(
                (_sizeW.toString().length >= 5)
                    ? _sizeW.toString().replaceAll('.', ',').substring(0, 5) +
                        ' kg'
                    : _sizeW.toString().replaceAll('.', ',') + ' kg',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Flexible(
              child: Slider(
                  value: _sizeW.toDouble(),
                  activeColor: Colors.white,
                  min: 0,
                  max: 150,
                  divisions: 150,
                  inactiveColor: Colors.white70,
                  onChanged: (value) {
                    setState(() {
                      _sizeW = value;
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _result() {
    String msgR;
    Text msgB;

    if (bmiResult().toString().length >= 4) {
      msgR = result.toString().substring(0, 4).replaceAll('.', ',');
    } else if (bmiResult().isNaN) {
      msgR = "0,0";
      msgB = Text('...',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400));
    } else {
      msgR = result.toString().replaceAll('.', ',');
    }

    print(result);
    if (pressM == true && pressF == false) {
      if (result > 27) {
        msgB = Text(
          'Overweight',
          style: TextStyle(
              color: Colors.pink, fontSize: 16, fontWeight: FontWeight.w500),
        );
      } else if (result > 23 && result <= 27) {
        msgB = Text(
          'Obesity',
          style: TextStyle(
              color: Colors.amber[700],
              fontSize: 16,
              fontWeight: FontWeight.w500),
        );
      } else if (result >= 17 && result <= 23) {
        msgB = Text(
          'Normal',
          style: TextStyle(
              color: Colors.teal, fontSize: 16, fontWeight: FontWeight.w500),
        );
        _controller.play();
      } else if (result < 17) {
        msgB = Text(
          'Underweight',
          style: TextStyle(
              color: Colors.blue[700],
              fontSize: 16,
              fontWeight: FontWeight.w500),
        );
      }
    } else if (pressF == true && pressM == false) {
      if (result > 27) {
        msgB = Text(
          'Overweight',
          style: TextStyle(
              color: Colors.pink, fontSize: 16, fontWeight: FontWeight.w500),
        );
      } else if (result > 25 && result <= 27) {
        msgB = Text(
          'Obesity',
          style: TextStyle(
              color: Colors.amber[700],
              fontSize: 16,
              fontWeight: FontWeight.w500),
        );
      } else if (result >= 18 && result <= 25) {
        msgB = Text(
          'Normal',
          style: TextStyle(
              color: Colors.teal, fontSize: 16, fontWeight: FontWeight.w500),
        );
        _controller.play();
      } else if (result < 18) {
        msgB = Text(
          'Underweight',
          style: TextStyle(
              color: Colors.blue[700],
              fontSize: 16,
              fontWeight: FontWeight.w500),
        );
      }
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 60, 177),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Flexible(
                child: Container(
                  child: Row(children: [
                    Flexible(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.indigoAccent),
                        child: Text('Your',
                            style:
                                TextStyle(fontSize: 30, color: Colors.white)),
                      ),
                    ),
                    Text(' Summary',
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                  ]),
                ),
              ),
              SizedBox(height: 30),
              Flexible(
                flex: 8,
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: (pressM == true)
                            ? tagM
                            : (pressF == true) ? tagF : '',
                        child: Image(
                          height: 160,
                          image: AssetImage((pressM == true)
                              ? 'lib/images/male.png'
                              : (pressF == true)
                                  ? 'lib/images/female.png'
                                  : ''),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Your BMI is',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Text((bmiResult().isInfinite) ? 'Infinity' : msgR,
                          style: TextStyle(
                              fontSize: 50,
                              color: Colors.indigoAccent,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
                      SizedBox(height: 8),
                      Text(
                        'kg/m2',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 12),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _confetti(),
                            Text(
                              'Your Weight is ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: msgB,
                            ),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                splashRadius: 40,
                                splashColor: Colors.white,
                                highlightColor: Colors.white,
                                icon: Icon(Icons.share,
                                    color: Colors.indigoAccent),
                                onPressed: () {}))),
                    Flexible(
                        child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                color: Colors.indigoAccent,
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                splashRadius: 50,
                                splashColor: Colors.indigoAccent,
                                highlightColor: Colors.indigoAccent,
                                icon: Icon(Icons.cached,
                                    color: Colors.white, size: 30),
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    _sizeH = 0;
                                    _sizeW = 0;
                                  });
                                }))),
                    Flexible(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                splashRadius: 40,
                                splashColor: Colors.white,
                                highlightColor: Colors.white,
                                icon: Icon(Icons.favorite_border,
                                    color: Colors.indigoAccent),
                                onPressed: () {
                                  setState(() {
                                    Flushbar(
                                            message: 'Saved!',
                                            backgroundColor: Colors.teal[400],
                                            animationDuration:
                                                Duration(seconds: 1),
                                            duration: Duration(seconds: 3),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            flushbarStyle:
                                                FlushbarStyle.GROUNDED)
                                        .show(context);
                                  });
                                })))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
