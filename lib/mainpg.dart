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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hangman Game'),
        backgroundColor: Colors.tealAccent,
      ),
      body: Center(
        child: Column(
          children: [
            cardone("Animals",HangmanGamea()),
            cardone("General",HangmanGame()),
            cardone("Harry Potter",HangmanhGame()),
            cardone("Locations",HangmancGame()),
            cardone("Food", HangmanfGame()),
          ],
        ),
      ),
    );
  }
  Widget cardone(String st,Widget tar) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => tar),
        );
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue, // Change to your desired background color
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjust padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Set border radius
        ),
        elevation: 5, // This does not apply to TextButton but can be added via Container if needed
      ),
      child: Text(st),
    );
  }
}
