import 'package:flutter/material.dart';
import './vehicle_details.dart';

void main() => runApp(VehicleListApp());

class VehicleListApp extends StatelessWidget {
  const VehicleListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: VehicleListPage());
  }
}

class VehicleListPage extends StatelessWidget {
  final List<Map<String, String>> vehicles = List.generate(
    50,
    (index) => {
      "title": "JéGO Rental Merchants",
      "location": "Jabi Modern Market - (20km away)",
      "range": "150Km Range ~ 120km/hr",
      "price": "₦50,000/hr",
      "image": "assets/images/car_${(index % 5) + 1}.jpg",
      "content":
          "This sleek and powerful vehicle offers exceptional performance and comfort. Featuring advanced safety systems, premium leather interior, and state-of-the-art infotainment system. The smooth handling and responsive acceleration make every journey enjoyable. With excellent fuel efficiency and spacious cargo capacity, it's perfect for both city driving and long-distance travel. Regular maintenance and careful ownership ensure this vehicle is in pristine condition.",
    },
  );

  VehicleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Vehicle List'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = vehicles[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VehicleDetailsPage(vehicle: vehicle),
                ),
              );
            },
            child: VehicleCard(vehicle: vehicle),
          );
        },
      ),
    );
  }
}

class VehicleCard extends StatelessWidget {
  final Map<String, String> vehicle;

  const VehicleCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      elevation: 0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              vehicle["image"]!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child:
                      frame != null
                          ? child
                          : Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.grey[200],
                          ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
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
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        vehicle["range"]!,
                        style: const TextStyle(color: Colors.grey),
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
        ],
      ),
    );
  }
}
