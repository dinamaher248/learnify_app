import 'package:flutter/material.dart';

class ConfirmationView extends StatelessWidget {
  const ConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent, //Color(0xffF2F2F2),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          "Attendance Has Been Registered\nSuccessfully.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF5351D2),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
