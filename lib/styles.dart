import 'package:flutter/material.dart';

class ResponsiveStyles {
  static TextStyle titleTextStyle(BuildContext context) {
    return TextStyle(
      color: const Color(0xFFD42026),
      fontSize: MediaQuery.of(context).size.width > 600 ? 27 : 16,
      fontFamily: 'Roboto-Black', //
      fontWeight: FontWeight.bold,
      height: 1.2,
    );
  }

  static TextStyle subtitleTextStyle(BuildContext context) {
    return TextStyle(
      color: const Color(0xFFD42026),
      fontSize: MediaQuery.of(context).size.width > 600 ? 27 : 16,
      fontFamily: 'Roboto-Regular', //
      height: 1.2,
    );
  }

  static TextStyle labelTextStyle(BuildContext context) {
    return TextStyle(
      color: const Color(0xFFD42026),
      fontSize: MediaQuery.of(context).size.width > 600
          ? 16
          : 14, // Ajuste mantido conforme sua última versão
      fontFamily: 'Roboto-Regular',
      height: 1.2, // Mantido conforme sua última versão
    );
  }

  static TextStyle tableTextStyle(BuildContext context) {
    return TextStyle(
      color: const Color(0xFF4E4E4E),
      fontSize: MediaQuery.of(context).size.width > 600
          ? 21
          : 16, // Ajuste mantido conforme sua última versão
      fontFamily: 'Roboto-Regular',
    );
  }

  static EdgeInsets pagePadding(BuildContext context) {
    return MediaQuery.of(context).size.width > 600
        ? const EdgeInsets.only(top: 20, right: 42, left: 42)
        : const EdgeInsets.symmetric(
            horizontal: 30); // Conforme as especificações e seus ajustes
  }

  static EdgeInsets searchBarMargin(BuildContext context) {
    return MediaQuery.of(context).size.width > 600
        ? const EdgeInsets.only(bottom: 34)
        : const EdgeInsets.only(
            bottom: 34,
            left: 30,
            right: 30); // Ajuste conforme as especificações
  }

  static EdgeInsets paginationControlsMargin(BuildContext context) {
    return MediaQuery.of(context).size.width > 600
        ? const EdgeInsets.only(bottom: 16)
        : const EdgeInsets.only(
            bottom: 16,
            left: 30,
            right: 30); // Ajuste conforme as especificações
  }

  static EdgeInsets tableRowPadding(BuildContext context) {
    return MediaQuery.of(context).size.width > 600
        ? const EdgeInsets.all(0) // Sem margem para a versão web
        : const EdgeInsets.only(
            top: 18, bottom: 18); // Ajuste conforme as especificações
  }
}
