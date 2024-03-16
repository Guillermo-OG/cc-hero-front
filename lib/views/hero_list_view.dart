// Importações necessárias
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../styles.dart';
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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment
                        .middle, // Ajusta o alinhamento vertical
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFD42026),
                            width: 4,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'BUS',
                          style: ResponsiveStyles.titleTextStyle(context),
                        ),
                      ), // Reduz o espaçamento do sublinhado
                    ),
                  ),
                  TextSpan(
                      text: 'CA MARVEL ',
                      style: ResponsiveStyles.titleTextStyle(context)),
                  TextSpan(
                      text: 'TESTE FRONT-END',
                      style: ResponsiveStyles.subtitleTextStyle(context)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Visibility(
            visible: MediaQuery.of(context).size.width >
                600, // Esconde o texto em dispositivos móveis
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
                      columns: [
                        DataColumn(
                            label: Text('Personagem',
                                style:
                                    ResponsiveStyles.tableTextStyle(context))),
                        DataColumn(
                            label: Text('Séries',
                                style:
                                    ResponsiveStyles.tableTextStyle(context))),
                        DataColumn(
                            label: Text('Eventos',
                                style:
                                    ResponsiveStyles.tableTextStyle(context))),
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
                                            style:
                                                ResponsiveStyles.tableTextStyle(
                                                    context))),
                                  ],
                                )),
                                DataCell(Text(hero.series.join(', '),
                                    style: ResponsiveStyles.tableTextStyle(
                                        context))),
                                DataCell(Text(hero.events.join(', '),
                                    style: ResponsiveStyles.tableTextStyle(
                                        context))),
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
