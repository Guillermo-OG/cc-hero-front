import 'package:flutter/material.dart';

class ResponsiveStyles {
  static TextStyle titleTextStyle(BuildContext context) {
    return TextStyle(
      color: const Color(0xFFD42026),
      fontSize: MediaQuery.of(context).size.width > 600 ? 27 : 16,
      fontFamily: 'Roboto-Black',
      fontWeight: FontWeight.bold,
      height: 1.2,
    );
  }

  static TextStyle subtitleTextStyle(BuildContext context) {
    return TextStyle(
      color: const Color(0xFFD42026),
      fontSize: MediaQuery.of(context).size.width > 600 ? 27 : 16,
      fontFamily: 'Roboto-Regular',
      height: 1.2,
    );
  }

  static TextStyle labelTextStyle(BuildContext context) {
    return TextStyle(
      color: const Color(0xFFD42026),
      fontSize: MediaQuery.of(context).size.width > 600 ? 16 : 14,
      fontFamily: 'Roboto-Regular',
      height: 1.2,
    );
  }

  static TextStyle tableHeaderTextStyle(BuildContext context) {
    return const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontFamily: 'Roboto-Regular',
      height: 1.2,
    );
  }

  static const double tableHeaderHeight = 37.0;

  static BoxDecoration tableHeaderDecoration = const BoxDecoration(
    color: Color(0xFFD42026),
  );

  static const Color rowHoverBackgroundColor = Color.fromRGBO(212, 32, 38, 0.1);
  static const double circleAvatarRadius = 29;

  static EdgeInsets tableRowPadding(BuildContext context) {
    return const EdgeInsets.symmetric(
        vertical: 18); // 18px arriba y abajo, más la altura del círculo
  }

  static TextStyle tableTextStyle(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF4E4E4E),
      fontSize: MediaQuery.of(context).size.width > 600 ? 21 : 16,
      fontFamily: 'Roboto-Regular',
    );
  }

  static EdgeInsets pagePadding(BuildContext context) {
    return MediaQuery.of(context).size.width > 600
        ? const EdgeInsets.only(top: 20, right: 42, left: 42)
        : const EdgeInsets.symmetric(horizontal: 30);
  }

  static EdgeInsets searchBarMargin(BuildContext context) {
    return MediaQuery.of(context).size.width > 600
        ? const EdgeInsets.only(bottom: 34)
        : const EdgeInsets.only(bottom: 34, left: 30, right: 30);
  }

  static EdgeInsets paginationControlsMargin(BuildContext context) {
    return MediaQuery.of(context).size.width > 600
        ? const EdgeInsets.only(bottom: 16)
        : const EdgeInsets.only(bottom: 16, left: 30, right: 30);
  }
}
