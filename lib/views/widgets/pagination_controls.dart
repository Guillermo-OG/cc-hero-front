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
    return Container(
      padding: const EdgeInsets.only(bottom: 16), // Minimum space from footer
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center controls
        children: [
          // Previous page arrow
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: paginationState.currentPage > 1
                ? const Color(0xFFD20A0A) // EnabledArrowStyle
                : const Color(0xFFD20A0A)
                    .withOpacity(0.35), // DisabledArrowStyle
            onPressed: paginationState.currentPage > 1 ? onPrevPage : null,
          ),

          // Page indicators
          ...List.generate(paginationState.totalPages, (index) {
            final pageNumber = index + 1;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () => onPageSelect(pageNumber),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: pageNumber == paginationState.currentPage
                      ? const Color(0xFFD42026) // CircleIndicatorStyle
                      : Colors.transparent,
                  child: Text(
                    pageNumber.toString(),
                    style: pageNumber == paginationState.currentPage
                        ? const TextStyle(
                            color: Colors.white, // SelectedPageTextStyle
                            fontSize: 21,
                            fontFamily: 'Roboto-Regular',
                          )
                        : const TextStyle(
                            color: Color(0xFFD42026), // UnselectedPageTextStyle
                            fontSize: 21,
                            fontFamily: 'Roboto-Regular',
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
                ? const Color(0xFFD20A0A) // EnabledArrowStyle
                : const Color(0xFFD20A0A)
                    .withOpacity(0.35), // DisabledArrowStyle
            onPressed: paginationState.currentPage < paginationState.totalPages
                ? onNextPage
                : null,
          ),
        ],
      ),
    );
  }
}
