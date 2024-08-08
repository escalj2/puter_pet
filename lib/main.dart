import 'package:flutter/material.dart';

void main() {
  runApp(const PuterPetsApp());
}

class PuterPetsApp extends StatelessWidget {
  const PuterPetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PuterPets',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PuterPets Menu'),
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PetSelectionScreen()),
                  );
                },
                child: const Text('Add Pet'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Functionality for "Remove Pet"
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Remove Pet function')),
                  );
                },
                child: const Text('Remove Pet'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Functionality for "Play with Pet"
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Play with Pet function')),
                  );
                },
                child: const Text('Play with Pet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PetSelectionScreen extends StatelessWidget {
  const PetSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Pet> pets = [
      Pet(name: 'Dog', imagePath: 'assets/dog.png'),
      Pet(name: 'Cat', imagePath: 'assets/cat.png'),
      Pet(name: 'Bird', imagePath: 'assets/bird.png'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Pet'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PetInteractionScreen(pet: pet),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(pet.imagePath, width: 80, height: 80),
                  const SizedBox(height: 10),
                  Text(pet.name, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PetInteractionScreen extends StatelessWidget {
  final Pet pet;

  const PetInteractionScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play with ${pet.name}'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('You played with ${pet.name}!')),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(pet.imagePath, width: 150, height: 150),
              const SizedBox(height: 20),
              Text(
                'Tap to play with ${pet.name}',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Pet {
  final String name;
  final String imagePath;

  Pet({required this.name, required this.imagePath});
}
