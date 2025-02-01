import 'dart:math';
import 'package:flutter/material.dart';

class HangmanGame extends StatefulWidget {
  @override
  _HangmanGameState createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> {
  // Dictionary where the clue is the key and the value is a list of words to guess
  final Map<String, List<String>> clueWords = {
    "Colors": ["red", "blue", "green", "yellow", "purple", "orange", "pink", "brown", "black", "white"],
    "Fruits": ["apple", "banana", "grape", "orange", "mango", "kiwi", "pineapple", "strawberry", "peach", "watermelon"],
    "Vehicles": ["car", "bicycle", "plane", "train", "motorcycle", "bus", "boat", "helicopter", "scooter", "truck"],
    "Countries": ["india", "japan", "france", "usa", "canada", "germany", "australia", "brazil", "italy", "south africa"],
    "Sports": ["soccer", "tennis", "cricket", "basketball", "baseball", "football", "hockey", "golf", "swimming", "volleyball"],
    "Music": ["rock", "jazz", "classical", "pop", "hip-hop", "blues", "reggae", "metal", "country", "electronic"],
    "Shapes": ["circle", "square", "triangle", "rectangle", "oval", "pentagon", "hexagon", "octagon", "diamond", "star"],
    "Weather": ["sunny", "rainy", "stormy", "cloudy", "windy", "snowy", "foggy", "humid", "thunder", "drizzle"],
    "Nature": ["mountain", "river", "forest", "ocean", "desert", "lake", "valley", "island", "waterfall", "canyon"],
    "Occupations": ["doctor", "teacher", "engineer", "nurse", "chef", "firefighter", "police", "artist", "scientist", "journalist"],
  };

  String selectedWord = "";
  String selectedClue = "";
  List<String> guessedLetters = [];
  int remainingAttempts = 6;

  @override
  void initState() {
    super.initState();
    // Randomly select a clue and its corresponding word from the dictionary
    var randomEntry = clueWords.entries.elementAt(Random().nextInt(clueWords.length));
    selectedClue = randomEntry.key;
    selectedWord = randomEntry.value[Random().nextInt(randomEntry.value.length)]; // Select a random word from the list
  }

  // Build the display of the word with guessed letters and underscores
  String getWordDisplay() {
    if (remainingAttempts == 0) {
      return selectedWord; // Show the full word when game is over
    }

    String display = "";
    for (int i = 0; i < selectedWord.length; i++) {
      String letter = selectedWord[i];
      if (letter == ' ') {
        display += "  "; // Show space without underscore
      } else if (guessedLetters.contains(letter)) {
        display += "$letter ";
      } else {
        display += "_ ";
      }
    }
    return display.trim();
  }

  // Handle guessing logic
  void guessLetter(String letter) {
    setState(() {
      if (!guessedLetters.contains(letter)) {
        guessedLetters.add(letter);
        if (!selectedWord.contains(letter)) {
          remainingAttempts--;
        }
      }
    });
  }

  // Check if the user won the game
  bool checkWin() {
    return selectedWord.split('').every((letter) => letter == ' ' || letter == '-' || letter == "'"|| guessedLetters.contains(letter));
  }

  @override
  Widget build(BuildContext context) {
    bool isGameOver = remainingAttempts == 0;
    bool isGameWon = checkWin();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hangman Game"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                isGameWon ? "You Won!" : isGameOver ? "Game Over!" : "Guess the word",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Clue: $selectedClue",  // Display the clue
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                getWordDisplay(),
                style: TextStyle(fontSize: 40, letterSpacing: 2),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text("Attempts Remaining: $remainingAttempts", style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              if (!isGameOver && !isGameWon) buildKeyboard(),
              if (isGameOver || isGameWon)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      guessedLetters.clear();
                      remainingAttempts = 6;
                      // Select a new random clue and its corresponding word
                      var randomEntry = clueWords.entries.elementAt(Random().nextInt(clueWords.length));
                      selectedClue = randomEntry.key;
                      selectedWord = randomEntry.value[Random().nextInt(randomEntry.value.length)].toLowerCase(); // Select a random word from the list
                    });
                  },
                  child: Text("Play Again"),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Build keyboard for guessing letters
  Widget buildKeyboard() {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      alignment: WrapAlignment.center,
      children: List.generate(26, (index) {
        String letter = String.fromCharCode(65 + index).toLowerCase();
        bool isGuessed = guessedLetters.contains(letter);
        return ElevatedButton(
          onPressed: isGuessed || remainingAttempts == 0 ? null : () => guessLetter(letter),
          child: Text(letter.toUpperCase(), style: TextStyle(fontSize: 18)),
        );
      }),
    );
  }
}
