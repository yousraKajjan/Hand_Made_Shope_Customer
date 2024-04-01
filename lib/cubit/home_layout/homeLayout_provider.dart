import 'package:flutter/cupertino.dart';
import 'package:project_namaa/screens/HomeScreen.dart';
import 'package:project_namaa/screens/ProfileScreen.dart';
import 'package:project_namaa/screens/providerCard/CardScreen.dart';
import 'package:project_namaa/screens/providerFav/Favourite_Screen.dart';

class HomeLayoutProvider extends ChangeNotifier {
  int index = 0;

  List<Widget> screen = [
    const HomeScreen(),
    const FavouriteScreen(),
    const CardScreen(),
    const ProfileScreen()
  ];
  void changeBottomNav(int currentIndex) {
    index = currentIndex;
    notifyListeners();
  }
}
