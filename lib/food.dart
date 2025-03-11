import 'dart:math';
import 'package:flutter/material.dart';

import 'db_helper.dart';

class HangmanfGame extends StatefulWidget {
  @override
  _HangmanfGameState createState() => _HangmanfGameState();
}

class _HangmanfGameState extends State<HangmanfGame> {
  // Dictionary where the clue is the key and the value is a list of words to guess
  final Map<String, List<String>> clueWords = {
    "Fruits": [
      "apple", "banana", "grape", "orange", "mango",
      "kiwi", "pineapple", "strawberry", "peach", "watermelon",
      "blueberry", "blackberry", "raspberry", "cantaloupe", "honeydew",
      "pomegranate", "fig", "plum", "cherry", "apricot",
      "dragonfruit", "papaya", "nectarine", "lime", "lemon"
    ],
    "Vegetables": [
      "carrot", "broccoli", "spinach", "tomato", "cucumber",
      "potato", "onion", "garlic", "bell pepper", "zucchini",
      "lettuce", "cauliflower", "eggplant", "kale", "asparagus",
      "sweet potato", "beetroot", "mushroom", "radish", "pumpkin",
      "brussels sprouts", "artichoke", "chard", "bok choy", "celery"
    ],
    "Grains": [
      "rice", "wheat", "quinoa", "barley", "oats",
      "corn", "millet", "sorghum", "rye", "bulgur",
      "farro", "couscous", "buckwheat", "spelt", "wild rice",
      "rice noodles", "polenta", "semolina", "amaranth", "teff"
    ],
    "Dairy": [
      "milk", "cheese", "yogurt", "butter", "cream",
      "sour cream", "ice cream", "cottage cheese", "ghee", "paneer",
      "feta", "mozzarella", "ricotta", "cream cheese", "kefir"
    ],
    "Meats": [
      "chicken", "beef", "pork", "lamb", "turkey",
      "duck", "ham", "bacon", "sausage", "venison",
      "goat", "rabbit", "salmon", "tuna", "shrimp",
      "chorizo", "schnitzel", "kebabs", "steak", "meatballs"
    ],
    "Seafood": [
      "fish", "crab", "lobster", "shrimp", "scallops",
      "mussels", "clams", "oysters", "sardines", "anchovies",
      "octopus", "squid", "caviar", "sea bass", "trout",
      "tilapia", "mackerel", "catfish", "haddock", "snapper"
    ],
    "Desserts": [
      "cake", "cookies", "brownies", "ice cream", "pie",
      "pudding", "cheesecake", "cupcakes", "tiramisu", "macarons",
      "gelato", "donuts", "pavlova", "mousse", "sorbet",
      "eclair", "fruit tart", " panna cotta", "flan", "bread pudding"
    ],
    "Beverages": [
      "water", "coffee", "tea", "juice", "soda",
      "milkshake", "smoothie", "cocktail", "beer", "wine",
      "whiskey", "vodka", "champagne", "lemonade", "iced tea",
      "hot chocolate", "matcha", "kombucha", "iced coffee", "sparkling water"
    ],
    "Snacks": [
      "chips", "popcorn", "nuts", "trail mix", "pretzels",
      "granola bars", "fruit snacks", "jerky", "dried fruit", "cheese sticks",
      "veggie sticks", "rice cakes", "dark chocolate", "candy", "ice cream bars",
      "pita chips", "hummus", "vegan snacks", "energy bars", "sunflower seeds"
    ],
      "Italian": [
        "pizza", "pasta", "lasagna", "risotto", "gelato",
        "focaccia", "bruschetta", "cannoli", "tiramisu", "pesto",
        "ravioli", "osso buco", "caprese", "arancini", "limoncello"
      ],
      "Chinese": [
        "dumplings", "noodles", "fried rice", "spring rolls", "sweet and sour pork",
        "mapo tofu", "kung pao chicken", "hot pot", "Peking duck", "boba tea",
        "bao buns", "chow mein", "szechuan chicken", "egg drop soup", "chinese broccoli"
      ],
      "Mexican": [
        "tacos", "burritos", "enchiladas", "quesadillas", "guacamole",
        "salsa", "churros", "tamales", "fajitas", "mole",
        "ceviche", "elote", "pozole", "pico de gallo", "chile relleno"
      ],
      "Indian": [
        "curry", "biryani", "samosa", "dal", "butter chicken",
        "paneer tikka", "naan", "chapati", "chutney", "pani puri",
        "tandoori chicken", "rasgulla", "gulab jamun", "idli", "dosa"
      ],
      "Japanese": [
        "sushi", "ramen", "tempura", "udon", "sashimi",
        "miso soup", "yakitori", "onigiri", "takoyaki", "edamame",
        "okonomiyaki", "katsu", "matcha", "mochi", "soba"
      ],
      "French": [
        "croissant", "coq au vin", "ratatouille", "bouillabaisse", "quiche",
        "tarte tatin", "crème brûlée", "macarons", "escargot", "crepes",
        "pâté", "soufflé", "foie gras", "salmon en croûte", "beef bourguignon"
      ],
      "Greek": [
        "souvlaki", "moussaka", "tzatziki", "baklava", "feta",
        "spanakopita", "dolmades", "pita", "kleftiko", "greek salad",
        "avgolemono", "pastitsio", "revithada", "giouvetsaki", "loukoum"
      ],
      "Spanish": [
        "paella", "tapas", "churros", "gazpacho", "jamón",
        "pisto", "queso", "tortilla", "flan", "sangria",
        "fideuà", "albondigas", "calamares", "pimientos de padrón", "ensalada"
      ],
      "Thai": [
        "pad thai", "green curry", "tom yum", "som tam", "massaman curry",
        "pad see ew", "spring rolls", "red curry", "larb", "khao soi",
        "satay", "panang curry", "sticky rice", "tom kha gai", "mango sticky rice"
      ],
      "Korean": [
        "kimchi", "bulgogi", "bibimbap", "kimbap", "japchae",
        "tteokbokki", "galbi", "sundubu jjigae", "kimchi fried rice", "mandu",
        "naengmyeon", "hotteok", "banchan", "chimaek", "sikhye"
      ],
      "Vietnamese": [
        "pho", "banh mi", "spring rolls", "bun cha", "com tam",
        "goi cuon", "cha ca", "hu tieu", "bánh xèo", "cà phê sữa đá",
        "xoi", "bánh bao", "bún bò Huế", "mi quang", "che"
      ],
      "Middle Eastern": [
        "hummus", "falafel", "tabbouleh", "shawarma", "kebabs",
        "baba ghanoush", "pita bread", "fattoush", "kousa mahshi", "mujadara",
        "kofta", "labneh", "shakshuka", "mansaf", "baklava"
      ],
      "Caribbean": [
        "jerk chicken", "rice and peas", "plantains", "callaloo", "patties",
        "curry goat", "roti", "sorrel", "ackee", "codfish",
        "rum cake", "conch fritters", "bake and shark", "kallaloo", "souse"
      ],
      "American": [
        "hamburger", "hot dog", "barbecue", "apple pie", "fried chicken",
        "mac and cheese", "buffalo wings", "cornbread", "meatloaf", "clam chowder",
        "bagel", "donut", "cobb salad", "cheeseburger", "pancakes"
      ],
      "Fusion": [
        "sushi burrito", "korean taco", "ramen burger", "pasta primavera", "biryani pizza",
        "butter chicken poutine", "pho ramen", "sushi pizza", "cajun pasta", "pasta taco",
        "sushi rolls", "curry pizza", "chili nachos", "tandoori quesadilla", "kebab pizza"
      ]
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
      await DatabaseHelper().updateMaxScore('food', score);
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
