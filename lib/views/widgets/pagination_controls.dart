import 'package:flutter/material.dart';

import '../pagination_state.dart';

class PaginationControls extends StatelessWidget {
  final PaginationState paginationState;
  final void Function(int) onPageSelect;
  final void Function()? onPrevPage;
  final void Function()? onNextPage;

  const PaginationControls({
    required this.paginationState,
    required this.onPageSelect,
    required this.onPrevPage,
    required this.onNextPage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine visible page range based on screen size
        int maxVisiblePages =
            constraints.maxWidth > 600 ? 7 : 3; // Adjust for mobile
        int startPage = paginationState.currentPage - (maxVisiblePages ~/ 2);
        int endPage = paginationState.currentPage + (maxVisiblePages ~/ 2);

        // Ensure startPage is at least 1
        startPage = startPage < 1 ? 1 : startPage;

        // Adjust endPage if startPage was adjusted
        if (startPage == 1) {
          endPage = startPage + maxVisiblePages - 1;
        }

        // Ensure endPage doesn't exceed totalPages
        endPage = endPage > paginationState.totalPages
            ? paginationState.totalPages
            : endPage;

        return Container(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Previous page arrow
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: paginationState.currentPage > 1
                    ? const Color(0xFFD20A0A)
                    : const Color(0xFFD20A0A).withOpacity(0.35),
                onPressed: paginationState.currentPage > 1 ? onPrevPage : null,
              ),

              // Page indicators
              ...List.generate(endPage - startPage + 1, (index) {
                final pageNumber = startPage + index;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MouseRegion(
                    // Wrap with MouseRegion
                    cursor: SystemMouseCursors.click, // Set cursor to pointer
                    child: GestureDetector(
                      onTap: () => onPageSelect(pageNumber),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            pageNumber == paginationState.currentPage
                                ? const Color(0xFFD42026)
                                : Colors.transparent,
                        child: Text(
                          pageNumber.toString(),
                          style: pageNumber == paginationState.currentPage
                              ? const TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontFamily: 'Roboto-Regular',
                                )
                              : const TextStyle(
                                  color: Color(0xFFD42026),
                                  fontSize: 21,
                                  fontFamily: 'Roboto-Regular',
                                ),
                        ),
                      ),
                    ),
                  ),
                );
              }),

              // Next page arrow
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                color: paginationState.currentPage < paginationState.totalPages
                    ? const Color(0xFFD20A0A)
                    : const Color(0xFFD20A0A).withOpacity(0.35),
                onPressed:
                    paginationState.currentPage < paginationState.totalPages
                        ? onNextPage
                        : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
