import 'package:flutter/material.dart';
import 'package:pure_hydrate/add_water_page.dart';
import 'package:pure_hydrate/history_page.dart';
import 'package:pure_hydrate/home_page.dart';
import 'package:pure_hydrate/models/settings_model.dart';
import 'package:pure_hydrate/models/water_consumtion_entry_model.dart';
import 'package:pure_hydrate/models/water_intake_model.dart';
import 'package:pure_hydrate/profile_page.dart';
import 'package:pure_hydrate/services/theme.dart';
import 'package:pure_hydrate/setting_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double initialButtonHeight = 8.0;
  late double _buttonOneHeight = initialButtonHeight;
  late double _buttonTwoHeight = initialButtonHeight;
  late double _buttonThreeHeight = initialButtonHeight;
  bool _isPressed = false;

  Map<String, dynamic> _userInfo = {
    'name': 'John Doe',
    'age': 25,
    'weight': 70.0,
    'dailyGoal': 2450,
  };

  late WaterIntake waterIntake = WaterIntake(dailyGoal: _userInfo['dailyGoal']);
  void _updateUserInfo(Map<String, dynamic> updatedInfo) {
    setState(() {
      _userInfo = updatedInfo;
    });
  }

  List<WaterConsumptionEntry> historyEntries = []; // Riwayat konsumsi air

  // Nilai default untuk target konsumsi harian

  void _updateDailyGoal(int newGoal) {
    setState(() {
      waterIntake.dailyGoal = newGoal;
    });
  }

  // Fungsi untuk memperbarui riwayat konsumsi air
  void updateHistory(WaterConsumptionEntry entry) {
    setState(() {
      historyEntries.add(entry); // Menambahkan entri baru ke riwayat
    });
  }

  int _selectedIndex = 0;
  List<Widget>? _widgetOptions;

  void _addWater(int amount) {
    setState(() {
      waterIntake.currentIntake += amount;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _widgetOptions = <Widget>[
      HomePage(
        historyEntries: historyEntries,
        waterIntake: waterIntake,
        onAddWater: _addWater,
      ),
      HistoryPage(
        historyEntries: historyEntries,
      ),
      AddWaterPage(
        onAddWater: _addWater,
        updateHistory: updateHistory,
      ),
      SettingsPage(
        updateSettings: _updateSettings,
        waterIntake: waterIntake,
        onDailyGoalChanged: _updateDailyGoal,
        settingsModel: _settingsModel,
      ),
      ProfilePage(
        userInfo: _userInfo,
        onUpdateUserInfo: _updateUserInfo,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateSettings(
      bool isReminder, int reminderInterval, String sound, bool isDarkTheme) {
    setState(() {
      _settingsModel.isReminderEnable = isReminder;
      _settingsModel.reminderInterval = reminderInterval;
      _settingsModel.reminderSound = sound;
      _settingsModel.isDarkTheme = isDarkTheme;
    });
  }

  SettingsModel _settingsModel = SettingsModel(
      isReminderEnable: true,
      reminderInterval: 60,
      reminderSound: "Beep",
      isDarkTheme: false);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: _settingsModel.isDarkTheme ? darkThemeCustom : lightThemeCustom,
        home: Scaffold(
          body: _widgetOptions!.elementAt(_selectedIndex),
          floatingActionButton: Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 600),
                bottom: _buttonThreeHeight,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: () {
                    // Add your logic here
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                  child: Icon(Icons.settings),
                  backgroundColor: Colors.blue,
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 400),
                bottom: _buttonTwoHeight,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: () {
                    // Add your logic here
                    setState(() {
                      _selectedIndex = 1;
                      buttonAction();
                    });
                  },
                  child: Icon(Icons.history),
                  backgroundColor: Colors.blue,
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                bottom: _buttonOneHeight,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: () {
                    // Add your logic here
                    setState(() {
                      _selectedIndex = 0;
                      buttonAction();
                    });
                  },
                  child: Icon(Icons.home),
                  backgroundColor: Colors.blue,
                ),
              ),
              Positioned(
                bottom: initialButtonHeight,
                right: 16.0,
                child: FloatingActionButton(
                  onPressed: () {
                    // Add your logic here
                    setState(() {
                      buttonAction();
                    });
                  },
                  child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      transitionBuilder: (child, anim) => RotationTransition(
                            turns: child.key == ValueKey('icon1')
                                ? Tween<double>(begin: 1, end: 0.75)
                                    .animate(anim)
                                : Tween<double>(begin: 0.75, end: 1)
                                    .animate(anim),
                            child: ScaleTransition(scale: anim, child: child),
                          ),
                      child: _isPressed
                          ? Icon(Icons.close, key: const ValueKey('icon1'))
                          : Icon(
                              Icons.menu,
                              key: const ValueKey('icon2'),
                            )),
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   items: const <BottomNavigationBarItem>[
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.home),
          //       label: 'Home',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.history),
          //       label: 'History',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.add),
          //       label: 'Add Water',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.settings),
          //       label: 'Settings',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.person),
          //       label: 'Profile',
          //     ),
          //   ],
          //   currentIndex: _selectedIndex,
          //   onTap: _onItemTapped,
          // ),
        ));
  }

  buttonAction() {
    if (!_isPressed) {
      _buttonOneHeight += 80;
      _buttonTwoHeight += 160;
      _buttonThreeHeight += 240;
      _isPressed = true;
    } else {
      _buttonOneHeight = initialButtonHeight;
      _buttonTwoHeight = initialButtonHeight;
      _buttonThreeHeight = initialButtonHeight;
      _isPressed = false;
    }
    ;
  }
}
