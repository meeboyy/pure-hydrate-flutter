import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pure_hydrate/models/water_consumtion_entry_model.dart';
import 'package:pure_hydrate/models/water_intake_model.dart';
import 'package:pure_hydrate/services/clipper.dart';

class HomePage extends StatefulWidget {
  final List<WaterConsumptionEntry>? historyEntries;
  final WaterIntake waterIntake;
  const HomePage(
      {Key? key, required this.waterIntake, required this.historyEntries})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // late AnimationController _controller;
  double _waterHeight = 200;
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
    todayEntries = getTodayEntries();
    firstController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    firstAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
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
    secondAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
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
    thirdAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
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
    fourthAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
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
    double progress =
        widget.waterIntake.currentIntake / widget.waterIntake.dailyGoal;
    progress = progress > 1 ? 1 : progress;

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
      appBar: AppBar(
        title: Text('Water Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Daily Goal: ${widget.waterIntake.dailyGoal} ml',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Today\'s Water Intake',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
              Text(
                '${widget.waterIntake.currentIntake} / ${widget.waterIntake.dailyGoal} ml',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipPath(
                    clipper: BottleClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(width: 2)),
                      width: 200,
                      height: 200,
                    ),
                  ),
                  ClipPath(
                    clipper: BottleClipper(),
                    child: AnimatedContainer(
                      width: 200,
                      height: _waterHeight,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 1000),
                      child: CustomPaint(
                        painter: MyPainter(
                          firstAnimation.value,
                          secondAnimation.value,
                          thirdAnimation.value,
                          fourthAnimation.value,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _waterHeight >= 0 ? _waterHeight -= 50 : _waterHeight = 0;
                  });
                },
                child: Text('Add 250 ml'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _addWater(500),
                child: Text('Add 500 ml'),
              ),
              // SizedBox(height: 40),
              // ElevatedButton(
              //   onPressed: _navigateToAddWaterPage,
              //   child: Text('Add Water'),
              // ),
              SizedBox(height: 20),
              Text(
                'Riwayat minum air hari ini :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: todayEntries?.length,
                  itemBuilder: (context, index) {
                    if (todayEntries!.isNotEmpty) {
                      final entry = todayEntries![index];
                      return ListTile(
                        title: Text('Jumlah: ${entry.amount} ml'),
                        subtitle: Text(
                            'Jam: ${entry.timestamp.hour}:${entry.timestamp.minute}'),
                      );
                    }
                    return Text("Hari ini belum minum");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xff3B6ABA).withOpacity(.8)
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, 35 / firstValue)
      ..cubicTo(size.width * .4, 20 / secondValue, size.width * .7,
          30 / thirdValue, size.width, 35 / fourthValue)
      ..lineTo(size.width, size.height)
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
