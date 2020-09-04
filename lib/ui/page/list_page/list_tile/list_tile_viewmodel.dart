import 'package:flutter/cupertino.dart';

abstract class ListTileViewModel {
  ListTileViewModel();

  void onFavChanged(bool val);

  ValueNotifier<bool> getIsFavorite();

  dynamic getItem();
}
