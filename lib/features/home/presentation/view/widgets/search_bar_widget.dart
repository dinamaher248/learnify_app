import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(color: Color(0xff6B6868),fontFamily: "Inter",fontWeight: FontWeight.w500,fontSize: 16.sp ),
          prefixIcon: Icon(Icons.search,color: Color(0xff6B6868),),
          filled: true,
          fillColor: Color(0xffC6D1FB),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}