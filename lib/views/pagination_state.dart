/// Represents the state of pagination for the hero list.
class PaginationState {
  /// The current page number.
  int currentPage;

  /// The number of items to display per page.
  int itemsPerPage;

  /// The current search query.
  String searchQuery;

  /// The total number of pages available.
  int totalPages;

  /// Constructor to initialize the pagination state.
  PaginationState({
    this.currentPage = 1,
    this.itemsPerPage = 4,
    this.searchQuery = "",
    this.totalPages = 1, // Initialize with a default value
  });

  /// Updates the current page number.
  void updateCurrentPage(int newPage) {
    currentPage = newPage;
  }

  /// Updates the search query.
  void updateSearchQuery(String newQuery) {
    searchQuery = newQuery;
  }

  /// Updates the total number of pages.
  void updateTotalPages(int newTotalPages) {
    totalPages = newTotalPages;
  }
}
