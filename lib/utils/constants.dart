import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

class Constants {
  static const String appName = "Bloggy";

  static const Color primaryColor = Color(0xFF141312);
  static const Color secondaryColor = Color.fromARGB(255, 115, 89, 231);
  static const Color lightSecondaryColor = Color.fromARGB(255, 148, 128, 238);
  static const Color scaffoldBgColor = Color.fromARGB(255, 224, 219, 219);
  static const Color backgroundColor = Color.fromARGB(255, 209, 204, 204);
  static const Color whiteColor = Color(0xFFfefeff);
  static const Color redColor = Color.fromARGB(255, 223, 61, 61);

  static const double paddingXS = 8.0;
  static const double paddingS = 12.0;
  static const double paddingM = 14.0;
  static const double paddingSemiM = 16.0;
  static const double paddingL = 18.0;
  static const double paddingXL = 20.0;

  static const double marginXS = 8.0;
  static const double marginS = 12.0;
  static const double marginM = 14.0;
  static const double marginSemiM = 16.0;
  static const double marginL = 18.0;
  static const double marginXL = 20.0;

  static const double buttonRadius = 8.0;
  static const double fieldRadius = 8.0;

  static const FontWeight light = FontWeight.w100;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  static const double subTitleFontSize = 14.0;
  static const double textFontSize = 18.0;
  static const double titleFontSize = 24.0;
  static const double headerFontSize = 32.0;

  static const double sizeXS = 5.0;
  static const double sizeS = 8.0;
  static const double sizeM = 12.0;
  static const double sizeSemiM = 14.0;
  static const double sizeL = 18.0;
  static const double sizeXL = 20.0;
  static const double sizeXXL = 100.0;
  static const double sizeXXXL = 240.0;

  static const double splashIconSize = 150.0;
  static const double svgImageSize = 230.0;
  static const double svgImageSizeMed = 200.0;
}
