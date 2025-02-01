import 'dart:math';
import 'package:flutter/material.dart';

class HangmanGamea extends StatefulWidget {
  @override
  _HangmanGameaState createState() => _HangmanGameaState();
}

class _HangmanGameaState extends State<HangmanGamea> {
  // Dictionary where the clue is the key and the value is a list of words to guess
  final Map<String, List<String>> clueWords = {
    "Mammals": ["African buffalo", "African elephant", "African lion", "American bison", "American black bear", "American porcupine", "Arctic fox", "Asian elephant", "Asian golden cat", "Bengal tiger (orange)", "Siberian tiger", "Black bear", "Bongo", "Bottlenose dolphin", "Brown bear", "Capybara", "Cheetah", "Chimpanzee", "Common vampire bat", "Dall's sheep", "Deer", "Dhole", "Dromedary camel", "Emperor tamarin", "Fennec fox", "Giraffe", "Gray wolf", "Greenland halibut", "Grizzly bear", "Himalayan tahr", "Hokkaido brown bear", "Horse", "Indigo Bunting", "Indian elephant", "Indian leopard", "Iriomote cat", "Kinkajou", "Koala", "Lemur", "Lion", "Long-tailed macaque", "Lowland gorilla", "Maned wolf", "Markhor", "Mongoose", "Numbat", "Okapi", "Orangutan", "Platypus", "Polar bear", "Red fox", "Red panda", "Reticulated giraffe", "Ring-tailed lemur", "Saddleback tamarin", "Sika deer", "Sumatran tiger", "Tamarins", "Tasmanian devil", "Vicuña", "Western lowland gorilla", "White rhinoceros", "Zebra", "Aardvark", "Aardwolf", "Alpaca", "Anteater", "Armadillo", "Badger", "Binturong", "Bison", "Bobcat", "Civet", "Coati", "Dingo", "Dromedary", "Eastern gray kangaroo", "Emu", "Ferret", "Flying fox", "Fruit bat", "Gelada baboon", "Gibbon", "Golden retriever", "Hedgehog", "Humpback whale", "Impala", "Jaguar", "Kangaroo", "Leopard", "Lynx", "Marmot", "Minke whale", "Musk ox", "Okapi", "Otter", "Pangolin", "Porcupine", "Quokka", "Red kangaroo", "Rhinoceros", "Sea lion", "Sea otter", "Sperm whale", "Springbok", "Tapir", "Wallaby", "Wolverine", "Zorilla", "Antelope", "Bongo antelope", "Chinchilla", "Elephant seal", "Gelada", "Guanaco", "Harbor seal", "Hyena", "Ibex", "Indri", "Jaguarundi", "Kudu", "Mandrill", "Marabou stork", "Meerkat", "Mongoose lemur", "Mountain goat", "Ocelot", "Okapi", "Otterhound", "Pika", "Raccoon", "Red wolf", "Sifaka", "Solomon Islands skink", "Spotted hyena", "Tarsier", "Thomson's gazelle", "Vervet monkey", "Wild boar", "Wombat"],
    "Birds": ["Abyssinian Ground Hornbill", "African Grey Parrot", "American Alligator", "American Flamingo", "American Robin", "Andean Condor", "Arctic Tern", "Bald Eagle", "Barn Owl", "Bateleur Eagle", "Bearded Vulture", "Belizean Roseate Spoonbill", "Bengal Florican", "Bermuda Petrel", "Bicolored Antbird", "Bishop's Bunting", "Black Cockatoo", "Black-throated Blue Warbler", "Blue Jay", "Blue-footed Booby", "Bongo II", "Brambling", "Brown Pelican", "Buff-breasted Sandpiper", "California Condor", "Canary", "Caspian Tern", "Chilean Flamingo", "Chinese Egret", "Common Blackbird", "Common Chiffchaff", "Common Crow", "Common Eider", "Common Ibis", "Common Raven", "Common Redstart", "Common Sparrow", "Crimson-collared Tanager", "Crowned Crane", "Crowned Pigeon", "Dartford Warbler", "Eurasian Blue Tit", "Eurasian Collared Dove", "European Bee-eater", "European Goldfinch", "Falkland Steamer Duck", "Flamingo", "Fulvous Whistling Duck", "Gadwall", "Giant Ibis", "Gilded Flicker", "Golden Eagle", "Great Blue Heron", "Great Horned Owl", "Greater Sage-Grouse", "Green Parakeet", "Himalayan Monal", "Hooded Merganser", "Indian Peafowl", "Indigo Bunting", "Ivory Gull", "Kea", "King Vulture", "Kookaburra", "Lappet-faced Vulture", "Lesser Flamingo", "Lesser Prairie Chicken", "Tawny frogmouth", "Lesser Yellowlegs", "Mandarin Duck", "Marabou Stork", "Masked Booby", "Mountain Bluebird", "Northern Cardinal", "Northern Flicker", "Northern Goshawk", "Osprey", "Ostrich", "Peregrine Falcon", "Pigeon", "Pintail", "Puffin", "Red-tailed Hawk", "Ruffed Grouse", "Scarlet Macaw", "Secretary Bird", "Shoveler", "Snowy Owl", "Spoonbill", "Swan", "Tawny Owl", "Tern", "Toco Toucan", "Turkey Vulture","Elephant bird", "Vulturine Guineafowl", "Western Bluebird", "Western Sandpiper", "Wood Duck", "Yellow-billed Cuckoo", "Yellow Warbler"],
    "Reptiles": ["African rock python", "Alligator", "American crocodile", "Anaconda", "Armadillo girdled lizard", "Asian water monitor", "Australian saltwater crocodile", "Bearded dragon", "Black mamba", "Blue iguana", "Burmese python", "Chameleons", "Common garter snake", "Common green iguana", "Cottonmouth", "Desert tortoise", "Diamondback rattlesnake", "Eastern box turtle", "Eastern diamondback rattlesnake", "Frilled-neck lizard", "Gila monster", "Green anaconda", "Green sea turtle", "Hawksbill sea turtle", "Indigo snake", "Jackson's chameleon", "Kinyongia", "Komodo dragon", "Leatherback sea turtle", "Lizard", "Monitor lizard", "Nile crocodile", "Pygmy rattlesnake", "Red-eared slider", "Reticulated python", "Rhinoceros iguana", "Sea turtle", "Slender-snouted crocodile", "Speckled king snake", "Spectacled caiman", "Spiny lizard", "Tortoise", "Tuataras", "Western diamondback rattlesnake", "Yucatán spiny-tailed iguana", "Green tree python", "Black caiman", "Gopher tortoise", "Horned lizard", "Pangolin", "Basilisk", "Brown tree snake", "Copperhead", "Common snapping turtle", "Iguana", "Iridescent skink", "Marine iguana", "Oriental rat snake", "Pygmy chameleon", "Red-footed tortoise", "Russian tortoise", "Savannah monitor", "Speckled rattlesnake", "Gargoyle gecko", "Tiger rattlesnake", "Timber rattlesnake", "Western pond turtle", "Zebra-tailed lizard","Guatemalan Beaded Lizard", "Fiji Crested Iguana","Psychedelic Rock Gecko","Hidden Dragon","Leopard tortoise", "African spurred tortoise", "Texas horned lizard", "Chinese water dragon", "Flying dragon", "Lace monitor", "Black-headed python", "Eastern indigo snake", "Fiji banded iguana", "Giant tortoise", "Mata mata turtle", "Radiated tortoise", "Rose-haired tarantula", "Egyptian cobras", "Eastern coral snake", "Crested gecko", "Frilled dragon", "Green iguana", "Korean rat snake", "Southern alligator lizard", "Tokay gecko", "Chukchi leaf-toed gecko", "Woma python", "Western hognose snake", "Pine snake", "Florida softshell turtle", "European adder", "Mexican spiny-tailed iguana", "Common boa constrictor", "Aldabra giant tortoise", "Black-tailed rattlesnake", "Caiman lizard", "Giant anaconda", "Aruba rattlesnake", "Horned rattlesnake", "Colombian rainbow boa", "Caspian turtle", "Beaded lizard", "Blue poison dart frog", "Chaco tortoise", "Ornate box turtle"],
    "Amphibians": ["African clawed frog", "American bullfrog", "American toad", "Axolotl", "Boreal chorus frog", "Bullfrog", "Common frog", "Common green tree frog", "Common toad", "Cricket frog", "Eastern tiger salamander", "Eastern newt", "Fire-bellied toad", "Goliath frog", "Green frog", "Green tree frog", "Hellbender", "Iberian ribbed newt", "Japanese tree frog", "Lesser siren", "Marbled salamander", "Mexican axolotl", "Northern leopard frog", "Northern red salamander", "Olive tree frog", "Pacific tree frog", "Pygmy salamander", "Red-eyed tree frog", "Red-legged frog", "Red-spotted newt", "Salamander", "Savannah monitor", "Smooth newt", "Southern leopard frog", "Southern toad", "Spring peeper", "Spotted salamander", "Spotted tree frog", "Tiger salamander", "Toad", "Wood frog", "Adriatic newt", "Alder frog", "Alpine newt", "American tree frog", "Anaxyrus boreas", "Anaxyrus cognatus", "Anura", "Armadillo girdled lizard", "Arthroleptis", "Asian toad", "Austrian smooth newt", "Balkan green lizard", "Barking tree frog", "Barred tiger salamander", "Barnes' tree frog", "Bicolor toad", "Boreal toad", "Brazilian horned frog", "Bullfrog tadpole", "Caribbean tree frog", "Centralian rough knob-tail gecko", "Common mudpuppy", "Common spotted frog", "Cuban tree frog", "Czech smooth newt", "Dainty tree frog", "Dart frog", "Eastern gray tree frog", "Eastern red-backed salamander", "Eastern spadefoot", "Elfin tree frog", "European common frog", "European green toad", "European tree frog", "Fire salamander", "Flatwoods salamander", "Fowler's toad", "Giant river frog", "Giant toad", "Giant warty newt", "Green and black poison dart frog", "Green and yellow macaw", "Green tree frog tadpole", "Himalayan frog", "Holbrookia", "Hula painted frog", "Indian bullfrog", "Indian frog", "Inland taipan", "Japanese pond turtle", "Japanese red-bellied newt", "Lakeside tree frog", "Lizard frog", "Litoria caerulea", "Litoria chloris", "Litoria gracilenta", "Litoria latopalmata", "Litoria myola", "Litoria phyllochroa", "Litoria rubella", "Little brown frog", "Marsh frog", "Marshland frog", "Mountain yellow-legged frog", "Mudpuppy", "Mudpuppy tadpole", "Newt", "Northern bog lemming", "Northern cricket frog", "Northern red salamander", "Oriental fire-bellied toad", "Pacific gopher frog", "Pale-spotted salamander", "Panamanian golden frog", "Pond newt", "Red-back salamander", "Red-legged frog tadpole", "Red-spotted newt tadpole", "Rhinella marina", "Rhinella granulosa", "Rhinella jimi", "Rhinella schneideri", "Ribbed newt", "Rugose salamander", "Salamander larva", "Salamander newt", "Sierra newt", "Southern marsh frog", "Spadefoot toad", "Spotted salamander larva", "Sri Lankan frog", "Sierra yellow-legged frog", "Tadpole", "Taiwanese tree frog", "Tawny frogmouth", "Tibetan frog", "Tiger salamander tadpole", "Toad tadpole", "Tree frog", "Trumpet frog", "Western American toad", "Western boreal toad", "Western chorus frog", "Western pond turtle", "Western spotted frog", "Wood frog tadpole", "Yellow-legged frog", "Yellow-spotted salamander", "Zebra frog", "Zebra-striped tree frog"],
    "Fish": ["Abyssal Cusk-Eel", "African Cichlid", "Alaska Pollock", "Anglerfish", "Arapaima", "Asian Arowana", "Atlantic Salmon", "Barb", "Barracuda", "Basking Shark", "Beta Fish", "Bony Fish", "Butterfly Fish", "Catfish", "Clownfish", "Corydoras", "Dab Fish", "Dace", "Dartfish", "Dolly Varden", "Dolphin Fish", "Drum Fish", "Dungeness Crab", "Eel", "Electric Eel", "Emperor Angelfish", "Gudgeon", "Guppy", "Haddock", "Hake", "Halibut", "Herring", "Humpback Whale", "Jack", "Jawfish", "Koi", "Kuwait Crab", "Lake Whitefish", "Largemouth Bass", "Mackerel", "Mandarin Fish", "Marlin", "Megalodon", "Moray Eel", "Mullet", "Pangasius", "Pike", "Piranha", "Pollock", "Pompano", "Rainbow Trout", "Red Snapper", "Reef Shark", "River Herring", "Rock Cod", "Sailfish", "Salmon", "Sardine", "Scad", "Sea Bass", "Sea Bream", "Sea Cucumber", "Sea Horse", "Shark", "Shad", "Sole", "Sturgeon", "Swordfish", "Tilapia", "Trout", "Tuna", "Wahoo", "Whitefish", "Yellowfin Tuna", "Yellowtail", "Zander", "Zebra Fish", "Ocean Sunfish", "Ruffe", "Freshwater Prawn", "Kelp Greenling", "Longspine Thornyhead", "Ocean Perch", "Red Drum", "Spanish Mackerel", "White Marlin", "Bony Fish", "Lemon Shark", "Smoothhound", "Banded Rockfish", "Coho Salmon", "Sockeye Salmon", "Black Rockfish", "Pacific Bluefin Tuna", "Atlantic Bluefin Tuna", "Leatherback Turtle", "Rainbowfish", "Dwarf Gourami", "Kuhli Loach", "Zebra Danio", "Firemouth Cichlid", "Neon Tetra", "Glass Catfish", "Rosy Barb", "Rainbow Shark", "Siamese Fighting Fish", "Pseudotropheus", "Cichlid", "Pufferfish", "Butterflyfish", "Angelfish", "Pike Cichlid", "Rasbora", "Gudgeon", "Tetra", "Suckermouth Catfish", "Loach", "Barb", "Killifish", "Tropical Fish", "Giant Gourami", "Goldfish", "Marble Trout", "Bitterling", "European Eel", "Gar", "Sea Lamprey", "Chub", "Northern Pike", "Redfish", "Mudskipper", "Giant Catfish", "Scad", "Thorny Devil", "Bream", "Green Sunfish", "Muskellunge", "Bluegill", "Rock Bass", "Redear Sunfish", "Channel Catfish", "Flathead Catfish", "Bullhead Catfish", "Mud Catfish", "Round Goby", "Common Carp", "Carp", "Tench", "Rudd", "Golden Rudd", "European Carp", "Spotted Gar", "Sailfin Molly", "Mexican Tetra", "Fish of the Great Lakes", "Clown Loach", "Largescale Sucker", "Tetraodon", "Anglerfish", "Longnose Gar", "Tigerfish", "Arapaima gigas", "Giant Devil Ray", "Sunfish", "Lanternfish", "Roughy", "Icefish", "Viperfish", "Paddlefish", "Bumphead Parrotfish", "Giant Trevally", "Coral Trout", "Sawfish", "Stonefish", "Black Marlin", "Mahi-Mahi", "Mako Shark", "Bull Shark", "Thresher Shark", "Wobbegong", "Nassau Grouper", "Humphead Wrasse", "Saddleback Clownfish", "Pygmy Seahorse", "Lionfish", "Blenny", "Wrasse", "Triggerfish", "Boxfish", "Butterfish", "Scad", "Sardines", "Scad", "Upside Down Catfish", "Banded Palm Shark", "Spiny Dogfish", "Opah", "Kakahi", "Forktail Catfish", "Salmon Shark", "Flatfish", "Bettas", "Banggai Cardinalfish", "Pike Perch", "Amberjack", "Bongo Catfish", "Black Sea Bass", "Bluefin Tuna", "Chum Salmon", "Coral Catshark", "Dwarf Puffer", "Frilled Shark", "Giant Oceanic Manta Ray", "Japanese Macaque", "Moorish Idol", "Muskellunge", "Octopus", "Pike", "Suckermouth", "Toadfish", "Frogfish"],
    "Insects": ["Aphid", "Ant", "Apple Maggot", "Armyworm", "Asian Giant Hornet", "Bald-faced Hornet", "Bumblebee", "Carpenter Ant", "Caterpillar", "Cicada", "Cockroach", "Caterpillar", "Cricket", "Cuckoo Bee", "Dragonfly", "Dung Beetle", "Earwig", "Flea", "Fly", "Giant Water Bug", "Grasshopper", "Green Lacewing", "Hagfish", "Horsefly", "Housefly", "Ladybug", "Leafcutter Ant", "Lice", "Luna Moth", "Mantis", "Mayfly", "Mealybug", "Metallic Blue Butterfly", "Midge", "Mole Cricket", "Mosquito", "Moth", "Mantis Shrimp", "Nematode", "Pill Bug", "Planthopper", "Pollen Beetle", "Praying Mantis", "Queen Bee", "Red Imported Fire Ant", "Reindeer Fly", "Scarab Beetle", "Silverfish", "Skipper Butterfly", "Spiders", "Stag Beetle", "Stick Insect", "Termite", "Tiger Beetle", "Tortoise Beetle", "Vine Weevil", "Wasp", "Yellowjacket", "Zebra Butterfly", "Acorn Weevil", "Alfalfa Weevil", "Anopheles Mosquito", "Antlion", "Aphid", "Asian Lady Beetle", "Banded Woolly Bear", "Basilisk Bug", "Bedbug", "Big-headed Ant", "Black Widow Spider", "Boll Weevil", "Boring Insect", "Boxelder Bug", "Carpenter Bee", "Cecropia Moth", "Chinch Bug", "Chironomid", "Clover Mite", "Clouded Sulphur Butterfly", "Cocoa Midge", "Common Green Lacewing", "Common Yellow Swallowtail", "Cotton Flea Beetle", "Cow Killer Ant", "Crab Spider", "Cricket Fly", "Cricket Midge", "Cucumber Beetle", "Cutworm", "Damsel Fly", "Darkling Beetle", "Death's-head Hawkmoth", "Dewdrop Spider", "Digger Wasp", "Dirt Fly", "Dobsonfly", "Dogbane Leaf Beetle", "Dogwood Borer", "Eastern Yellow Swallowtail", "Elm Leaf Beetle", "Emperor Moth", "European Hornet", "European Mantis", "Field Cricket", "Fire Ant", "Flycatcher Moth", "Forest Tent Caterpillar", "Four-spotted Skimmer", "Fritillary Butterfly", "Fruit Fly", "Gall Fly", "Giant Walking Stick", "Glowing Caterpillar", "Golden Tortoise Beetle", "Grapevine Moth", "Grasshoppers", "Green Caterpillar", "Green Lacewing", "Hawk Moth", "Helicopter Fly", "Honey Bee", "Horse Fly", "Hoverfly", "Housefly", "Imperial Moth", "Indigo Bunting", "Japanese Beetle", "Jewel Beetle", "Leaf Beetle", "Leafhopper", "Longhorn Beetle", "Luna Moth", "Maggot", "Mealybug", "Millipede", "Mite", "Mole Cricket", "Moth Fly", "Mountain Pine Beetle", "Mud Dauber", "Murmur Moth", "Naked Ant", "Noseeum", "Nymph", "Oak Leafroller", "Ochre Jelly", "Omnivorous Looper", "Paper Wasp", "Pea Weevil", "Phantom Midge", "Pigeon Tick", "Pine Weevil", "Planthopper", "Pollen Wasp", "Potato Beetle", "Praying Mantis", "Red Ant", "Robber Fly", "Sand Fly", "Scorpion Fly", "Screw-worm Fly", "Silkworm", "Silverfish", "Skipper", "Slug", "Snout Beetle", "Sod Webworm", "Spicebush Swallowtail", "Spider Mite", "Spittlebug", "Stink Bug", "Tarantula", "Termite", "Tiger Moth", "Tiger Swallowtail", "Tornado Ant", "Treehopper", "Two-spotted Spider Mite", "Vagrant Dung Beetle", "Violet Ash Midge", "Wandering Glider", "Weevil", "Yellow Woolly Bear", "Zebra Midge"],
    "Molluscs": ["Abalone", "African Giant Snail", "Ammonite", "Anatomy of a Snail", "Argonaut", "Atlantic Surf Clam", "Australian Blacklip Abalone", "Blue Mussel", "Boring Clam", "Cuttlefish", "Chambered Nautilus", "Chocolate Clam", "Cone Snail", "Coney Island Sea Slug", "Cowrie", "Curly Tusk Shell", "Eastern Oyster", "European Common Scallop", "Giant Clam", "Giant Pacific Octopus", "Grape Sea Slug", "Green Mussel", "Guitar Fish", "Horseshoe Crab", "Killer Clam", "Knobbed Whelk", "Limpet", "Little Neck Clam", "Mahi Mahi", "Mantis Shrimp", "Margarita Snail", "Marine Snail", "Mollusk", "Moon Snail", "Mussel", "Nautilus", "Octopus", "Oyster", "Pencil Urchin", "Periwinkle", "Pistol Shrimp", "Plum Curculio", "Pond Snail", "Purple Sea Urchin", "Razor Clam", "Red Sea Urchin", "Rock Snail", "Scallop", "Sea Cucumber", "Sea Hare", "Sea Slug", "Sea Squirt", "Shellfish", "Snail", "Turbot", "Tusk Shell", "Tusk Shell", "Venus Clam", "Whelk", "Worm Snail", "Yellow Murex"],
    "Echinoderms": ["Basket Star", "Brittle Star", "Crown-of-thorns Starfish", "Daisy Brittle Star", "Feather Star", "Heart Urchin", "Holothurian", "Lily Star", "Ochre Sea Star", "Sand Dollar", "Sea Cucumber", "Sea Lily", "Sea Star", "Sea Urchin", "Sunflower Star", "Tube Feet", "Urchin", "Pencil Urchin", "Clypeaster", "Asteroid", "Echinoid", "Ophiuroidea", "Crinoidea", "Holothuroidea", "Asteriodea", "Purple Sea Urchin", "Green Sea Urchin", "Red Sea Urchin", "Chocolate Chip Sea Star", "Blue Sea Star", "Margarita Sea Star", "Banded Sea Star", "Giant Sea Cucumber", "Kona Sea Cucumber", "Northern Sea Star", "Giant Red Sea Star", "Spiny Sea Star", "Lined Sea Cucumber", "Warty Sea Cucumber", "Crown-of-thorns Starfish", "Common Sand Dollar", "Sea Biscuit", "Orange Sea Star", "Serpent Star", "Common Sea Cucumber", "Green Brittle Star", "Black Brittle Star", "Hollow-bodied Sea Cucumber", "Pentagon Star", "Scarab Sea Star", "Blunt-spined Sea Urchin", "Short-spined Sea Urchin", "Japanese Sea Cucumber", "Chocolate Sea Star", "Tropical Sea Cucumber", "Red Warty Sea Cucumber"],
    "Mythical Animals":["Dragon", "Unicorn", "Phoenix", "Griffin", "Mermaid", "Sphinx", "Chimera", "Pegasus", "Basilisk", "Cerberus", "Kraken", "Hydra", "Kitsune", "Yeti", "Chupacabra", "Banshee", "Fairy", "Golem", "Thunderbird", "Manticore", "Nymph", "Siren", "Wendigo", "Sasquatch", "Puca", "Nuckelavee", "Selkie", "Yarime", "Jackalope", "Troll", "Skinwalker", "Merrow", "Basilisk", "Kappa", "Amphitere", "Mokele-Mbembe", "Qilin", "Tengu", "Sahuagin", "Dullahan", "Kitsune", "Chimaera", "Dryad", "Imp", "Gorgon", "Harpy", "Werewolf", "Minotaur", "Satyr", "Vampire", "Zombie", "Leprechaun"],
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
