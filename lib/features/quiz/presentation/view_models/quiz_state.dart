class QuizState {
  final int currentIndex;
  final int selectedIndex;

  QuizState({
    required this.currentIndex,
    required this.selectedIndex,
  });

  QuizState copyWith({
    int? currentIndex,
    int? selectedIndex,
  }) {
    return QuizState(
      currentIndex: currentIndex ?? this.currentIndex,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}