import 'package:flutter/material.dart';
import 'Generate_Enter/GenEnter.dart'; // Importing the GenEnter.dart file

class DippingPoint extends StatefulWidget {
  const DippingPoint({Key? key}) : super(key: key);

  @override
  _DippingPointState createState() => _DippingPointState();
}

class _DippingPointState extends State<DippingPoint> {
  List<bool> isClicked = List.generate(9, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/Soil.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Back button
          Positioned(
            top: 34,
            left: 5,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // Title
          Positioned(
            top: 40,
            left: 56,
            child: Text(
              'Dipping Point',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          // Grid with cells
          Positioned(
            top: MediaQuery.of(context).size.height * 1 / 10, // Position the grid 1/9th from the top
            left: 0,
            right: 0,
            bottom: 60, // Adjust bottom padding for the "Next" button
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 10, // Add spacing between rows
              childAspectRatio: 0.573, // Adjust the aspect ratio to elongate the cells
              padding: EdgeInsets.all(10),
              children: List.generate(
                9,
                    (index) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.circle),
                      color: isClicked[index] ? Colors.red : Colors.white,
                      onPressed: () {
                        setState(() {
                          isClicked[index] = !isClicked[index];
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 16,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenEnter()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF006400),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80),
                ),
              ),
              child: Text(
                'Next',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
