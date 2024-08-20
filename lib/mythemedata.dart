import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/appColors.dart';

class Mythemedata {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: Appcolors.primaryColor,
      scaffoldBackgroundColor: Appcolors.backgrountLightColor,
      appBarTheme: AppBarTheme(
        backgroundColor: Appcolors.primaryColor,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Appcolors.primaryColor,
          unselectedItemColor: Appcolors.greyColor,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0),
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          side: BorderSide(color: Appcolors.blackColor, width: 4),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
            side: BorderSide(color: Appcolors.whiteColor, width: 5),
          ),
          backgroundColor: Appcolors.primaryColor,
          foregroundColor: Appcolors.whiteColor),
      textTheme: TextTheme(
          titleLarge: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Appcolors.whiteColor),
          titleMedium: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Appcolors.blackColor),
          bodyMedium: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Appcolors.blackColor,
          ),
          bodySmall: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Appcolors.blackColor)));
}
