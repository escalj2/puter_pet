import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

// The main function is the entry point of the application.
void main() async {
  // Ensures that Flutter is properly initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  // Ensures that the window manager is initialized. This is required for managing window properties.
  await windowManager.ensureInitialized();

  // Configures the window options such as size and appearance.
  WindowOptions windowOptions = const WindowOptions(
    size: Size(400, 300), // Sets the window size to 400x300 pixels.
    center: true, // Centers the window on the screen.
    backgroundColor:
        Colors.transparent, // Makes the window background transparent.
    skipTaskbar: false, // Ensures the window appears in the taskbar.
    titleBarStyle: TitleBarStyle.hidden, // Hides the title bar.
  );

  // Waits until the window is ready to show, then displays and focuses it.
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show(); // Displays the window.
    await windowManager.focus(); // Brings the window into focus.
  });

  // Runs the application with the PuterPetsApp widget as the root.
  runApp(const PuterPetsApp());
}

// The root widget of the application.
class PuterPetsApp extends StatelessWidget {
  const PuterPetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PuterPets', // The title of the application.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green), // Sets the color scheme of the app.
        useMaterial3: true, // Enables Material Design 3.
      ),
      home: const MainMenu(), // Sets the initial screen to the MainMenu widget.
    );
  }
}

// This widget represents the main menu screen, which contains buttons.
class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('PuterPets Menu'), // The title displayed on the app bar.
      ),
      body: Center(
        child: SizedBox(
          width: 200, // Limits the width of the button container to 200 pixels.
          child: Column(
            mainAxisSize: MainAxisSize
                .min, // Makes the column take up minimal vertical space.
            children: [
              // Button to add a pet.
              ElevatedButton(
                onPressed: () {
                  // Navigates to the PetSelectionScreen when pressed.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PetSelectionScreen()),
                  );
                },
                child: const Text('Add Pet'), // Text displayed on the button.
              ),
              const SizedBox(
                  height: 10), // Adds vertical space between buttons.

              // Button to remove a pet (currently a placeholder).
              ElevatedButton(
                onPressed: () {
                  // Shows a SnackBar with a message when pressed.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Remove Pet function')),
                  );
                },
                child:
                    const Text('Remove Pet'), // Text displayed on the button.
              ),
              const SizedBox(
                  height: 10), // Adds vertical space between buttons.

              // Button to play fetch with a pet (currently a placeholder).
              ElevatedButton(
                onPressed: () {
                  // Shows a SnackBar with a message when pressed.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Play Fetch function')),
                  );
                },
                child:
                    const Text('Play Fetch'), // Text displayed on the button.
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Model class that defines a pet with a name and an image path.
class Pet {
  final String name;
  final String imagePath;

  Pet({required this.name, required this.imagePath});
}

// Screen where the user selects a pet.
class PetSelectionScreen extends StatelessWidget {
  const PetSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of pets to display with their names and image paths.
    final List<Pet> pets = [
      Pet(name: 'Dog', imagePath: 'assets/dog.png'),
      Pet(name: 'Cat', imagePath: 'assets/cat.png'),
      Pet(name: 'Bird', imagePath: 'assets/bird.png'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Select Your Pet'), // The title displayed on the app bar.
      ),
      // A grid view to display the list of pets.
      body: GridView.builder(
        padding: const EdgeInsets.all(10), // Adds padding around the grid view.
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid.
          mainAxisSpacing: 10, // Vertical spacing between grid items.
          crossAxisSpacing: 10, // Horizontal spacing between grid items.
        ),
        itemCount: pets.length, // Number of items in the list.
        itemBuilder: (context, index) {
          final pet = pets[index]; // Gets the pet at the current index.
          return GestureDetector(
            onTap: () {
              // Navigates to the PetInteractionScreen when a pet is tapped.
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
                    width: 3), // Adds a border around each pet.
                borderRadius: BorderRadius.circular(
                    10), // Rounds the corners of the border.
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centers content vertically.
                children: [
                  Image.asset(pet.imagePath,
                      width: 80, height: 80), // Displays the pet image.
                  const SizedBox(
                      height: 10), // Adds space between the image and text.
                  Text(pet.name,
                      style: const TextStyle(
                          fontSize: 16)), // Displays the pet's name.
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Screen where the user interacts with the selected pet.
class PetInteractionScreen extends StatelessWidget {
  final Pet pet;

  const PetInteractionScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Play with ${pet.name}'), // The title includes the selected pet's name.
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Shows a SnackBar with a message when the pet image is tapped.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('You played with ${pet.name}!')),
            );
          },
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centers content vertically.
            children: [
              Image.asset(pet.imagePath,
                  width: 150, height: 150), // Displays the pet image.
              const SizedBox(
                  height: 20), // Adds space between the image and text.
              Text(
                'Tap to play with ${pet.name}', // Instruction message.
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
