import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userInfo;
  final Function(Map<String, dynamic>) onUpdateUserInfo;

  ProfilePage({required this.userInfo, required this.onUpdateUserInfo});

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditUserDialog(
          userInfo: userInfo,
          onUpdateUserInfo: onUpdateUserInfo,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Name: ${userInfo['name']}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'Age: ${userInfo['age']}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'Weight: ${userInfo['weight']} kg',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'Daily Goal: ${userInfo['dailyGoal']} ml',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _showEditDialog(context),
            child: Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}

class EditUserDialog extends StatefulWidget {
  final Map<String, dynamic> userInfo;
  final Function(Map<String, dynamic>) onUpdateUserInfo;

  EditUserDialog({required this.userInfo, required this.onUpdateUserInfo});

  @override
  _EditUserDialogState createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late int _age;
  late double _weight;
  late int _dailyGoal;

  @override
  void initState() {
    super.initState();
    _name = widget.userInfo['name'];
    _age = widget.userInfo['age'];
    _weight = widget.userInfo['weight'];
    _dailyGoal = widget.userInfo['dailyGoal'];
  }

  int _calculateDailyGoal(double weight) {
    return (weight * 35).toInt(); // Simple formula: 35 ml per kg of body weight
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final updatedUserInfo = {
        'name': _name,
        'age': _age,
        'weight': _weight,
        'dailyGoal': _calculateDailyGoal(_weight),
      };
      widget.onUpdateUserInfo(updatedUserInfo);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Profile'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              initialValue: _age.toString(),
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }
                if (int.tryParse(value) == null || int.parse(value) <= 0) {
                  return 'Please enter a valid age';
                }
                return null;
              },
              onSaved: (value) {
                _age = int.parse(value!);
              },
            ),
            TextFormField(
              initialValue: _weight.toString(),
              decoration: InputDecoration(labelText: 'Weight (kg)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your weight';
                }
                if (double.tryParse(value) == null ||
                    double.parse(value) <= 0) {
                  return 'Please enter a valid weight';
                }
                return null;
              },
              onSaved: (value) {
                _weight = double.parse(value!);
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveChanges,
          child: Text('Save'),
        ),
      ],
    );
  }
}
