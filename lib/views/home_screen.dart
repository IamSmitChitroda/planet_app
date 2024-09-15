import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:planet_app/views/detail_screen.dart'; // For navigation

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Adjust speed of the revolution
    )..repeat(); // Make the animation repeat indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Map<String, dynamic> mercury = {
    "name": "Mercury",
    "mass": 0.000174,
    "radius": 0.0341,
    "period": 88.0,
    "semi_major_axis": 0.387098,
    "temperature": 400.0,
    "distance_light_year": 1.1e-05,
    "host_star_mass": 1.0,
    "host_star_temperature": 6000.0
  };
  Map<String, dynamic> venus = {
    "name": "Venus",
    "mass": 0.00257,
    "radius": 0.0847,
    "period": 224.7,
    "semi_major_axis": 0.723332,
    "temperature": 737.0,
    "distance_light_year": 4e-06,
    "host_star_mass": 1.0,
    "host_star_temperature": 6000.0
  };
  Map<String, dynamic> earth = {
    "name": "Earth",
    "mass": 0.00315,
    "radius": 0.0892,
    "period": 365.2,
    "semi_major_axis": 1.0,
    "temperature": 288.0,
    "distance_light_year": 0.0,
    "host_star_mass": 1.0,
    "host_star_temperature": 6000.0
  };
  Map<String, dynamic> mars = {
    "name": "Mars",
    "mass": 0.000338,
    "radius": 0.0488,
    "period": 687.0,
    "semi_major_axis": 1.542,
    "temperature": 210.0,
    "distance_light_year": 3.7e-05,
    "host_star_mass": 1.0,
    "host_star_temperature": 6000.0
  };
  Map<String, dynamic> jupiter = {
    "name": "Jupiter",
    "mass": 1.0,
    "radius": 1.0,
    "period": 4331.0,
    "semi_major_axis": 5.204,
    "temperature": 165.0,
    "distance_light_year": 8.8e-05,
    "host_star_mass": 1.0,
    "host_star_temperature": 6000.0
  };
  Map<String, dynamic> saturn = {
    "name": "Saturn",
    "mass": 0.299,
    "radius": 0.843,
    "period": 10747.0,
    "semi_major_axis": 9.537,
    "temperature": 134.0,
    "distance_light_year": 0.00017,
    "host_star_mass": 1.0,
    "host_star_temperature": 6000.0
  };
  Map<String, dynamic> uranus = {
    "name": "Uranus",
    "mass": 0.0457,
    "radius": 0.358,
    "period": 30589.0,
    "semi_major_axis": 19.191,
    "temperature": 76.0,
    "distance_light_year": 0.000304,
    "host_star_mass": 1.0,
    "host_star_temperature": 6000.0
  };
  Map<String, dynamic> neptune = {
    "name": "Neptune",
    "mass": 0.0537,
    "radius": 0.346,
    "period": 59800.0,
    "semi_major_axis": 30.07,
    "temperature": 72.0,
    "distance_light_year": 0.000478,
    "host_star_mass": 1.0,
    "host_star_temperature": 6000.0
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: ClipRect(
              child: Align(
                alignment: Alignment.bottomRight,
                widthFactor: 0.5, // Show only half of the Sun horizontally
                heightFactor: 0.5, // Show only half of the Sun vertically
                child: Image.asset(
                  'assets/images/sun.png', // Replace with your sun image
                  width: 500, // Size of the Sun
                  height: 500,
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                  _buildPlanet(
                    150,
                    'Mercury',
                    'assets/images/mercury.png',
                    0,
                    mercury,
                  ),
                  _buildPlanet(
                    250,
                    'Venus',
                    'assets/images/venus.png',
                    pi / 4,
                    venus,
                  ),
                  _buildPlanet(
                    300,
                    'Earth',
                    'assets/images/earth.png',
                    pi / 2,
                    earth,
                  ),
                  _buildPlanet(
                    350,
                    'Mars',
                    'assets/images/mars.png',
                    3 * pi / 4,
                    mars,
                  ),
                  _buildPlanet(
                    400,
                    'Jupiter',
                    'assets/images/jupiter.png',
                    pi,
                    jupiter,
                  ),
                  _buildPlanet(
                    450,
                    'Saturn',
                    'assets/images/saturn.png',
                    5 * pi / 4,
                    saturn,
                  ),
                  _buildPlanet(
                    500,
                    'Uranus',
                    'assets/images/uranus.png',
                    3 * pi / 2,
                    uranus,
                  ),
                  _buildPlanet(
                    650,
                    'Neptune',
                    'assets/images/neptune.png',
                    7 * pi / 4,
                    neptune,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPlanet(double radius, String planetName, String imagePath,
      double startAngle, Map<String, dynamic> planetDetail) {
    final double angle = _controller.value * 2 * pi + startAngle;

    return Transform.translate(
      offset: Offset(
        radius * cos(angle),
        radius * sin(angle),
      ),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => PlanetDetailScreen(
              planetData: planetDetail,
            ),
          );
        },
        child: Column(
          children: [
            // Rotate each planet on its own axis
            RotationTransition(
              turns: _controller, // Rotation along its own axis
              child: Hero(
                tag: planetName, // Hero tag must be unique
                child: Image.asset(
                  imagePath,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
