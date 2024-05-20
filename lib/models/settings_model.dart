class SettingsModel {
  bool isReminderEnable;
  int reminderInterval;
  String reminderSound;
  bool isDarkTheme;

  SettingsModel({
    required this.isReminderEnable,
    required this.reminderInterval,
    required this.reminderSound,
    required this.isDarkTheme,
  });
}
