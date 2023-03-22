import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget txFormField(TextEditingController controller, String alert,
    IconData icon, String label) {
  return TextFormField(
    controller: controller,
    validator: (value) => value!.isEmpty ? alert : null,
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.black,
      ),
      label: Text(
        label,
        style: TextStyle(color: Colors.black),
      ),
      filled: true,
      fillColor: Color.fromARGB(255, 240, 240, 240),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(63.r)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(63.r)),
      contentPadding: EdgeInsets.only(left: 40.w),
      constraints: BoxConstraints(),
    ),
  );
}

Widget txFieldDetails(
    TextEditingController controller, String label, IconData? icon) {
  return TextFormField(
    validator: (value) => value!.isEmpty ? '$label can not be empty.' : null,
    keyboardType: label == 'Date of Birth' ? TextInputType.datetime : null,
    controller: controller,
    decoration: icon != null
        ? InputDecoration(
            filled: true,
            fillColor: Colors.grey[300],
            prefixIcon: Icon(icon),
            hintText: label,
            contentPadding: EdgeInsets.only(left: 60.w),
            constraints: BoxConstraints(),
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(63.r),
            ),
          )
        : InputDecoration(
            filled: true,
            fillColor: Colors.grey[300],
            hintText: label,
            contentPadding: EdgeInsets.only(left: 60.w),
            constraints: BoxConstraints(),
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(63.r),
            ),
          ),
  );
}
