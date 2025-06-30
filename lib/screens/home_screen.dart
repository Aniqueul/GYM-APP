import 'package:flutter/material.dart';
import 'muscle_building_screen.dart';
import 'yoga_screen.dart';
import 'fitness_screen.dart';
import 'account_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onBottomNavTap(int index) {
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AccountScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String username = widget.username;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Zeus',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
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

              // Greeting with username
              Text(
                'Hey $username!',
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                'Start training',
                style: TextStyle(color: Colors.redAccent),
              ),
              const SizedBox(height: 20),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What do you want to train today?',
                    hintStyle: TextStyle(color: Colors.white60),
                    icon: Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Categories
              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _TrainingCard(
                      title: 'Muscle Building',
                      icon: Icons.fitness_center,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MuscleBuildingScreen()),
                      ),
                    ),
                    const SizedBox(width: 16),
                    _TrainingCard(
                      title: 'Yoga',
                      icon: Icons.self_improvement,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const YogaScreen()),
                      ),
                    ),
                    const SizedBox(width: 16),
                    _TrainingCard(
                      title: 'FITNESS',
                      icon: Icons.directions_run,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const FitnessScreen()),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Trending Courses
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Trending courses',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('See all', style: TextStyle(color: Colors.redAccent)),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    _CourseCard(
                      image: 'assets/images/trainer.jpg',
                      category: 'Fitness',
                      title: 'Personal Trainer',
                      rating: 4.9,
                      duration: '5h 30m',
                    ),
                    SizedBox(width: 16),
                    _CourseCard(
                      image: 'assets/images/nutrition.jpeg',
                      category: 'Nutrition',
                      title: 'Sport Nutrition',
                      rating: 4.9,
                      duration: '5h 0m',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

class _TrainingCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _TrainingCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 36),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 4),
            const Text('Learn more', style: TextStyle(color: Colors.redAccent, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final String image;
  final String category;
  final String title;
  final double rating;
  final String duration;

  const _CourseCard({
    required this.image,
    required this.category,
    required this.title,
    required this.rating,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.yellow, size: 14),
              Text(' $rating', style: const TextStyle(color: Colors.white, fontSize: 12)),
              const SizedBox(width: 8),
              const Icon(Icons.access_time, color: Colors.white70, size: 14),
              Text(' $duration', style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}
