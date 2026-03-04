
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF6F7FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6F7FF),
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),

        

        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      );
      