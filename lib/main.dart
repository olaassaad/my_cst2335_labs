import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'BROWSE CATEGORIES',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Not sure about exactly which recipe you are looking for? Do a search, or dive into our most popular categories.',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18),
              ),
              const Text(
                'BY MEAT',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              // Row 1: Images with text in the center
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildImageStack('images/Beef.jpg', 'BEEF'),
                  buildImageStack('images/Chicken.jpg', 'CHICKEN'),
                  buildImageStack('images/Pork.jpg', 'PORK'),
                  buildImageStack('images/Seafood.jpg', 'SEAFOOD'),
                ],
              ),
              const Text(
                'BY COURSE',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Row 2: Images with text at the bottom
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildImageWithTextBelow('images/Main.jpg', 'Main Dishes'),
                  buildImageWithTextBelow('images/Salad.jpg', 'Salad Recipes'),
                  buildImageWithTextBelow('images/Side.jpg', 'Side Dishes'),
                  buildImageWithTextBelow('images/Crockpot.jpg', 'Crockpot'),
                ],
              ),
              const Text(
                'BY DESSERT',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Row 3: Dessert images with text at the bottom
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildImageWithTextBelow('images/IceCream.jpg', 'Ice Cream'),
                  buildImageWithTextBelow('images/Brownies.jpg', 'Brownies'),
                  buildImageWithTextBelow('images/Pie.jpg', 'Pies'),
                  buildImageWithTextBelow('images/Cookies.jpg', 'Cookies'),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  // Widget for images with text in the center
  Widget buildImageStack(String imagePath, String label) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 50,
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Widget for images with text below
  Widget buildImageWithTextBelow(String imagePath, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 50,
        ),
        const SizedBox(height: 5), // Add spacing between the image and text
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
