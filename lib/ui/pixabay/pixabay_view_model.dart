import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';

import '../../data/repository/pixabay_repository.dart';

class PixabayViewModel with ChangeNotifier {
  final   PixabayRepository _repository;

   PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

  List<PixabayItem> _pixabayItem = [];
  List<PixabayItem> get pixabayItem => List.unmodifiable(_pixabayItem);

  bool isLoading = false;


  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    _pixabayItem = await _repository.getImageResult(query);

    isLoading = false;
    notifyListeners();
  }


}
