import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';


// The main function is the entry point of the application.
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    //fullScreen: true,
    size: Size(400,300),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const PuterPetsApp());
}

// The root widget of the application.
class PuterPetsApp extends StatelessWidget {
  const PuterPetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PuterPets', // The title of the app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.transparent), // Sets a theme color scheme
        useMaterial3: true, // Uses Material Design 3
      ),
      home: const MainMenu(), // Sets the initial screen to MainMenu
    );
  }
}

// This is the main menu screen, which contains three buttons.
class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('PuterPets Menu'), // The title of the app bar
      ),
      body: Center(
        child: SizedBox(
          width: 200, // Limits the width of the buttons container to 200 pixels
          child: Column(
            mainAxisSize: MainAxisSize
                .min, // Makes the column take up minimal space vertically
            children: [
              // The "Add Pet" button
              ElevatedButton(
                onPressed: () {
                  // Navigates to the PetSelectionScreen when pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PetSelectionScreen()),
                  );
                },
                child: const Text('Add Pet'),
              ),
              const SizedBox(
                  height: 10), // Adds some vertical space between buttons

              // The "Remove Pet" button
              ElevatedButton(
                onPressed: () {
                  // Placeholder function for removing a pet
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Remove Pet function')),
                  );
                },
                child: const Text('Remove Pet'),
              ),
              const SizedBox(
                  height: 10), // Adds some vertical space between buttons

              // The "Play Fetch" button
              ElevatedButton(
                onPressed: () {
                  // Placeholder function for playing with a pet
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Play Fetch function')),
                  );
                },
                child: const Text('Play Fetch'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// The Pet model class that defines a pet with a name and an image path.
class Pet {
  final String name;
  final String imagePath;

  Pet({required this.name, required this.imagePath});
}

// The screen where the user selects a pet.
class PetSelectionScreen extends StatelessWidget {
  const PetSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of pets to display
    final List<Pet> pets = [
      Pet(name: 'Dog', imagePath: 'assets/dog.png'),
      Pet(name: 'Cat', imagePath: 'assets/cat.png'),
      Pet(name: 'Bird', imagePath: 'assets/bird.png'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Pet'), // The title of the app bar
      ),
      // A grid view to display the pets
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          mainAxisSpacing: 10, // Vertical spacing between items
          crossAxisSpacing: 10, // Horizontal spacing between items
        ),
        itemCount: pets.length, // The number of items in the list
        itemBuilder: (context, index) {
          final pet = pets[index];
          return GestureDetector(
            onTap: () {
              // When a pet is tapped, navigate to the PetInteractionScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PetInteractionScreen(pet: pet),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey,
                    width: 3), // Adds a border around each pet
                borderRadius: BorderRadius.circular(
                    10), // Rounds the corners of the border
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centers the content vertically
                children: [
                  Image.asset(pet.imagePath,
                      width: 80, height: 80), // Displays the pet image
                  const SizedBox(
                      height: 10), // Adds some space between the image and text
                  Text(pet.name,
                      style: const TextStyle(
                          fontSize: 16)), // Displays the pet name
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// The screen where the user interacts with the selected pet.
class PetInteractionScreen extends StatelessWidget {
  final Pet pet;

  const PetInteractionScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Play with ${pet.name}'), // The title of the app bar includes the pet's name
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            // When the pet image is tapped, show a SnackBar with a message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('You played with ${pet.name}!')),
            );
          },
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centers the content vertically
            children: [
              Image.asset(pet.imagePath,
                  width: 150, height: 150), // Displays the pet image
              const SizedBox(
                  height: 20), // Adds some space between the image and text
              Text(
                'Tap to play with ${pet.name}', // Displays an instruction message
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
