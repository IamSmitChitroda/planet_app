/*
import '../models/planet.dart';

class DetailScreen extends StatefulWidget {
  final Planet planet;

  const DetailScreen({super.key, required this.planet});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.planet.name),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                widget.planet.image,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.planet.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.public),
                title: const Text('Distance from Sun'),
                trailing: Text('${widget.planet.distanceFromSun} million km'),
              ),
              ListTile(
                leading: const Icon(Icons.speed),
                title: const Text('Gravity'),
                trailing: Text('${widget.planet.gravity} m/s²'),
              ),
              // Add more details as needed
            ],
          ),
        ),
      ),
    );
  }
}
*/

// class PlanetDetailScreen extends StatelessWidget {
//   final String planetName;
//   final String imagePath;
//
//   const PlanetDetailScreen(
//       {super.key, required this.planetName, required this.imagePath});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(planetName),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Hero(
//               tag: planetName, // Must match the tag used in the HomeScreen
//               child: Image.asset(
//                 imagePath,
//                 width: 150, // Larger size for the planet in the detail screen
//                 height: 150,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Detailed information about $planetName',
//               style: const TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class PlanetDetailScreen extends StatefulWidget {
  final Map<String, dynamic> planetData; // Planet data

  PlanetDetailScreen({required this.planetData});

  @override
  _PlanetDetailScreenState createState() => _PlanetDetailScreenState();
}

class _PlanetDetailScreenState extends State<PlanetDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Create staggered animations
    for (int i = 0; i < 9; i++) {
      final startDelayFraction = i * 0.1;
      final endDelayFraction = startDelayFraction + 0.5;
      _animations.add(Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(startDelayFraction, endDelayFraction,
              curve: Curves.easeOut),
        ),
      ));
    }

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final planetData = widget.planetData;
    final String planetName = planetData['name'];

    return Scaffold(
      appBar: AppBar(
        title: Text(planetName),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: planetName,
                child: Image.asset(
                  'assets/images/${planetName.toLowerCase()}.png', // Planet image
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildAnimatedDetailCard(
                "Mass", "${planetData['mass']} Earth masses", _animations[0]),
            _buildAnimatedDetailCard("Radius",
                "${planetData['radius']} Earth radii", _animations[1]),
            _buildAnimatedDetailCard("Orbital Period",
                "${planetData['period']} days", _animations[2]),
            _buildAnimatedDetailCard("Semi-major Axis",
                "${planetData['semi_major_axis']} AU", _animations[3]),
            _buildAnimatedDetailCard("Temperature",
                "${planetData['temperature']} K", _animations[4]),
            _buildAnimatedDetailCard(
                "Distance from Earth",
                "${planetData['distance_light_year']} light years",
                _animations[5]),
          ],
        ),
      ),
    );
  }

  // Method to build an animated card with staggered effect
  Widget _buildAnimatedDetailCard(
      String label, String value, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 16, color: Colors.deepPurple),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
