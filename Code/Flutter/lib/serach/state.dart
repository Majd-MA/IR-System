abstract class SearchState {}

final class SearchInitial extends SearchState {}

class SelectDataBase extends SearchState {
  final String selectedDataBase;

  SelectDataBase(this.selectedDataBase);
}

class PostAntiqueLoadingState extends SearchState {}

class PostAntiqueSuccessState extends SearchState {}

class PostAntiqueErrorState extends SearchState {}