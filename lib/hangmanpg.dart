import 'dart:math';
import 'package:flutter/material.dart';

import 'db_helper.dart';

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
  int score = 0;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  Future<void> _initializeGame() async {
    var randomEntry = clueWords.entries.elementAt(Random().nextInt(clueWords.length));
    selectedClue = randomEntry.key;
    selectedWord = randomEntry.value[Random().nextInt(randomEntry.value.length)];

    int maxScore = await DatabaseHelper().getMaxScore(selectedClue); // Get max score
    setState(() {
      guessedLetters.clear();
      remainingAttempts = 6;
      score = 0; // Reset score for new game
    });
  }

  String getWordDisplay() {
    if (remainingAttempts == 0) return selectedWord;
    return selectedWord.split('').map((letter) => guessedLetters.contains(letter) ? letter : "_").join(" ");
  }

  Future<void> guessLetter(String letter) async {
    setState(() {
      if (!guessedLetters.contains(letter)) {
        guessedLetters.add(letter);
        if (!selectedWord.contains(letter)) {
          remainingAttempts--;
        }
      }
    });
  }

  Future<void> _updateScore() async {
    int maxScore = await DatabaseHelper().getMaxScore(selectedClue);
    var randomEntry = clueWords.entries.elementAt(Random().nextInt(clueWords.length));
    selectedClue = randomEntry.key;
    selectedWord = randomEntry.value[Random().nextInt(randomEntry.value.length)];
    setState(() {
      guessedLetters.clear();
      remainingAttempts = 6;
      score = score+1; // Reset score for new game
    });
    if (score > maxScore) {
      await DatabaseHelper().updateMaxScore('general', score);
    }
    await DatabaseHelper().insertDailyScore(); // Add 1 point to daily score
  }

  bool checkWin() {
    return selectedWord.split('').every((letter) => guessedLetters.contains(letter));
  }

  @override
  Widget build(BuildContext context) {
    bool isGameOver = remainingAttempts == 0;
    bool isGameWon = checkWin();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Hangman Game")),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade200, Colors.blue.shade900],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isGameWon ? "You Won!" : isGameOver ? "Game Over!" : "Guess the Word",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text("Clue: $selectedClue", style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white)),
                SizedBox(height: 20),
                buildHangman(),
                SizedBox(height: 20),
                Text(getWordDisplay(), style: TextStyle(fontSize: 40, letterSpacing: 2, color: Colors.white)),
                SizedBox(height: 20),
                Text("Attempts Remaining: $remainingAttempts", style: TextStyle(fontSize: 18, color: Colors.white)),
                Text("Score: $score", style: TextStyle(fontSize: 18, color: Colors.white)), // Display score
                SizedBox(height: 20),
                if (!isGameOver && !isGameWon) buildKeyboard(),
                if (isGameOver)
                  ElevatedButton(
                    onPressed: () {
                      _initializeGame();
                    },
                    child: Text("Play Again"),
                  ),
                if(isGameWon)
                  ElevatedButton(
                    onPressed: () {
                      _updateScore();
                    },
                    child: Text("Next Word?"),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildKeyboard() {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      alignment: WrapAlignment.center,
      children: List.generate(26, (index) {
        String letter = String.fromCharCode(65 + index).toLowerCase();
        bool isGuessed = guessedLetters.contains(letter);
        return SizedBox(
          width: 50, // Adjust width as needed
          height: 40, // Ensures a square button
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero, // Removes extra padding
              visualDensity: VisualDensity.compact, // Makes button more compact
              minimumSize: Size(40, 40), // Ensures button size matches the SizedBox
            ),
            onPressed: isGuessed || remainingAttempts == 0 ? null : () => guessLetter(letter),
            child: Center(
              child: Text(
                letter.toUpperCase(),
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildHangman() {
    return CustomPaint(
      size: Size(150, 200),
      painter: HangmanPainter(6 - remainingAttempts),
    );
  }
}

class HangmanPainter extends CustomPainter {
  final int errors;
  HangmanPainter(this.errors);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    // Gallows
    canvas.drawLine(Offset(10, size.height - 10), Offset(size.width - 10, size.height - 10), paint);
    canvas.drawLine(Offset(30, size.height - 10), Offset(30, 10), paint);
    canvas.drawLine(Offset(30, 10), Offset(size.width / 2, 10), paint);
    canvas.drawLine(Offset(size.width / 2, 10), Offset(size.width / 2, 40), paint);

    // Draw hangman based on errors
    if (errors > 0) canvas.drawCircle(Offset(size.width / 2, 60), 20, paint); // Head
    if (errors > 1) canvas.drawLine(Offset(size.width / 2, 80), Offset(size.width / 2, 130), paint); // Body
    if (errors > 2) canvas.drawLine(Offset(size.width / 2, 90), Offset(size.width / 2 - 30, 110), paint); // Left arm
    if (errors > 3) canvas.drawLine(Offset(size.width / 2, 90), Offset(size.width / 2 + 30, 110), paint); // Right arm
    if (errors > 4) canvas.drawLine(Offset(size.width / 2, 130), Offset(size.width / 2 - 30, 170), paint); // Left leg
    if (errors > 5) canvas.drawLine(Offset(size.width / 2, 130), Offset(size.width / 2 + 30, 170), paint); // Right leg
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
