import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

const String piBaseUrl = 'http://192.168.100.251:5000';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const SolarCleanerApp());
}

class SolarCleanerApp extends StatelessWidget {
  const SolarCleanerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AUTOMATIC SOLAR PANEL CLEANING SYSTEM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 33, 16, 108),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 33, 16, 108),
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
      ),
      home: const FrontPage(),
    );
  }
}

// PAGE 1: FRONT PAGE
class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/front_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(child: Container(color: Colors.black.withAlpha(0))),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  // TOP SECTION
                  Column(
                    children: [
                      // TITLE
                      const Text(
                        'AUTOMATIC SOLAR PANEL CLEANING SYSTEM',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // LOGO
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(230),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Image.asset('assets/solar_logo.png', height: 90),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // STATUS CARD
                  Container(
                    width: 250,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100.withAlpha(235),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: Colors.blue, size: 28),
                        SizedBox(width: 15),
                        Text(
                          'SYSTEM STATUS: Active',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // BUTTON
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: const Color.fromARGB(255, 32, 111, 43),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SystemPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'VIEW SYSTEM',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// PAGE 2: SYSTEM WORKING PAGE
class SystemPage extends StatelessWidget {
  const SystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    String lastCleanedTime = 'Today at 10:30 AM';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SYSTEM OPERATION',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text(
                    'How the System Works',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OptionsPage(),
                      ),
                    );
                  },
                  child: const Text('OPTIONS'),
                ),
              ],
            ),
            const SizedBox(height: 22),

            systemStep(
              icon: Icons.camera_alt,
              title: '1. Camera Detection',
              description:
                  'The Raspberry Pi camera captures the solar panel surface.',
            ),
            systemStep(
              icon: Icons.image_search,
              title: '2. Dust Analysis',
              description:
                  'The image is processed and compared with a clean reference image.',
            ),
            systemStep(
              icon: Icons.water_drop,
              title: '3. Water Spray',
              description:
                  'If dust is detected, the water pump sprays the panel surface.',
            ),
            systemStep(
              icon: Icons.settings,
              title: '4. Motorized Cleaning',
              description:
                  'The wiper or brush moves across the panel to remove dust.',
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(blurRadius: 5, color: Colors.black12),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.green),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Last Cleaned: $lastCleanedTime',
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget systemStep({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.green, size: 35),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}

// PAGE 3: OPTIONS PAGE
class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  String systemStatus = 'Checking...';
  String mode = 'Unknown';
  String dustLevel = 'Unknown';
  String lastCleaned = 'Not available';
  String pumpStatus = 'OFF';
  String motorStatus = 'OFF';
  bool automaticMode = true;
  bool waterPump = false;
  bool motorCleaner = false;

  List<String> cleaningHistory = [
    'Cleaned today at 10:30 AM',
    'Cleaned yesterday at 04:15 PM',
  ];

  Future<void> getSystemStatus() async {
    final ref = FirebaseDatabase.instance.ref('solar_system');

    final snapshot = await ref.get();

    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);

      setState(() {
        systemStatus = data['system_status'] ?? 'Unknown';
        mode = data['mode'] ?? 'Unknown';
        dustLevel = data['dust_level'] ?? 'Unknown';
        lastCleaned = data['last_cleaned'] ?? 'Not available';
        pumpStatus = data['pump'] ?? 'OFF';
        motorStatus = data['motor'] ?? 'OFF';
      });
    } else {
      setState(() {
        systemStatus = 'No Firebase Data';
      });
    }
  }

  Timer? statusTimer;

  @override
  void initState() {
    super.initState();

    getSystemStatus();

    statusTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      getSystemStatus();
    });
  }

  @override
  void dispose() {
    statusTimer?.cancel();
    super.dispose();
  }

  Widget monitoringCard(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OPTIONS',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          const Text(
            'System Monitoring',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          monitoringCard(
            'System Status',
            systemStatus,
            Icons.power_settings_new,
          ),
          monitoringCard('Mode', mode, Icons.settings),
          monitoringCard('Dust Level', dustLevel, Icons.cloud),
          monitoringCard('Last Cleaned', lastCleaned, Icons.access_time),
          monitoringCard('Water Pump', pumpStatus, Icons.water_drop),
          monitoringCard(
            'Motor Cleaner',
            motorStatus,
            Icons.precision_manufacturing,
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: getSystemStatus,
            child: const Text('Refresh Status'),
          ),
        ],
      ),
    );
  }
}
