class NavigationStates {
  int currentIndex;
  NavigationStates({required this.currentIndex});
  NavigationStates copyWith({int? currentIndex}) {
    return NavigationStates(currentIndex: currentIndex ?? this.currentIndex);
  }

  List<Object?> get props => [currentIndex];
}
