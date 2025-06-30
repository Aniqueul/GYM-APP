import 'package:flutter/material.dart';
import 'workout_detail_screen.dart';

class FitnessScreen extends StatelessWidget {
  const FitnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample exercises for fitness
    List<String> exercises = [
      'Jumping Jacks',
      'Mountain Climbers',
      'Push Ups',
      'Burpees',
      'High Knees'
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Yoga"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Your Yoga Session',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'This beginner-friendly yoga routine helps you stretch and relax.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WorkoutDetailScreen(
                        title: "Fitness",
                        level: "Advanced",
                        videoAsset: 'assets/videos/fitness.mp4',
                        exercises: exercises,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Start Fitness Session',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return WorkoutDetailScreen(
      title: "Fitness",
      level: "Advanced",
      videoAsset: 'assets/videos/fitness.mp4', // Make sure this video exists in your assets
      exercises: exercises,
    );
  }
}
