part of 'home_bloc.dart';

@immutable
class HomeState {
  final List<Program>? popularPrograms;
  final List<Program>? currentPrograms;
  final int? favoritesLength;

  final bool loadingPopular;
  final bool loadingCurrent;
  final bool loadingFavorites;

  final String? errorPopular;
  final String? errorCurrent;
  final String? errorFavorites;

  final int currentProgramsPage;

  const HomeState({
    this.popularPrograms,
    this.currentPrograms,
    this.favoritesLength,
    this.loadingPopular = false,
    this.loadingCurrent = false,
    this.loadingFavorites = false,
    this.errorPopular,
    this.errorCurrent,
    this.errorFavorites,
    this.currentProgramsPage = 0,
  });

  HomeState copyWith({
    List<Program>? popularPrograms,
    List<Program>? currentPrograms,
    int? favoritesLength,
    bool? loadingPopular,
    bool? loadingCurrent,
    bool? loadingFavorites,
    String? errorPopular,
    String? errorCurrent,
    String? errorFavorites,
    int? currentProgramsPage,
  }) {
    return HomeState(
      popularPrograms: popularPrograms ?? this.popularPrograms,
      currentPrograms: currentPrograms ?? this.currentPrograms,
      favoritesLength: favoritesLength ?? this.favoritesLength,
      loadingPopular: loadingPopular ?? this.loadingPopular,
      loadingCurrent: loadingCurrent ?? this.loadingCurrent,
      loadingFavorites: loadingFavorites ?? this.loadingFavorites,
      errorPopular: errorPopular,
      errorCurrent: errorCurrent,
      errorFavorites: errorFavorites,
      currentProgramsPage: currentProgramsPage ?? this.currentProgramsPage,
    );
  }
}

