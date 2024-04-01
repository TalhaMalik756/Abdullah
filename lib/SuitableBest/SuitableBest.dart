import 'package:flutter/material.dart';
import 'BestCrop.dart';
import 'SuitableCrop.dart';

class SuitableBest extends StatelessWidget {
  const SuitableBest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECFFDC),
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Back arrow icon in black
          onPressed: () {
            Navigator.pop(context); // Pop the current route
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Color(0xFFECFFDC),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10), // Adjust padding here
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SuitableCrop()), // Navigate to SuitableCrop.dart
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF006400),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 44, vertical: 10), // Adjust padding here
                      child: Text(
                        'Suitable Crop',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 23, // Adjust font size here
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BestCrop()), // Navigate to BestCrop.dart
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF006400),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 64, vertical: 10), // Adjust padding here
                      child: Text(
                        'Best Crop',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 23, // Adjust font size here
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}