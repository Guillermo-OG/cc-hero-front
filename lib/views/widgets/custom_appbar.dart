import 'package:flutter/material.dart';
import '../../styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
          padding: const EdgeInsets.all(27.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start, // Alinha os filhos à esquerda
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'BUSCA MARVEL ',
                        style: ResponsiveStyles.titleTextStyle(context)),
                    TextSpan(
                        text: 'TESTE FRONT-END',
                        style: ResponsiveStyles.subtitleTextStyle(context)),
                  ],
                ),
              ),
              const SizedBox(height: 8), // Espaço entre o texto e a linha
              Container(
                width: 54, // Largura da linha
                height: 4, // Altura da linha
                color: const Color(0xFFD42026), // Cor da linha
              ),
            ],
          )),

      actions: [
        Visibility(
          visible: MediaQuery.of(context).size.width > 600,
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "GUILLERMO OPORTO GUMUCIO",
                style: ResponsiveStyles.subtitleTextStyle(context),
              ),
            ),
          ),
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0, // Remove a sombra abaixo do AppBar, se desejado
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight + 12); // Ajuste a altura conforme necessário
}
