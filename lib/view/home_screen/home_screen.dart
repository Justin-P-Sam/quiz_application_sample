// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:quiz_application_1/view/chemistry_screen/chemistry_result.dart';
import 'package:quiz_application_1/view/chemistry_screen/chemistry_screen.dart';
import 'package:quiz_application_1/view/quiz_screen/quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Text(
                    "Hi, Justin",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://i.pinimg.com/736x/82/00/43/8200435763dd55fbba824456fe180d76.jpg"),
                    radius: 30,
                    child: Icon(Icons.person),
                  )
                ],
              ),
            ),
            const Text(
              "Let's make this day productive",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),

            // Ranking and Points Section
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: Colors.grey[800],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoCard(
                    Icons.emoji_events,
                    "Ranking",
                    "350",
                  ),
                  _buildInfoCard(Icons.monetization_on, "Points", "1200"),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Categories Section
            const Text(
              "Let's play",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Categories Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuizScreen()));
                    },
                    child: _buildCategoryTile(Icons.sports_basketball, "Sports",
                        "50 questions", Colors.orangeAccent),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChemistryScreen()));
                    },
                    child: _buildCategoryTile(Icons.science, "Chemistry",
                        "30 questions", Colors.blue),
                  ),
                  _buildCategoryTile(
                      Icons.calculate, "Math", "95 questions", Colors.orange),
                  _buildCategoryTile(Icons.history_edu, "History",
                      "128 questions", Colors.blueGrey),
                  _buildCategoryTile(
                      Icons.biotech, "Biological", "75 questions", Colors.red),
                  _buildCategoryTile(
                      Icons.public, "Geography", "40 questions", Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for the ranking and points section
  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.yellow, size: 50),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for each category tile
  Widget _buildCategoryTile(
      IconData icon, String title, String subtitle, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 69,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
