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

    return WorkoutDetailScreen(
      title: "Fitness",
      level: "Advanced",
      videoAsset: 'assets/videos/fitness.mp4', // Make sure this video exists in your assets
      exercises: exercises,
    );
  }
}
