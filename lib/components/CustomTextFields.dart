import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFields extends StatelessWidget {
  CustomTextFields(
      {this.controller,
      this.obscure,
      this.height,
      this.validator,
      this.hintText,
      this.label,
      this.onchanged,
      this.prefixIcon,
      this.onsaved,
      this.onpressedLeading,
      this.onTap,
      this.leadinIcon,
      this.borderradius,
      this.hintColor,
      this.fillColor,
      this.autoFocus,
      this.focusNode,
      this.readOnly});
  var height;
  var fillColor;
  var hintText;
  var hintColor;
  var label;
  var borderradius;
  var onchanged;
  var onsaved;
  var controller;
  var prefixIcon;
  var leadinIcon;
  var onpressedLeading;
  var validator;
  var obscure;
  var focusNode;
  var autoFocus;
  var readOnly;
  var onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: SizedBox(
        height: 55.h,
        child: TextFormField(
          obscureText: obscure ?? false,
          validator: validator ??
              (String? value) {
                if (value!.isEmpty) {
                  return "Please fill out this feild";
                }
                return null;
              },
          cursorColor: Colors.blueAccent,
          style: GoogleFonts.poppins(
            color: Colors.black,
          ),
          // cursorWidth: 20,
          decoration: InputDecoration(
              prefixIcon: prefixIcon ?? prefixIcon,
              suffixIcon: leadinIcon ?? leadinIcon,
              contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0.w),
              hintText: hintText ?? hintText,
              hintStyle: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color:Colors.black45,
              )),
          // hintStyle:  GoogleFonts.poppins()
          focusNode: focusNode,
          autofocus: autoFocus ?? true,
          onChanged: onchanged ?? onchanged,
          onSaved: onsaved ?? onsaved,
          controller: controller ?? controller,
          readOnly: readOnly ?? false,
          onTap: onTap,
        ),
      ),
    );
  }
}
