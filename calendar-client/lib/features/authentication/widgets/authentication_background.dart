import 'package:flutter/material.dart';

class AuthenticationBackground extends StatelessWidget
{
  const AuthenticationBackground ({
    super.key,
    required this.header,
    required this.body,
  });

  final Widget header;
  final Widget body;




  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final headerHeight = (constraints.maxHeight * 0.38).clamp(240, 340).toDouble();
          final sheetTop = keyboardInset > 0 ? 0.0 : headerHeight - 28;
          return Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                      colors: [
                      Color(0xFF5B3DF5),
                      Color(0xFFA61EFF),
                        ],
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        height: headerHeight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Align(
                          alignment: Alignment.topCenter,
                          child: header,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                left: 0,
                right: 0,
                bottom: 0,
                top: sheetTop,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    )
                  ),
                  child: SafeArea(
                    top: keyboardInset > 0,
                    bottom: false,
                    child: body,
                  ),
                ),
                )
   
        ],
      );
        }
      )

    );
  }
}