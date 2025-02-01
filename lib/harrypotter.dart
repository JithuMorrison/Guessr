import 'dart:math';
import 'package:flutter/material.dart';

class HangmanhGame extends StatefulWidget {
  @override
  _HangmanhGameState createState() => _HangmanhGameState();
}

class _HangmanhGameState extends State<HangmanhGame> {
  // Dictionary where the clue is the key and the value is a list of words to guess
  final Map<String, List<String>> clueWords = {
    "Characters": [
      "harry potter", "hermione granger", "ron weasley", "albus dumbledore",
      "severus snape", "sirius black", "lord voldemort", "luna lovegood",
      "ginny weasley", "draco malfoy", "neville longbottom", "bellatrix lestrange",
      "minerva mcgonagall", "remus lupin", "rubeus hagrid", "oliver wood",
      "dobby", "petunia dursley", "lily potter", "james potter",
      "fred weasley", "george weasley", "alastor moody", "gilderoy lockhart",
      "cedric diggory", "viktor krum", "pansy parkinson", "narcissa malfoy",
      "moony", "wormtail", "padfoot", "prongs"
    ],
    "Spells": [
      "expelliarmus", "lumos", "nox", "avada kedavra", "stupefy",
      "protego", "alohomora", "accio", "petrificus totalus", "wingardium leviosa",
      "incendio", "reducio", "depulso", "confundo", "obliviate",
      "expecto patronum", "imperio", "sectumsempra", "finite incantatem",
      "diffindo", "descendo", "reparo", "silencio", "riddikulus",
      "engorgio", "accio", "muffliato", "crucio", "aparecium",
      "aguamenti", "mobiliarbus"
    ],
    "Magical Creatures": [
      "hippogriff", "dragon", "house elf", "basilisk", "thestral",
      "unicorn", "dementor", "acromantula", "niffler", "phoenix",
      "griffin", "centaur", "werewolf", "giant", "mermaid",
      "puffskein", "crumple-horned snorkack", "pygmy puff", "chimaera",
      "thestral", "mooncalf", "jobberknoll", "bowtruckle", "sphinx",
      "fwooper", "nargle", "knotgrass", "roosetwink", "bloodhound",
      "serpent"
    ],
    "Locations": [
      "hogwarts", "diagon alley", "hogsmeade", "the burrow", "azkaban",
      "gringotts", "platform nine and three-quarters", "the forbidden forest",
      "the ministry of magic", "the great hall", "the room of requirement",
      "privet drive", "the black lake", "the dursleys' house",
      "the shrieking shack", "the chamber of secrets", "the whomping willow",
      "the leaky cauldron", "malfoy manor", "the dragon pit", "number twelve grimmauld place",
      "the great lake", "the train station", "the clock tower", "the dungeons", "the library"
    ],
    "Potions": [
      "polyjuice potion", "felix felicis", "veritaserum", "amortentia",
      "petrificus totalus", "sleeping draught", "elixir of life", "love potion",
      "the draught of living death", "the antidote to poison", "skele-gro",
      "calming draught", "strengthening solution", "vanishing spell",
      "antidote to common poisons", "fire protection potion", "wideye potion",
      "regeneration potion", "dreamless sleep potion", "drought of peace",
      "polyjuice potion", "the potions master", "herbology potion", "zoology potion",
      "the draught of replenishment", "the potion of forgetfulness", "the potion of time",
      "the potion of healing"
    ],
    "Events": [
      "quidditch world cup", "the triwizard tournament", "battle of hogwarts",
      "yule ball", "order of the phoenix", "the deathly hallows",
      "the wizarding war", "hogwarts sorting ceremony", "the goblet of fire",
      "the chamber of secrets", "the battle of seven potters",
      "the ministry of magic raid", "the fall of voldemort",
      "the final battle", "the triwizard task", "the wizarding exams",
      "the birth of harry potter", "the first wizarding war",
      "the second wizarding war", "the discovery of the hallows",
      "the rise of voldemort", "the prophecy", "the attack on hogwarts",
      "the formation of the order", "the return of voldemort",
      "the time turner incident", "the attack of the basilisk"
    ],
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
