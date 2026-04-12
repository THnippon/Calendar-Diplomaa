import 'package:flutter/material.dart';

class AppButtonDecorations {
  const AppButtonDecorations._();

  static Widget gradientButton({
    required String text,
    required VoidCallback onTap,
    verticalPadding = 19.0,
    List<Color> colors = const [
      Color(0xFF5B3DF5),
      Color(0xFFA61EFF),
    ],
  })
  {
    return Material(  
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: colors,
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: onTap,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: verticalPadding),
                        child: Center(
                          child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                  ),
                  ),
                        ),
                        ),
                    ),
                  ),
                );
  }
}