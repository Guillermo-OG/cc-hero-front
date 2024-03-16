import 'dart:async';
import 'package:flutter/material.dart';

class BarraSearch extends StatefulWidget {
  final Function(String) onSearch;

  const BarraSearch({required this.onSearch, super.key});

  @override
  State<BarraSearch> createState() => _BarraSearchState();
}

class _BarraSearchState extends State<BarraSearch> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Update the state immediately to reflect the user's input in the UI
    setState(() {});

    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        // Trigger default search when query is empty
        widget.onSearch(
            ""); // Pass an empty query or use a specific default query
      } else {
        widget.onSearch(query); // Perform search with the entered query
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 34), // Ajuste o espaçamento conforme necessário
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alinha o label à esquerda
        children: [
          const Text(
            "Nome do personagem",
            style: TextStyle(
              color: Color(0xFFD42026),
              fontSize: 16,
              fontFamily: 'Roboto-Regular',
              height: 1.2, // Linha (1.2) para corresponder ao design
            ),
          ),
          const SizedBox(
              height: 4), // Reduz o espaço entre o label e o TextField
          SizedBox(
            width: 400,
            height: 31,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: 8,
                    bottom: 8,
                    top:
                        8), // Aumenta o padding interno à esquerda e centraliza verticalmente
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFA5A5A5),
                  ),
                  borderRadius:
                      BorderRadius.circular(4), // Bordas levemente arredondadas
                ),
              ),
              style: const TextStyle(
                  fontSize:
                      16), // Ajusta o tamanho do texto dentro do TextField
              onChanged:
                  _onSearchChanged, // Dispara a busca na mudança de texto
            ),
          ),
        ],
      ),
    );
  }
}
