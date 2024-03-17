// Importações necessárias
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../styles.dart';
import '../view_models/hero_list_view_model.dart';
import 'widgets/custom_appbar.dart';
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
      appBar: const CustomAppBar(),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DataTable(
                      headingRowHeight: ResponsiveStyles.tableHeaderHeight,
                      columns: [
                        DataColumn(
                          label: Container(
                            width: MediaQuery.of(context).size.width *
                                0.25, // Ajusta este valor según necesites
                            decoration: ResponsiveStyles.tableHeaderDecoration,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text('Personagem',
                                textAlign: TextAlign.left,
                                style: ResponsiveStyles.tableHeaderTextStyle(
                                    context)),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: MediaQuery.of(context).size.width *
                                0.25, // Ajusta este valor según necesites
                            decoration: ResponsiveStyles.tableHeaderDecoration,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10), // Ajuste conforme necessário
                            child: Text('Series',
                                textAlign: TextAlign.left,
                                style: ResponsiveStyles.tableHeaderTextStyle(
                                    context)),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: MediaQuery.of(context).size.width *
                                0.50, // Ajusta este valor según necesites
                            decoration: ResponsiveStyles.tableHeaderDecoration,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10), // Ajuste conforme necessário
                            child: Text('Eventos',
                                textAlign: TextAlign.left,
                                style: ResponsiveStyles.tableHeaderTextStyle(
                                    context)),
                          ),
                        ),
                      ],
                      rows: viewModel.heroes
                          .map<DataRow>((hero) => DataRow(cells: [
                                DataCell(Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(hero.imageUrl),
                                      radius:
                                          ResponsiveStyles.circleAvatarRadius,
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
