import 'package:flutter/material.dart';
import 'package:hangman/animalguess.dart';
import 'package:hangman/city.dart';
import 'package:hangman/food.dart';
import 'package:hangman/hangmanpg.dart';
import 'package:hangman/harrypotter.dart';

import 'chart.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, dynamic>> categories = [
    {"title": "Animals", "image": "https://wallpapercave.com/wp/wp2174944.jpg", "page": HangmanGamea()},
    {"title": "General", "image": "https://wallpaperaccess.com/full/90977.jpg", "page": HangmanGame()},
    {"title": "Harry Potter", "image": "https://www.enwallpaper.com/wp-content/uploads/2021/05/Harry-Potter-Wallpaper-HD-2.jpg", "page": HangmanhGame()},
    {"title": "Locations", "image": "https://th.bing.com/th/id/OIP._1tTXOXgXDGjpGDQFbC2SwHaE9?rs=1&pid=ImgDetMain", "page": HangmancGame()},
    {"title": "Food", "image": "https://th.bing.com/th/id/OIP.maQpFJiRuDMauaTZ3N7KiQHaEo?rs=1&pid=ImgDetMain", "page": HangmanfGame()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Guessr',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Colors.tealAccent,
        centerTitle: true,
        elevation: 8,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.tealAccent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.videogame_asset, size: 60, color: Colors.black),
                  SizedBox(height: 10),
                  Text("Guessr Game", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            ListTile(
              leading: Icon(Icons.home, color: Colors.black),
              title: Text("Home", style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.pop(context); // Closes the drawer
              },
            ),

            ListTile(
              leading: Icon(Icons.bar_chart, color: Colors.black),
              title: Text("High Scores", style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HighScoresPage()));
              },
            ),

            Divider(), // Adds a separator line

            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text("Exit", style: TextStyle(fontSize: 18, color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade900, Colors.teal.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Choose a Category to Play",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return buildCategoryCard(
                      categories[index]["title"],
                      categories[index]["image"],
                      categories[index]["page"],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCategoryCard(String title, String imageUrl, Widget targetPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => targetPage));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Stack(
          children: [
            // Background Image
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black45, blurRadius: 10, spreadRadius: 2),
                ],
              ),
            ),
            // Title Overlay with Glass Effect
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.3),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(color: Colors.black, blurRadius: 4),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
