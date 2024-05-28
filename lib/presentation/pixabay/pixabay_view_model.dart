import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';

import '../../data/model/pixabay_item.dart';

class PixabayViewModel extends ChangeNotifier {
  final _repsoitory = PixabayRepositoryImpl();

  bool isLoading = false;
  List<PixabayItem> _pixabayItem = [];
  List<PixabayItem> get pixabayItem => List.unmodifiable(_pixabayItem);

  Future<void> fetchImaage(String query) async{
    isLoading = true;
    notifyListeners();

    _pixabayItem = await _repsoitory.getPixabayItem(query);
    isLoading = false;
    notifyListeners();
  }
}