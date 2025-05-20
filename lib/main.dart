import 'package:flutter/material.dart';

void main() => runApp(VehicleListApp());

class VehicleListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle List',
      home: VehicleListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VehicleListPage extends StatelessWidget {
  static const _defaultPadding = 16.0;

  final List<Vehicle> vehicles = [
    Vehicle(
      title: "JAC Cheetah Hero Brands",
      location: "Jabi Modern Market - (8km away)",
      range: "150Km Range - ₦20/km",
      price: "₦20,000/hr",
      image: "assets/images/image.png",
    ),
    Vehicle(
      title: "Tesla Model S",
      location: "Wuse Zone 5 - (12km away)",
      range: "400Km Range - ₦25/km",
      price: "₦35,000/hr",
      image: "assets/images/tesla.png",
    ),
    Vehicle(
      title: "Toyota Camry Hybrid",
      location: "Garki Area 11 - (5km away)",
      range: "200Km Range - ₦18/km",
      price: "₦15,000/hr",
      image: "assets/images/toyota.png",
    ),
    Vehicle(
      title: "Mercedes EQS",
      location: "Maitama - (15km away)",
      range: "350Km Range - ₦30/km",
      price: "₦40,000/hr",
      image: "assets/images/mercedes.png",
    ),
    Vehicle(
      title: "BMW iX",
      location: "Asokoro - (10km away)",
      range: "300Km Range - ₦28/km",
      price: "₦38,000/hr",
      image: "assets/images/bmw.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView.builder(
        padding: const EdgeInsets.all(_defaultPadding),
        itemCount: vehicles.length,
        itemBuilder: (context, index) => VehicleCard(vehicle: vehicles[index]),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Vehicle List'),
      leading: const BackButton(),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    );
  }
}

class Vehicle {
  final String title;
  final String location;
  final String range;
  final String price;
  final String image;

  const Vehicle({
    required this.title,
    required this.location,
    required this.range,
    required this.price,
    required this.image,
  });
}

class VehicleCard extends StatelessWidget {
  static const _imageHeight = 180.0;
  static const _spacing = 4.0;
  static const _padding = 12.0;
  static const _titleFontSize = 16.0;

  final Vehicle vehicle;

  const VehicleCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          Padding(
            padding: const EdgeInsets.all(_padding),
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      vehicle.image,
      height: _imageHeight,
      width: double.infinity,
      fit: BoxFit.cover,
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
              _buildTitle(),
              const SizedBox(height: _spacing),
              _buildSubtext(vehicle.location),
              const SizedBox(height: _spacing),
              _buildSubtext(vehicle.range),
            ],
          ),
        ),
        _buildPrice(),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      vehicle.title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: _titleFontSize,
      ),
    );
  }

  Widget _buildSubtext(String text) {
    return Text(text, style: const TextStyle(color: Colors.grey));
  }

  Widget _buildPrice() {
    return Text(
      vehicle.price,
      style: const TextStyle(
        fontSize: _titleFontSize,
        color: Colors.teal,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
