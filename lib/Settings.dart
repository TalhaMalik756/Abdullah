import 'package:flutter/material.dart';
import 'Bottom.dart';
import 'LoginSignup/LoginPage.dart'; // Import your LoginPage.dart file here

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.36),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Bottom(),
                ),
              );
            },
          ),
          title: Text(
            'Settings',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/CountrySide.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          Card(
            elevation: 4.0, // Add elevation to the card
            child: ListTile(
              tileColor: Color(0xFFECFFDC), // Set tile color to background color
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(), // Navigate to LoginPage.dart
                  ),
                );
              },
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFECFFDC),
    );
  }
}
