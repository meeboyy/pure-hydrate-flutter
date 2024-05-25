import 'package:flutter/material.dart';
import 'package:pure_hydrate/models/water_consumtion_entry_model.dart';

class HistoryPage extends StatelessWidget {
  List<WaterConsumptionEntry> historyEntries;

  HistoryPage({Key? key, required this.historyEntries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: historyEntries.length,
        itemBuilder: (context, index) {
          final entry = historyEntries[index];
          return ListTile(
            title: Text('Date: ${entry.timestamp}',
                style: TextStyle(fontSize: 16)),
            subtitle: Text('Amount: ${entry.amount} ml',
                style: TextStyle(fontSize: 14)),
          );
        },
      ),
    );
  }
}
