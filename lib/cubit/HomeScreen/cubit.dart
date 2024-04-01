import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_namaa/cubit/HomeScreen/state.dart';

class HomeFavouriteCubit extends Cubit<HomeFavouriteState> {
  HomeFavouriteCubit() : super(HomeFavouriteInitialState());
  static HomeFavouriteCubit get(context) => BlocProvider.of(context);

  Future<void> updateFavoriteStatus(
      int index, String idProducts, bool Favourites) async {
    try {
      emit(HomeFavouriteLoadinState());
      bool isCurrentlyFavorite = Favourites;
      await FirebaseFirestore.instance
          .collection('products')
          .doc(idProducts)
          .update({
        'isFavourite': !isCurrentlyFavorite,
      });

      if (isCurrentlyFavorite) {
        print('تمت إزالة المنتج من قائمة المفضلة بنجاح');
        print(idProducts);
        emit(HomeFavouriteSuccessState());
      } else {
        print('تمت إضافة المنتج إلى قائمة المفضلة بنجاح');
        print(idProducts);
      }
    } catch (error) {
      print('فشل تحديث حالة المفضلة للمنتج: $error');
      print(idProducts);
      emit(HomeFavouriteErrorState(error.toString()));
    }
    print(idProducts);
  }
}
