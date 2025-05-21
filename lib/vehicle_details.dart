import 'package:flutter/material.dart';
import './vehicl_contact.dart';

class VehicleDetailsPage extends StatelessWidget {
  final Map<String, String> vehicle;

  const VehicleDetailsPage({super.key, required this.vehicle});

  Widget _buildFeatureColumn(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: Colors.black, size: 32),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Color.fromARGB(255, 118, 117, 117)),
    );
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    const textGrey = Color.fromARGB(255, 118, 117, 117);
    const spacing = SizedBox(height: 20);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _capitalizeFirstLetter(vehicle['title'] ?? ''),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                vehicle["image"]!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(
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
                    ),
              ),
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
                        _buildInfoText(vehicle["location"]!),
                        const SizedBox(height: 4),
                        _buildInfoText(vehicle["range"]!),
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
              style: const TextStyle(fontSize: 14, color: textGrey),
            ),
            spacing,
            const Text(
              "Vehicle Features",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFeatureColumn(Icons.directions_car, 'Lexus ES350'),
                _buildFeatureColumn(Icons.speed, '250km/hr'),
                _buildFeatureColumn(Icons.local_gas_station, '300lt tank'),
                _buildFeatureColumn(Icons.usb, '12V USB Port'),
                _buildFeatureColumn(Icons.shield_outlined, 'Titanium'),
              ],
            ),
            spacing,
            ElevatedButton(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => VehicleContactPage(vehicle: vehicle),
                    ),
                  ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                minimumSize: const Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Contact Rental',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
