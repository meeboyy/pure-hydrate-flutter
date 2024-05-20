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
  final WaterIntake waterIntake;

  MyHomePage({super.key, required this.waterIntake});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> _userInfo = {
    'name': 'John Doe',
    'age': 25,
    'weight': 70.0,
    'dailyGoal': 2450,
  };

  void _updateUserInfo(Map<String, dynamic> updatedInfo) {
    setState(() {
      _userInfo = updatedInfo;
    });
  }

  List<WaterConsumptionEntry> historyEntries = []; // Riwayat konsumsi air

  // Nilai default untuk target konsumsi harian

  void _updateDailyGoal(int newGoal) {
    setState(() {
      widget.waterIntake.dailyGoal = newGoal;
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
      widget.waterIntake.currentIntake += amount;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _widgetOptions = <Widget>[
      HomePage(
        historyEntries: historyEntries,
        waterIntake: widget.waterIntake,
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
        waterIntake: widget.waterIntake,
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
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add Water',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ));
  }
}
