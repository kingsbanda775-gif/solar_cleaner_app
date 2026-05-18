import 'package:flutter/material.dart';

void main() {
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
        scaffoldBackgroundColor: const Color.fromARGB(0, 3, 3, 3),
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
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.0)),
          ),
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
                          color: Colors.white.withOpacity(0.9),
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
                      color: Colors.green.shade100.withOpacity(0.92),
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
  bool automaticMode = true;
  bool waterPump = false;
  bool motorCleaner = false;

  void startManualCleaning() {
    setState(() {
      waterPump = true;
      motorCleaner = true;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Manual cleaning started')));
  }

  void stopManualCleaning() {
    setState(() {
      waterPump = false;
      motorCleaner = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Manual cleaning stopped')));
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
            'SETTINGS',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SwitchListTile(
            title: const Text('Automatic Cleaning Mode'),
            subtitle: const Text(
              'System cleans automatically when dust is detected',
            ),
            value: automaticMode,
            onChanged: (value) {
              setState(() {
                automaticMode = value;
              });
            },
          ),

          const Divider(),

          const Text(
            'MANUAL OPERATION',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: Icon(
              waterPump ? Icons.water_drop : Icons.water_drop_outlined,
              color: waterPump ? Colors.green : Colors.grey,
            ),
            title: Text('Water Pump: ${waterPump ? "ON" : "OFF"}'),
          ),
          ListTile(
            leading: Icon(
              motorCleaner ? Icons.settings : Icons.settings_outlined,
              color: motorCleaner ? Colors.green : Colors.grey,
            ),
            title: Text('Motor Cleaner: ${motorCleaner ? "ON" : "OFF"}'),
          ),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: startManualCleaning,
                  child: const Text('Start Cleaning'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: stopManualCleaning,
                  child: const Text('Stop'),
                ),
              ),
            ],
          ),

          const Divider(height: 40),
        ],
      ),
    );
  }
}
