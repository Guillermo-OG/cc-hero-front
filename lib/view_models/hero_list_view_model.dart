// Hero list ViewModel
// Importing necessary packages and files
import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../models/hero_model.dart';

/// ViewModel for the list of heroes.
/// Manages business logic and data fetching for the hero list view.
class HeroListViewModel with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<HeroModel> _heroes = [];

  /// Public getter for _heroes list
  List<HeroModel> get heroes => _heroes;

  /// Fetches characters from the Marvel API and updates the _heroes list.
  /// Notifies listeners upon successful data fetch to update the UI accordingly.
  Future<void> fetchHeroes() async {
    try {
      _heroes = await _apiService.fetchCharacters();
      notifyListeners(); // Notifies the UI to refresh with the new data
    } catch (e) {
      // Handle exceptions or errors by logging or displaying messages as necessary
      print("Error fetching characters: $e");
    }
  }

  /// Optional: Implement filtering logic here if needed,
  /// to filter heroes by name or other attributes.
}
