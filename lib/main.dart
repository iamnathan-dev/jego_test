import 'package:flutter/material.dart';
import './vehicle_details.dart';

void main() => runApp(const VehicleListApp());

class VehicleListApp extends StatelessWidget {
  const VehicleListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: VehicleListPage());
  }
}

class VehicleListPage extends StatelessWidget {
  static const _imageCount = 5;

  final List<Map<String, String>> vehicles = List.generate(
    50,
    (index) => {
      "title": "JéGO Rental Merchants",
      "location": "Jabi Modern Market - (20km away)",
      "range": "150Km Range ~ 120km/hr",
      "price": "₦50,000/hr",
      "image": "assets/images/car_${(index % _imageCount) + 1}.jpg",
      "content":
          "This sleek and powerful vehicle offers exceptional performance and comfort. "
          "Featuring advanced safety systems, premium leather interior, and state-of-the-art "
          "infotainment system. The smooth handling and responsive acceleration make every "
          "journey enjoyable. With excellent fuel efficiency and spacious cargo capacity, "
          "it's perfect for both city driving and long-distance travel. Regular maintenance "
          "and careful ownership ensure this vehicle is in pristine condition.",
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
            onTap: () => _navigateToDetails(context, vehicle),
            child: VehicleCard(vehicle: vehicle),
          );
        },
      ),
    );
  }

  void _navigateToDetails(BuildContext context, Map<String, String> vehicle) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => VehicleDetailsPage(vehicle: vehicle)),
    );
  }
}

class VehicleCard extends StatelessWidget {
  static const double _imageHeight = 200;
  static const double _cardSpacing = 20;
  static const double _contentPadding = 12;
  static const double _textSpacing = 4;

  final Map<String, String> vehicle;

  const VehicleCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: _cardSpacing),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      elevation: 0,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: _contentPadding),
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        vehicle["image"]!,
        height: _imageHeight,
        width: double.infinity,
        fit: BoxFit.cover,
        frameBuilder: _buildImageFrame,
        errorBuilder: _buildErrorWidget,
      ),
    );
  }

  Widget _buildImageFrame(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    if (wasSynchronouslyLoaded) return child;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: frame != null ? child : _buildPlaceholder(),
    );
  }

  Widget _buildErrorWidget(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return Container(
      width: double.infinity,
      height: _imageHeight,
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      height: _imageHeight,
      color: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return Row(
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
              const SizedBox(height: _textSpacing),
              Text(
                vehicle["location"]!,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: _textSpacing),
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
    );
  }
}
