import 'package:flutter/material.dart';
import 'package:pure_hydrate/models/settings_model.dart';
import 'package:pure_hydrate/models/water_consumtion_entry_model.dart';
import 'package:pure_hydrate/models/water_intake_model.dart';

class SettingsPage extends StatefulWidget {
  WaterIntake waterIntake;
  SettingsModel? settingsModel;
  Function(bool, int, String, bool) updateSettings;

  final Function(int) onDailyGoalChanged;

  SettingsPage(
      {Key? key,
      required this.waterIntake,
      required this.onDailyGoalChanged,
      required this.updateSettings,
      required this.settingsModel})
      : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _enableReminder;
  late bool _isDarkTheme;
  late int _reminderInterval; // Nilai default untuk interval pengingat (menit)
  late String _reminderSound; // Nilai default untuk nada pengingat

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _enableReminder = widget.settingsModel!.isReminderEnable;
    _isDarkTheme = widget.settingsModel!.isDarkTheme;
    _reminderInterval = widget.settingsModel!.reminderInterval;
    _reminderSound = widget.settingsModel!.reminderSound;
  }

  void _updateSettings(int newInterval, String newSound) {
    setState(() {
      _reminderInterval = newInterval;
      _reminderSound = newSound;
    });
  }

  void _saveSettings() {
    widget.updateSettings(
        _enableReminder, _reminderInterval, _reminderSound, _isDarkTheme);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Settings updated successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Water Reminder',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text('Enable Reminder'),
              value: _enableReminder,
              onChanged: (value) {
                setState(() {
                  _enableReminder = value;
                });
              },
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text(
                'Reminder Interval (minutes)',
              ),
              trailing: DropdownButton<int>(
                value: _reminderInterval,
                onChanged: (int? newValue) {
                  setState(() {
                    _reminderInterval = newValue!;
                  });
                },
                items: <int>[15, 30, 45, 60, 90, 120]
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value minutes'),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text(
                'Reminder Sound',
              ),
              trailing: DropdownButton<String>(
                value: _reminderSound,
                onChanged: (String? newValue) {
                  setState(() {
                    _reminderSound = newValue!;
                  });
                },
                items: <String>['Beep', 'Chime', 'Water Drop', 'Bell']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Text(
              'App Theme',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text('Dark Theme'),
              value: _isDarkTheme,
              onChanged: (bool value) {
                setState(() {
                  _isDarkTheme = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Daily Goal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Slider(
                    value: widget.waterIntake.dailyGoal.toDouble(),
                    min: 1000,
                    max: 5000,
                    divisions: 40,
                    onChanged: (value) {
                      widget.onDailyGoalChanged(
                          widget.waterIntake.dailyGoal.toInt());
                      setState(() {
                        widget.waterIntake.dailyGoal = value.toInt();
                      });
                    },
                  ),
                ),
                Text('${widget.waterIntake.dailyGoal} ml'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveSettings,
              child: Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
