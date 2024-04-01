abstract class HomeFavouriteState {}

class HomeFavouriteInitialState extends HomeFavouriteState {}

class HomeFavouriteLoadinState extends HomeFavouriteState {}

class HomeFavouriteSuccessState extends HomeFavouriteState {}

class HomeFavouriteErrorState extends HomeFavouriteState {
  String error;
  HomeFavouriteErrorState(this.error);
}
