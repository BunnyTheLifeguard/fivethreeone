import 'package:flutter/material.dart';
import '../globals.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final deadliftController = TextEditingController();
  final squatController = TextEditingController();
  final benchpressController = TextEditingController();
  final overheadpressController = TextEditingController();
  final timerController = TextEditingController();

  @override
  void dispose() {
    deadliftController.dispose();
    squatController.dispose();
    benchpressController.dispose();
    overheadpressController.dispose();
    timerController.dispose();
    super.dispose();
  }

  void updateDL() {
    print("Update DL");
  }

  void updateSQ() {
    print("Update DS");
  }

  void updateBP() {
    print("Update BP");
  }

  void updateOH() {
    print("Update OH");
  }

  void updateTimer() {
    countdownDuration = Duration(minutes: int.parse(timerController.text));
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(countdownDuration.inMinutes.remainder(60));
    final seconds = strDigits(countdownDuration.inSeconds.remainder(60));

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DataTable(columns: const [
              DataColumn(label: Expanded(child: Text("Exercise"))),
              DataColumn(label: Expanded(child: Text("1 RM"))),
              DataColumn(label: Expanded(child: Text("Edit")))
            ], rows: [
              DataRow(cells: [
                const DataCell(Text("Deadlifts")),
                DataCell(Text("$deadliftsMax")),
                DataCell(IconButton(
                    onPressed: updateDL, icon: const Icon(Icons.edit)))
              ]),
              DataRow(cells: [
                const DataCell(Text("Squats")),
                DataCell(Text("$squatsMax")),
                DataCell(IconButton(
                    onPressed: updateSQ, icon: const Icon(Icons.edit)))
              ]),
              DataRow(cells: [
                const DataCell(Text("Benchpress")),
                DataCell(Text("$benchpressMax")),
                DataCell(IconButton(
                    onPressed: updateBP, icon: const Icon(Icons.edit)))
              ]),
              DataRow(cells: [
                const DataCell(Text("Overhead Press")),
                DataCell(Text("$overheadpressMax")),
                DataCell(IconButton(
                    onPressed: updateOH, icon: const Icon(Icons.edit)))
              ])
            ]),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Timer"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 70,
                child: TextField(
                  enabled: false,
                  textAlign: TextAlign.center,
                  controller: timerController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "$minutes:$seconds"),
                ),
              ),
            ),
            IconButton(onPressed: updateTimer, icon: const Icon(Icons.edit))
          ],
        )
      ],
    );
  }
}
