// Hero list view
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/hero_list_view_model.dart';
import '../models/hero_model.dart';

class HeroListView extends StatefulWidget {
  const HeroListView({super.key});

  @override
  State<HeroListView> createState() => _HeroListViewState();
}

class _HeroListViewState extends State<HeroListView> {
  @override
  void initState() {
    super.initState();
    // Assumindo que seu Provider já está acima deste widget na árvore
    final viewModel = Provider.of<HeroListViewModel>(context, listen: false);
    viewModel.fetchHeroes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca Marvel',
            style: TextStyle(
                color: Colors.white, fontSize: 27, fontFamily: 'Roboto-Black')),
        backgroundColor: const Color(0xFFD42026),
      ),
      body: Consumer<HeroListViewModel>(
        builder: (context, viewModel, child) {
          return viewModel.heroes.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: viewModel.heroes.length,
                  itemBuilder: (context, index) {
                    final hero = viewModel.heroes[index];
                    return HeroTile(hero: hero);
                  },
                );
        },
      ),
    );
  }
}

class HeroTile extends StatelessWidget {
  final HeroModel hero;

  const HeroTile({super.key, required this.hero});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(hero.imageUrl, width: 54, height: 54),
      title: Text(hero.name,
          style: const TextStyle(
              color: Color(0xFF4E4E4E),
              fontSize: 21,
              fontFamily: 'Roboto-Regular')),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Séries',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto-Regular')),
          Text(hero.series.join(', '),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto-Regular')),
          const SizedBox(height: 20),
          const Text('Eventos',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto-Regular')),
          Text(hero.events.join(', '),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto-Regular')),
        ],
      ),
    );
  }
}
