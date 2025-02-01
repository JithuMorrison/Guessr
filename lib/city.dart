import 'dart:math';
import 'package:flutter/material.dart';

class HangmancGame extends StatefulWidget {
  @override
  _HangmancGameState createState() => _HangmancGameState();
}

class _HangmancGameState extends State<HangmancGame> {
  // Dictionary where the clue is the key and the value is a list of words to guess
  final Map<String, List<String>> clueWords = {
    "Countries": [
      "afghanistan", "albania", "algeria", "andorra", "angola",
      "argentina", "armenia", "australia", "austria", "azerbaijan",
      "bahamas", "bahrain", "bangladesh", "barbados", "belarus",
      "belgium", "belize", "benin", "bhutan", "bolivia",
      "bosnia and herzegovina", "botswana", "brazil", "brunei",
      "bulgaria", "burkina faso", "burundi", "cabo verde", "cambodia",
      "cameroon", "canada", "central african republic", "chad",
      "chile", "china", "colombia", "comoros", "congo",
      "costa rica", "croatia", "cuba", "cyprus", "czech republic",
      "democratic republic of the congo", "denmark", "djibouti",
      "dominica", "dominican republic", "ecuador", "egypt",
      "el salvador", "equatorial guinea", "eritrea", "estonia",
      "eswatini", "ethiopia", "fiji", "finland", "france",
      "gabon", "gambia", "georgia", "germany", "ghana",
      "greece", "grenada", "guatemala", "guinea", "guinea-bissau",
      "guyana", "haiti", "honduras", "hungary", "iceland",
      "india", "indonesia", "iran", "iraq", "ireland",
      "israel", "italy", "jamaica", "japan", "jordan",
      "kazakhstan", "kenya", "kiribati", "korea", "kuwait",
      "kyrgyzstan", "laos", "latvia", "lebanon", "lesotho",
      "liberia", "libya", "liechtenstein", "lithuania",
      "luxembourg", "madagascar", "malawi", "malaysia", "maldives",
      "mali", "malta", "marshall islands", "mauritania", "mauritius",
      "mexico", "micronesia", "moldova", "monaco", "mongolia",
      "montenegro", "morocco", "mozambique", "myanmar",
      "namibia", "nauru", "nepal", "netherlands", "new zealand",
      "nicaragua", "niger", "nigeria", "north macedonia",
      "norway", "oman", "pakistan", "palau", "palestine",
      "panama", "papua new guinea", "paraguay", "peru",
      "philippines", "poland", "portugal", "qatar", "romania",
      "russia", "rwanda", "saint kitts and nevis",
      "saint lucia", "saint vincent and the grenadines",
      "samoa", "san marino", "sao tome and principe", "saudi arabia",
      "senegal", "serbia", "seychelles", "sierra leone",
      "singapore", "slovakia", "slovenia", "solomon islands",
      "somalia", "south africa", "south sudan", "spain",
      "sri lanka", "sudan", "suriname", "sweden", "switzerland",
      "syria", "taiwan", "tajikistan", "tanzania", "thailand",
      "togo", "tonga", "trinidad and tobago", "tunisia",
      "turkey", "turkmenistan", "tuvalu", "uganda", "uk",
      "ukraine", "uae", "uk us virgin islands", "united states",
      "uruguay", "uzbekistan", "vanuatu", "vatican city",
      "venezuela", "vietnam", "yemen", "zambia", "zimbabwe"
    ],
    "Cities": [
      "abu dhabi", "accra", "adar", "addis ababa", "ahmedabad",
      "algiers", "amsterdam", "ankara", "austin", "baku",
      "bangkok", "bangladesh", "barranquilla", "beijing", "beirut",
      "belgrade", "berlin", "bogota", "boston", "brasilia",
      "bridgetown", "brussels", "budapest", "cairo", "calgary",
      "cancun", "caracas", "chennai", "chicago", "chisinau",
      "copenhagen", "dar es salaam", "delhi", "dhaka",
      "dublin", "dusseldorf", "fortaleza", "geneva", "ghent",
      "gibraltar", "gothenburg", "halifax", "hanoi",
      "harare", "helsinki", "honolulu", "hyderabad", "islamabad",
      "istanbul", "jakarta", "jerusalem", "johannesburg",
      "kabul", "kairo", "kathmandu", "kiev", "kingston",
      "kuala lumpur", "kuwait city", "la paz", "lagos",
      "lima", "lisbon", "lithuania", "los angeles",
      "lubbock", "madrid", "managua", "manchester", "mexico city",
      "minneapolis", "moscow", "nairobi", "new delhi",
      "new orleans", "new york", "nottingham", "oslo",
      "ottawa", "paris", "phoenix", "porto", "prague",
      "pretoria", "quito", "rio de janeiro", "rome",
      "rosario", "santiago", "santo domingo", "seattle",
      "seoul", "sydney", "taipei", "tbilisi",
      "tehran", "thimphu", "tokyo", "toronto", "valencia",
      "vancouver", "venice", "vigo", "warsaw",
      "washington dc", "wellington", "yangon", "zagreb"
    ],
    "Places": [
      "grand canyon", "eiffel tower", "statue of liberty",
      "great wall of china", "pyramids of giza", "stonehenge",
      "colosseum", "niagara falls", "taj mahal", "sydney opera house",
      "machu picchu", "big ben", "vatican city", "angkor wat",
      "mount everest", "great barrier reef", "hanging gardens of babylon",
      "statue of christ the redeemer", "blue lagoon", "alhambra",
      "petra", "yellowstone national park", "banff national park",
      "great ocean road", "sahara desert", "amazon rainforest",
      "serengeti", "victoria falls", "uluru", "niagara falls",
      "the matterhorn", "yosemite national park", "glacier national park",
      "stone mountain", "crater lake", "grand teton", "lake tahoe",
      "bryce canyon", "zion national park", "canadian rockies",
      "joshua tree national park", "cape town", "galapagos islands"
    ],
    "Landmarks": [
      "golden gate bridge", "big ben", "leaning tower of pisa",
      "chichen itza", "acropolis of athens", "white house",
      "buckingham palace", "sagrada familia", "broadway",
      "millennium park", "red square", "forbidden city",
      "st. basil's cathedral", "tower of london", "sears tower",
      "national mall", "gateway arch", "louvre museum",
      "hagia sophia", "petronas towers", "burj khalifa",
      "the arc de triomphe", "the colosseum", "the parthenon",
      "the petra", "the taj mahal", "the golden temple",
      "the stonehenge", "the great wall of china",
      "the statue of liberty", "the pyramids of giza",
      "the eiffel tower", "the cathedral of notre dame"
    ]
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
