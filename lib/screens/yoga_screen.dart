import 'package:flutter/material.dart';
import 'workout_detail_screen.dart';

class YogaScreen extends StatelessWidget {
  const YogaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample exercises for yoga
    List<String> exercises = [
      'Sun Salutation',
      'Tree Pose',
      'Child\'s Pose',
      'Cobra Pose',
      'Warrior II'
    ];

    return WorkoutDetailScreen(
      title: "Yoga",
      level: "Beginner",
      videoAsset: 'assets/videos/yoga.mp4', // Make sure the file exists
      exercises: exercises,
    );
  }
}
