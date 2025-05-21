import 'package:flutter/material.dart';

class VehicleContactPage extends StatelessWidget {
  final Map<String, String> vehicle;

  const VehicleContactPage({super.key, required this.vehicle});

  Widget _buildImageErrorContainer({double height = 200}) {
    return Container(
      width: double.infinity,
      height: height,
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return CircleAvatar(
      backgroundColor: Colors.white.withOpacity(0.7),
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildStyledInput({
    required String hint,
    required String description,
    int maxLines = 1,
    required TextInputType keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(hint),
        TextField(
          maxLines: maxLines,
          decoration: _buildInputDecoration(description),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      enabledBorder: _buildInputBorder(),
      focusedBorder: _buildInputBorder(color: Colors.teal, width: 1.5),
      filled: true,
      fillColor: Colors.white,
    );
  }

  OutlineInputBorder _buildInputBorder({
    Color color = const Color.fromARGB(255, 211, 211, 211),
    double width = 1.0,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  Widget _buildImage(String imagePath, {double? height, double? width}) {
    return ClipRRect(
      borderRadius:
          height == 50 ? BorderRadius.circular(100) : BorderRadius.zero,
      child: Image.asset(
        imagePath,
        height: height,
        width: width,
        fit: BoxFit.cover,
        frameBuilder:
            height == 50
                ? (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: frame != null ? child : _buildImageErrorContainer(),
                  );
                }
                : null,
        errorBuilder:
            (context, error, stackTrace) =>
                _buildImageErrorContainer(height: height ?? 200),
      ),
    );
  }

  Widget _buildButton({
    required VoidCallback onPressed,
    required Widget child,
    Color? backgroundColor,
    bool outlined = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            backgroundColor ?? (outlined ? Colors.white : Colors.teal[700]),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side:
              outlined ? const BorderSide(color: Colors.teal) : BorderSide.none,
        ),
      ),
      child: child,
    );
  }

  Widget _buildDropdownField(String hintText, String? label) {
    final List<String> durations = List.generate(
      30,
      (index) => '${index + 1} ${index + 1 == 1 ? 'day' : 'days'}',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label ?? ''),
        DropdownButtonFormField<String>(
          decoration: _buildInputDecoration(hintText),
          items:
              durations.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: (String? newValue) {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 14,
      color: Color.fromARGB(255, 118, 117, 117),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                _buildImage(
                  vehicle["image"]!,
                  height: 350,
                  width: double.infinity,
                ),
                Positioned(
                  top: 40,
                  left: 12,
                  child: _buildCircleButton(
                    icon: Icons.arrow_back,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 12,
                  child: _buildCircleButton(
                    icon: Icons.favorite_border,
                    onPressed: () {
                      /* handle like */
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildImage(vehicle["image"]!, height: 50, width: 50),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'JeGO Rentals',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(vehicle["location"]!, style: textStyle),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(vehicle["content"]!, style: textStyle),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildDropdownField(
                    'Select rental duration...',
                    'Rental Duration',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildDropdownField(
                          'Rental Starts',
                          'Rental Starts',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(child: _buildDropdownField('Rental Ends', '')),
                    ],
                  ),

                  const SizedBox(height: 12),
                  _buildStyledInput(
                    hint: 'Destination',
                    keyboardType: TextInputType.text,
                    description: 'Input a destination you are driving to...',
                  ),
                  const SizedBox(height: 12),
                  _buildStyledInput(
                    hint: 'Comment',
                    keyboardType: TextInputType.multiline,
                    description: 'Drop a comment to for the merchant...',
                    maxLines: 5,
                  ),
                  const SizedBox(height: 16),
                  _buildButton(
                    onPressed: () {},
                    outlined: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.mail, color: Colors.teal, size: 25),
                        SizedBox(width: 8),
                        Text(
                          'Chat with Merchant',
                          style: TextStyle(color: Colors.teal),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildButton(
                    onPressed: () {},
                    child: const Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
