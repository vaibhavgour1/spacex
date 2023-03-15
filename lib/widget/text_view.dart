import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makeb/utility/color.dart';

/*
for font family
Poppins-Medium = w500;
Poppins-Regular= normal ;
* */


Widget buttonText({
  @required String? data,
  TextAlign textAlign = TextAlign.center,
  double fontSize = 16,
  Color textColor = colorPrimaryFont,
  FontWeight fontWeight = FontWeight.normal,
  int maxLines = 1,
  double rightPadding = 0,
  double leftPadding = 0,
  double topPadding = 0,
  double bottomPadding = 0,
}) {
  return Container(
    padding: EdgeInsets.only(
      right: rightPadding,
      left: leftPadding,
      bottom: bottomPadding,
      top: topPadding,
    ),
    child: Text(data!,
        textScaleFactor: 0.96,
        style: GoogleFonts.openSans(
          fontSize: fontSize,
          color: textColor,
          fontWeight: fontWeight,
        ),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign),
  );
}

Widget titleText({
  @required String? data,
  TextAlign textAlign = TextAlign.start,
  double fontSize = 25,
  Color textColor = colorBlack,
  FontWeight fontWeight = FontWeight.w500,
  int maxLines = 1,
  double rightPadding = 0,
  double leftPadding = 0,
  double topPadding = 0,
  double bottomPadding = 0,
}) {
  return Container(
    padding: EdgeInsets.only(
      right: rightPadding,
      left: leftPadding,
      bottom: bottomPadding,
      top: topPadding,
    ),
    child: Text(data!,
        textScaleFactor: 0.96,
        style:  GoogleFonts.openSans(
          fontSize: fontSize,
          color: textColor,
          fontWeight: fontWeight,
          height: 1.2,
        ),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign),
  );
}

Widget descriptionText({
  @required String? data,
  TextAlign textAlign = TextAlign.start,
  double fontSize = 14,
  Color textColor = colorFontGrey,
  FontWeight fontWeight = FontWeight.normal,
  int maxLines = 1,
  double rightPadding = 0,
  double leftPadding = 0,
  double topPadding = 0,
  double bottomPadding = 0,
}) {
  return Container(
    padding: EdgeInsets.only(
      right: rightPadding,
      left: leftPadding,
      bottom: bottomPadding,
      top: topPadding,
    ),
    child: Text(data!,
        textScaleFactor: 0.96,
        style: GoogleFonts.openSans(
          fontSize: fontSize,
          color: textColor,
          fontWeight: fontWeight,
        ),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign),
  );
}
