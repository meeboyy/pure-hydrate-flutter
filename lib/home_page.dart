import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pure_hydrate/models/water_consumtion_entry_model.dart';
import 'package:pure_hydrate/models/water_intake_model.dart';
import 'package:pure_hydrate/services/clipper.dart';

class HomePage extends StatefulWidget {
  final List<WaterConsumptionEntry>? historyEntries;
  final WaterIntake waterIntake;
  final Function(int) onAddWater;
  const HomePage(
      {Key? key,
      required this.waterIntake,
      required this.historyEntries,
      required this.onAddWater})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // late AnimationController _controller;
  bool _isNotDrink = true;
  late double _downBone;
  late double _downBtwo;
  late int remainWater;

  var pixelRatio = window.devicePixelRatio;
  Size logicalScreenSize = WidgetsBinding.instance.window.physicalSize /
      WidgetsBinding.instance.window.devicePixelRatio;
  late double _waterHeight;
  double _glassHeight = WidgetsBinding.instance.window.physicalSize.height;
  double _glassWidth = WidgetsBinding.instance.window.physicalSize.width;
  late AnimationController firstController;
  late Animation<double> firstAnimation;

  late AnimationController secondController;
  late Animation<double> secondAnimation;

  late AnimationController thirdController;
  late Animation<double> thirdAnimation;

  late AnimationController fourthController;
  late Animation<double> fourthAnimation;

  List<WaterConsumptionEntry>? todayEntries;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _downBone = 20;
    _downBtwo = 20;

    todayEntries = getTodayEntries();
    firstController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    firstAnimation = Tween<double>(begin: 10, end: 8).animate(
        CurvedAnimation(parent: firstController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          firstController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          firstController.forward();
        }
      });

    secondController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    secondAnimation = Tween<double>(begin: 20, end: 0).animate(
        CurvedAnimation(parent: secondController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          secondController.forward();
        }
      });

    thirdController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    thirdAnimation = Tween<double>(begin: 20, end: 0).animate(
        CurvedAnimation(parent: thirdController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          thirdController.forward();
        }
      });

    fourthController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    fourthAnimation = Tween<double>(begin: 10, end: 8).animate(
        CurvedAnimation(parent: fourthController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          fourthController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          fourthController.forward();
        }
      });

    Timer(Duration(seconds: 2), () {
      firstController.forward();
    });

    Timer(Duration(milliseconds: 1600), () {
      secondController.forward();
    });

    Timer(Duration(milliseconds: 800), () {
      thirdController.forward();
    });

    fourthController.forward();
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();
    super.dispose();
  }

  List<WaterConsumptionEntry> getTodayEntries() {
    DateTime now = DateTime.now();
    return widget.historyEntries!.where((entry) {
      return entry.timestamp.year == now.year &&
          entry.timestamp.month == now.month &&
          entry.timestamp.day == now.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    remainWater =
        widget.waterIntake.dailyGoal - widget.waterIntake.currentIntake;
    int progress = ((remainWater / widget.waterIntake.dailyGoal) * 100).toInt();
    progress <= 0 ? progress = 0 : progress;

    double percWater = progress / 100 * logicalScreenSize.height;
    double decrWater = logicalScreenSize.height - percWater;

    _waterHeight = logicalScreenSize.height - decrWater;
    _waterHeight <= 0 ? _waterHeight = 0 : _waterHeight;

    void _addWater(int amount) {
      setState(() {
        widget.waterIntake.currentIntake += amount;
      });
    }

    // void _navigateToAddWaterPage() {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => AddWaterPage(onAddWater: _addWater),
    //     ),
    //   );
    // }

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: _glassHeight,
            alignment: Alignment.center,
            child: Text(
              "${progress.toString()}%",
              style: TextStyle(fontSize: 80),
            ),
          ),
          Positioned(
            top: 90,
            child: Visibility(
                visible: progress <= 0 ? true : false,
                child: Text("Congratulation!! You Finish Today's Goal ")),
          ),
          AnimatedContainer(
            curve: Curves.easeInOut,
            height: _waterHeight,
            width: _glassWidth,
            duration: Duration(milliseconds: 1500),
            child: CustomPaint(
              painter: MyPainter(
                firstAnimation.value,
                secondAnimation.value,
                thirdAnimation.value,
                fourthAnimation.value,
              ),
            ),
          ),
          // Container(
          //   color: Colors.transparent,
          //   child: CustomPaint(
          //     painter: BorderPainter(),
          //   ),
          //   width: _glassWidth,
          //   height: _glassHeight,
          // ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Today\'s Water Intake',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Daily Goal: ${widget.waterIntake.dailyGoal} ml',
                    style: TextStyle(fontSize: 20),
                  ),
                  // SizedBox(height: 20),
                  // SizedBox(
                  //   height: 200,
                  //   width: 200,
                  //   child: CircularProgressIndicator(
                  //     value: progress,
                  //     strokeWidth: 20,
                  //     backgroundColor: Colors.grey[300],
                  //     valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  //   ),
                  // ),

                  SizedBox(height: 20),

                  // SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: () => _addWater(500),
                  //   child: Text('Add 500 ml'),
                  // ),
                ]),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            bottom: _downBone,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  widget.onAddWater(250);
                });
              },
              child: Text(' 250 ml'),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            bottom: _downBtwo,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  _waterHeight >= 200 ? _waterHeight -= 200 : _waterHeight = 0;
                  remainWater = remainWater - 500;
                });
              },
              child: Text('500 ml'),
            ),
          ),
          Positioned(
            bottom: 20,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  buttonAction();
                });
              },
              child: Text('DRINK'),
            ),
          )
        ],
      ),
    );
  }

  buttonAction() {
    if (_isNotDrink) {
      _downBone = 120;
      _downBtwo = 70;
      _isNotDrink = false;
    } else {
      _downBone = 20;
      _downBtwo = 20;
      _isNotDrink = true;
    }
    ;
  }
}

class MyPainter extends CustomPainter {
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double fourthValue;

  MyPainter(
    this.firstValue,
    this.secondValue,
    this.thirdValue,
    this.fourthValue,
  );

  double one = 8;
  double two = 0;
  double three = 8;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 124, 161, 225).withOpacity(.8),
          Color.fromARGB(255, 0, 92, 197).withOpacity(.8),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, firstValue)
      ..cubicTo(size.width * .4, secondValue, size.width * .7, thirdValue,
          size.width, fourthValue)
      ..lineTo(size.width, size.height)
      // ..quadraticBezierTo(
      //     size.width * 0.99, size.height, size.width * 0.5, size.height)
      // ..quadraticBezierTo(size.width * 0.01, size.height, 0, size.height * 0.9)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class AirMengalirPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Gambar jalur air yang mengalir menggunakan metode `drawPath`
    // Gunakan warna biru muda dan atur ketebalan garis
    // Anda dapat menambahkan variasi pada jalur air untuk membuatnya lebih realistis

    final paint = Paint()
      ..color = Colors.lightBlue
      ..strokeWidth = 2.0;

    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
