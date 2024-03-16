// Importações necessárias
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/hero_list_view_model.dart';
import 'widgets/pagination_controls.dart';
import 'widgets/searchBar_controls.dart';

class HeroListView extends StatefulWidget {
  const HeroListView({super.key});

  @override
  State<HeroListView> createState() => _HeroListViewState();
}

class _HeroListViewState extends State<HeroListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<HeroListViewModel>(context, listen: false);
    viewModel.fetchHeroes();

    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     viewModel.fetchHeroes(nextPage: true);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BUSCA MARVEL TESTE FRONT-END',
            style: TextStyle(
                color: Colors.white, fontSize: 27, fontFamily: 'Roboto-Black')),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Align(
              alignment: Alignment.center,
              child: Text("NOME DO CANDIDATO",
                  style: TextStyle(
                      fontSize: 21,
                      fontFamily: 'Roboto-Regular',
                      color: Color(0xFF4E4E4E))),
            ),
          ),
        ],
        backgroundColor: const Color(0xFFD42026),
      ),
      body: Consumer<HeroListViewModel>(
        builder: (context, viewModel, child) {
          bool hasResults = viewModel.heroes.isNotEmpty;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: BarraSearch(onSearch: viewModel.onSearch),
              ),
              if (hasResults) ...[
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Personagem')),
                        DataColumn(label: Text('Séries')),
                        DataColumn(label: Text('Eventos')),
                      ],
                      rows: viewModel.heroes
                          .map<DataRow>((hero) => DataRow(cells: [
                                DataCell(Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(hero.imageUrl),
                                      radius: 25,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                        child: Text(hero.name,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Roboto-Regular',
                                                color: Color(0xFF4E4E4E)))),
                                  ],
                                )),
                                DataCell(Text(hero.series.join(', '))),
                                DataCell(Text(hero.events.join(', '))),
                              ]))
                          .toList(),
                    ),
                  ),
                ),
                PaginationControls(
                  paginationState: viewModel.paginationState,
                  onPageSelect: viewModel.onPageSelect,
                  onPrevPage: viewModel.onPrevPage,
                  onNextPage: viewModel.onNextPage,
                ),
              ] else ...[
                const Expanded(
                  child: Center(
                    child: Text('Nenhum resultado encontrado.',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto-Regular',
                            color: Color(0xFF4E4E4E))),
                  ),
                ),
              ]
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
