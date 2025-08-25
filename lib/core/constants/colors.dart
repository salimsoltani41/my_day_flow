import 'package:flutter/material.dart';

class AppColors {
  static const black = Colors.black;
  static const white = Colors.white;
  static const grey = Colors.grey;
  static const transparent = Colors.transparent;
  static const lightGrey = Color.fromARGB(255, 156, 156, 156);
  static const darkGrey = Color.fromARGB(255, 96, 96, 96);
  static const blue = Color.fromARGB(255, 13, 153, 255);
  static const turqoise = Color.fromARGB(255, 13, 239, 255);
  static const blueDeep = const Color.fromARGB(255, 0, 47, 88);

  static const red = Color.fromARGB(255, 251, 54, 40);
  static const green = Color.fromARGB(255, 24, 250, 32);
  static const greenTransparent = Color.fromARGB(255, 197, 255, 199);
  static const darkGreen = Color.fromARGB(255, 3, 73, 5);

  static const orange = Color.fromARGB(255, 255, 157, 0);
  static const amber = Color.fromARGB(255, 255, 225, 0);

  // static const primaryColor = Color(0xFFC62828);
  static const primaryColor = Color.fromARGB(255, 155, 18, 18);
  static const pink = Color.fromARGB(255, 250, 21, 90);

  static const primaryColorTransparent = Color.fromARGB(255, 248, 175, 175);

  static const purple = Color.fromARGB(255, 255, 43, 241);
  static const teal = Color.fromARGB(255, 0, 204, 231);

  // static const background = Color.fromARGB(255, 250, 242, 241);
  static const background = Color.fromARGB(255, 255, 236, 235);

  static const darkbackground = Color.fromARGB(255, 30, 30, 30);
  static const darkBlue = Color.fromARGB(255, 1, 44, 79);
}

// THIS CLASS FOR GRADIENT COLORS THAT WE WILL USE FOR OUR APP ===============================================

class AppGradient {
  // Background for Auth Screens =======================================================
  static const primaryGradient = LinearGradient(
    colors: [Color.fromARGB(255, 0, 45, 79), Color.fromARGB(255, 0, 183, 255)],
    begin: Alignment.center,
    end: Alignment.bottomCenter,
  );

  // Background for Auth Screens =======================================================
  static const backgroundGradient = LinearGradient(
    colors: [Color.fromARGB(255, 0, 30, 52), Color.fromARGB(255, 0, 91, 161)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  // blue gradient =======================================================
  static const blueGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 0, 131, 182),
      Color.fromARGB(255, 0, 174, 255),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // blue gradient =======================================================
  static const lightBackGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 153, 208, 253),
      Color.fromARGB(255, 211, 251, 255),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  // whie grasdient =======================================================
  static const whiteGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 255, 255, 255),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const redGradient = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [Color.fromARGB(255, 250, 91, 91), Color.fromARGB(255, 255, 0, 0)],
  );
  static const greensGradient = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Color.fromARGB(255, 139, 255, 105),
      Color.fromARGB(255, 0, 254, 127),
    ],
  );

  static const amberGradient = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Color.fromARGB(255, 255, 225, 105),
      Color.fromARGB(255, 254, 212, 0),
    ],
  );

  static const orangeGradient = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Color.fromARGB(255, 255, 105, 42),
      Color.fromARGB(255, 254, 63, 0),
    ],
  );

  static const pinkyGradient = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Color.fromARGB(255, 255, 105, 158),
      Color.fromARGB(255, 254, 0, 97),
    ],
  );

  static const purpleGradient = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Color.fromARGB(255, 255, 105, 230),
      Color.fromARGB(255, 254, 0, 212),
    ],
  );

  static const transparentGradient = LinearGradient(
    colors: [AppColors.transparent, AppColors.transparent],
  );

  static const greyGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 123, 125, 123),
      Color.fromARGB(255, 234, 234, 234),
    ],
  );

  static const blackGradient = LinearGradient(
    colors: [Color.fromARGB(255, 27, 27, 27), Color.fromARGB(255, 0, 0, 0)],
  );

  // Radial Gradient =====================
  static const blueRadialGradient = RadialGradient(
    radius: 3,
    colors: [
      Color.fromARGB(255, 183, 231, 253),
      Color.fromARGB(255, 0, 131, 182),
    ],
  );

  static const redRadialGradient = RadialGradient(
    radius: 4,

    colors: [
      Color.fromARGB(255, 255, 169, 169),
      Color.fromARGB(255, 255, 0, 0),
    ],
  );

  static const amberRadialGradient = RadialGradient(
    radius: 3,
    colors: [
      Color.fromARGB(255, 255, 239, 173),
      Color.fromARGB(255, 254, 212, 0),
    ],
  );

  static const orangeRadialGradient = RadialGradient(
    radius: 3,
    colors: [
      Color.fromARGB(255, 255, 191, 164),
      Color.fromARGB(255, 254, 63, 0),
    ],
  );

  static const pinkyRadialGradient = RadialGradient(
    radius: 3,
    colors: [
      Color.fromARGB(255, 253, 210, 223),
      Color.fromARGB(255, 254, 0, 97),
    ],
  );

  static const greyRadialGradient = RadialGradient(
    radius: 3,
    colors: [
      Color.fromARGB(255, 234, 234, 234),
      Color.fromARGB(255, 123, 125, 123),
    ],
  );
}
