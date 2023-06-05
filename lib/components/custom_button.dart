import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toonify_app/components/loading.dart';
import 'package:toonify_app/components/style_manager.dart';


class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isLoading;
  final Color? backColor;
  final Color? textColor;
  final Color? loadingColor;
  const CustomButton({Key? key, required this.onTap, required this.text, this.isLoading = false, this.backColor, this.textColor, this.loadingColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backColor?? Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r)),
          padding:
          EdgeInsets.symmetric(horizontal: 70.w, vertical: 14.h),
        ),
        onPressed: onTap,
        child: isLoading ? LoadingWidget( color: loadingColor ?? null,)
        :Text(
          text,
          style:
          getMediumStyle(color:textColor?? Colors.white, fontSize: 20.spMax),
        ));
  }
}
