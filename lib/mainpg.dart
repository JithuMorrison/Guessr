import 'package:flutter/material.dart';
import 'package:hangman/animalguess.dart';
import 'package:hangman/city.dart';
import 'package:hangman/food.dart';
import 'package:hangman/hangmanpg.dart';
import 'package:hangman/harrypotter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, dynamic>> categories = [
    {"title": "Animals", "image": "https://wallpapercave.com/wp/wp2174944.jpg", "page": HangmanGamea()},
    {"title": "General", "image": "https://wallpaperaccess.com/full/90977.jpg", "page": HangmanGame()},
    {"title": "Harry Potter", "image": "https://source.unsplash.com/600x300/?wizard,magic", "page": HangmanhGame()},
    {"title": "Locations", "image": "https://source.unsplash.com/600x300/?city,landscape", "page": HangmancGame()},
    {"title": "Food", "image": "https://source.unsplash.com/600x300/?food", "page": HangmanfGame()},
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
