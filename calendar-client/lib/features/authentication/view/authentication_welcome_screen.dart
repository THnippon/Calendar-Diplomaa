import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthenticationWelcomeScreen extends StatelessWidget
{
  const AuthenticationWelcomeScreen ({
    super.key,
    required this.onStartPressed,
  });

  final VoidCallback onStartPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF5B3DF5),
                Color(0xFFA61EFF),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                const Icon(
                  Icons.auto_awesome_rounded,
                  size: 56,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Календарь\nСобытий',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(onPressed: onStartPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF5B3DF5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    ),
                    child: const Text('Начать'),
                  ),
                  ),
              ],
            ),
          ),
        ),
      )
    );
  }
}