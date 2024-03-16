// Hero list ViewModel
// Importing necessary packages and files
import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/hero_model.dart';
import '../views/pagination_state.dart';

/// ViewModel for the list of heroes.
/// Manages business logic and data fetching for the hero list view.
class HeroListViewModel with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final List<HeroModel> _heroes = [];
  final PaginationState _paginationState = PaginationState();

  /// Public getter for _heroes list
  List<HeroModel> get heroes => _heroes;

  /// Fetches characters from the Marvel API and updates the _heroes list.
  /// Notifies listeners upon successful data fetch to update the UI accordingly.
  ///
  // final int _currentPage = 0;
  bool _isFetching = false;

  PaginationState get paginationState => _paginationState;

  Future<void> fetchHeroes({bool nextPage = false}) async {
    if (_isFetching) return;

    _isFetching = true;
    try {
      final data = await _apiService.fetchCharacters(
        limit: _paginationState.itemsPerPage,
        offset:
            (_paginationState.currentPage - 1) * _paginationState.itemsPerPage,
        query: _paginationState.searchQuery,
      );
      final heroes = data['heroes'];
      final result = data['result'];

      if (!nextPage) {
        _heroes.clear(); // Limpa a lista se não for paginação
      }

      if (heroes.isNotEmpty) {
        _heroes.addAll(heroes);
        // Atualiza o estado da paginação
        _paginationState.totalPages = calculateTotalPages(result);
      } else if (!nextPage) {
        // Tratamento específico para quando a busca não retorna resultados
        // e não estamos tentando buscar a próxima página.
        _paginationState.totalPages = 0;
      }

      notifyListeners();
    } catch (e) {
      print("Error fetching characters: $e");
    } finally {
      _isFetching = false;
    }
  }

  void onPrevPage() {
    if (_paginationState.currentPage > 1) {
      _paginationState.currentPage--;
      fetchHeroes();
    }
  }

  void onNextPage() {
    if (_paginationState.currentPage < _paginationState.totalPages) {
      _paginationState.currentPage++;
      fetchHeroes();
    }
  }

  void onPageSelect(int pageNumber) {
    _paginationState.currentPage = pageNumber;
    fetchHeroes();
  }

  void onSearch(String input) {
    if (input.isEmpty) {
      // Opcional: Decide si quieres restablecer la vista cuando no hay búsqueda.
      return;
    }
    _paginationState.searchQuery = input;
    _paginationState.currentPage = 1;
    _heroes
        .clear(); // Asegúrate de limpiar la lista actual antes de cargar nuevos resultados.
    fetchHeroes();
  }

  int calculateTotalPages(Map<String, dynamic> result) {
    final totalResults = result['data']['total'];
    final itemsPerPage = _paginationState.itemsPerPage;
    return (totalResults / itemsPerPage).ceil();
  }

  /// Optional: Implement filtering logic here if needed,
  /// to filter heroes by name or other attributes.
}
