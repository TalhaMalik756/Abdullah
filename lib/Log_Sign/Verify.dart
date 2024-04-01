import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class MyVerify extends StatefulWidget {
  final String phoneNo;
  MyVerify({Key? key, required this.phoneNo}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  String enteredOTP = '';

 // Store entered OTP
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Color(0xFFECFFDC), // Change the background color of the scaffold
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Logo.png',
                width: 170,
                height: 160,
              ),
              SizedBox(height: 25),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "We need to register your phone before getting started!",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (pin) {
                  // Store entered OTP
                  enteredOTP = pin;
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF006400), // Change button color here
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Here, you would typically verify the entered OTP with Firebase Authentication
                    // For demonstration, let's assume the correct OTP is '123456'
                    if (enteredOTP == '123456') {
                      // Correct OTP
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('OTP Verification'),
                          content: Text('OTP is correct!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Navigate to the next screen (e.g., Bottom.dart)
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => Bottom()),
                                // );
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Incorrect OTP
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('OTP Verification'),
                          content: Text('Invalid OTP!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Verify Phone Number",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                      color: Colors.white, // Change text color here
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigate back to the previous screen (e.g., Phone.dart)
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Edit Phone Number ?",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
