import 'package:flutter/material.dart';

class VehicleDetailsPage extends StatelessWidget {
  final Map<String, String> vehicle;

  const VehicleDetailsPage({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (vehicle['title'] ?? '').toUpperCase().substring(0, 1) +
              (vehicle['title'] ?? '').substring(1).toLowerCase(),
          style: const TextStyle(fontSize: 17),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              vehicle["image"]!,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle["title"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          vehicle["location"]!,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 118, 117, 117),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          vehicle["range"]!,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 118, 117, 117),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    vehicle["price"]!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              vehicle["content"]!,
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 118, 117, 117),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Vehicle Features",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Column(
                  children: [
                    Icon(Icons.directions_car, color: Colors.black, size: 32),
                    Text('Type', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.speed, color: Colors.black, size: 32),
                    Text('Speed', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.local_gas_station,
                      color: Colors.black,
                      size: 32,
                    ),
                    Text('Fuel', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.settings, color: Colors.black, size: 32),
                    Text('Settings', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.battery_charging_full,
                      color: Colors.black,
                      size: 32,
                    ),
                    Text('Battery', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
