import 'package:flutter/material.dart';
import 'package:pure_hydrate/models/water_consumtion_entry_model.dart';

class AddWaterPage extends StatefulWidget {
  final Function(int) onAddWater;
  final Function(WaterConsumptionEntry) updateHistory;
  AddWaterPage(
      {Key? key, required this.onAddWater, required this.updateHistory})
      : super(key: key);

  @override
  _AddWaterPageState createState() => _AddWaterPageState();
}

class _AddWaterPageState extends State<AddWaterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _waterController = TextEditingController();
  int _selectedPreset = -1;

  final List<int> _presetAmounts = [250, 500, 750, 1000];

  void _submit() {
    if (_formKey.currentState!.validate()) {
      int amount = int.parse(_waterController.text);
      if (_selectedPreset != -1) {
        amount = _presetAmounts[_selectedPreset];
      }
      widget.onAddWater(amount);
      _updateHistory(amount);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Water added successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _updateHistory(int amount) {
    final entry =
        WaterConsumptionEntry(timestamp: DateTime.now(), amount: amount);
    widget.updateHistory(entry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Water Intake'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Enter amount of water (ml)',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _waterController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount (ml)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Or select a preset amount',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              // Daftar preset amount
              ListView.builder(
                shrinkWrap: true,
                itemCount: _presetAmounts.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile<int>(
                    title: Text('${_presetAmounts[index]} ml'),
                    value: index,
                    groupValue: _selectedPreset,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedPreset = value!;
                        _waterController.text = _presetAmounts[value]
                            .toString(); // Kosongkan nilai input
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
