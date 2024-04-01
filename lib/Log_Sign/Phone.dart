import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'verify.dart'; // Import the Verify.dart file here

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECFFDC), // Set the background color here
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Logo.png',
                width: 160,
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
              TextField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Enter Phone Number",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF006400),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () async {
                    String phoneNumber = phoneNumberController.text.trim();
                    if (phoneNumber.isNotEmpty) {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: phoneNumber,
                        verificationCompleted: (PhoneAuthCredential credential) {
                          // Auto-retrieval of verification code completed.
                          // You can use this callback to automatically sign-in the user if the verification code is detected automatically.
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          // Handle verification failure
                          print('Verification failed: ${e.message}');
                          // Show error message to the user
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Verification failed: ${e.message}'),
                            ),
                          );
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          // Navigate to the OTP screen with the verification ID
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyVerify(phoneNo: verificationId)
                            ),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          // Called when the automatic code retrieval times out.
                          // You can handle it accordingly if needed.
                        },
                      );
                    } else {
                      // Show an error message if the phone number is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter a valid phone number.'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Send OTP",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
