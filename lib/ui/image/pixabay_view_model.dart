import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';

import '../../data/model/pixabay_item.dart';

class PixabayViewModel extends ChangeNotifier {
  final _repository =  PixabayRepositoryImpl();

  bool isLoadiing = false;
  List<PixabayItem> _pixabayItem = [];
  List<PixabayItem> get pixabayItem => List.unmodifiable(_pixabayItem);

  Future<void> execute(String query) async {
    isLoadiing = true;
    notifyListeners();

    _pixabayItem = await _repository.getPixabayItems(query);

    isLoadiing = false;
    notifyListeners();
  }

}