import 'package:flutter/material.dart';
import 'workout_detail_screen.dart';
import 'home_screen.dart'; // Replace with your actual home screen import

class MuscleBuildingScreen extends StatefulWidget {
  const MuscleBuildingScreen({super.key});

  @override
  State<MuscleBuildingScreen> createState() => _MuscleBuildingScreenState();
}

class _MuscleBuildingScreenState extends State<MuscleBuildingScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      // Home button tapped
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(username: 'Guest')),

      );
    } else if (index == 1) {
      // Current screen (MuscleBuilding), do nothing
    }
  }

  final List<Map<String, dynamic>> workouts = [
    {
      'title': 'Push Day',
      'workouts': 4,
      'image': 'assets/images/push.jpeg',
      'pro': false
    },
    {
      'title': 'Pull Day',
      'workouts': 4,
      'image': 'assets/images/pull.jpeg',
      'pro': true
    },
    {
      'title': 'Leg Day',
      'workouts': 4,
      'image': 'assets/images/legs.jpeg',
      'pro': true
    },
    {
      'title': 'Core Day',
      'workouts': 4,
      'image': 'assets/images/legs.jpeg',
      'pro': false
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Zeus',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications, color: Colors.white),
                        onPressed: () {},
                      ),
                      const CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage("assets/images/profile.png"),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Muscle Building",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Workouts for Intermediate",
                style: TextStyle(color: Colors.white60, fontSize: 16),
              ),
              const SizedBox(height: 20),
              for (var workout in workouts)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WorkoutDetailScreen(
                          title: workout['title'],
                          level: 'Intermediate',
                          videoAsset: _getVideoAsset(workout['title']),
                          exercises: _getExercises(workout['title']),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(workout['image']),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              workout['title'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '4 Workouts • Intermediate',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        if (workout['pro'])
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                "PRO",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Muscle',
          ),
        ],
      ),
    );
  }

  String _getVideoAsset(String title) {
    switch (title) {
      case 'Push Day':
        return 'assets/videos/bench.mp4';
      case 'Pull Day':
        return 'assets/videos/pull.mp4';
      case 'Leg Day':
        return 'assets/videos/legs.mp4';
      case 'Core Day':
        return 'assets/videos/legs.mp4';
      default:
        return '';
    }
  }

  List<String> _getExercises(String title) {
    switch (title) {
      case 'Push Day':
        return ['Bench Press', 'Overhead Press', 'Triceps Pushdown'];
      case 'Pull Day':
        return ['Deadlift', 'Pull-Ups', 'Seated Row'];
      case 'Leg Day':
        return ['Squats', 'Leg Press', 'Lunges'];
      case 'Core Day':
        return ['Plank', 'Push ups', 'Lunges'];
      default:
        return [];
    }
  }
}
