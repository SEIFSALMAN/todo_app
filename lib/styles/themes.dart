import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData darkTheme = ThemeData(
    // useMaterial3: false,
    brightness: Brightness.dark,
    cardColor: Colors.grey[900], // CardToDoWidget
    scaffoldBackgroundColor: Colors.black,
    dialogBackgroundColor: Colors.grey.shade900,

    appBarTheme: const AppBarTheme(
        shadowColor: Colors.white,
        titleSpacing: 20.0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light
        ),
        backgroundColor: Colors.black,
        elevation: 5,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        )
    ),

    textTheme: TextTheme(

        //Logo Text
         displayLarge: TextStyle(
             fontSize: 20.0,
             fontWeight: FontWeight.bold,
             color: Colors.white,
         ),

        // Main Text
        bodyLarge: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
        ),

        //Description inside box
        bodyMedium: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w300,
            color: Colors.grey,
        ),

        // Text with grey Color
        bodySmall: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
        ),

        // Text inside Card
        titleLarge: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
        ),

        //Date inside Card
        titleMedium: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
        ),

        // Time inside Card
        titleSmall: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
            color: Colors.grey,
        )

    ),
);

ThemeData lightTheme = ThemeData(
    // useMaterial3: false,
    brightness: Brightness.light,

    cardColor: Colors.grey[100],
    scaffoldBackgroundColor: Colors.white,
    dialogBackgroundColor: Colors.grey.shade300,
    hintColor: Colors.black,
    appBarTheme: const AppBarTheme(
        titleSpacing: 20.0,
        color: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        ),
        elevation:5,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
           // fontWeight: FontWeight.bold
        )
    ),

    textTheme: TextTheme(

        //Logo Text
        displayLarge: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
        ),

        // Main Text
        bodyLarge: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
        ),

        //Description inside box
        bodyMedium: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w300,
            color: Colors.grey,
        ),

        // Text with grey Color
        bodySmall: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
        ),

        // Text inside Card
        titleLarge: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
        ),

        //Date inside Card
        titleMedium: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
        ),

        // Time inside Card
        titleSmall: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
            color: Colors.grey,
        )

    )
);