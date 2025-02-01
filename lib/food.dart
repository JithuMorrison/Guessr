import 'dart:math';
import 'package:flutter/material.dart';

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
