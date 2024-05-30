import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';

import '../../data/model/pixabay_item.dart';

class PixabayViewModel extends ChangeNotifier {
  final _reposiotry = PixabayRepositoryImpl();

  List<PixabayItem> _pixabayItem = [];
  List<PixabayItem> get pixabayItem => List.unmodifiable(_pixabayItem);

  bool isLoading = false;

  Future<void> searchImage(String query) async{
    isLoading = true;
    notifyListeners();

    _pixabayItem = await _reposiotry.getPixabayItem(query);
    isLoading = false;
    notifyListeners();
  }

}