import 'dart:async';
import 'package:five_three_one/pages/settings.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FiveThreeOne());
}

class FiveThreeOne extends StatelessWidget {
  const FiveThreeOne({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: remove wakelock
    Wakelock.enable();
    return MaterialApp(
      title: '5/3/1',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.red,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.white)),
      ),
      home: const HomePage(title: '5/3/1'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Graphs',
      style: optionStyle,
    ),
    Text(
      'Index 1: Weekly Routine',
      style: optionStyle,
    ),
    SettingsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Timer? countdownTimer;
  Duration countdownDuration = const Duration(minutes: 2);

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountdown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => countdownDuration = const Duration(minutes: 2));
  }

  void setCountdown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = countdownDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        countdownDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(countdownDuration.inMinutes.remainder(60));
    final seconds = strDigits(countdownDuration.inSeconds.remainder(60));

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.alarm),
        title: Text(
          '$minutes:$seconds',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: startTimer, icon: const Icon(Icons.play_arrow)),
          IconButton(
              onPressed: () {
                if (countdownTimer == null || countdownTimer!.isActive) {
                  stopTimer();
                }
              },
              icon: const Icon(Icons.pause)),
          IconButton(
              onPressed: () {
                resetTimer();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _widgetOptions.elementAt(_selectedIndex),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: "Routine"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
