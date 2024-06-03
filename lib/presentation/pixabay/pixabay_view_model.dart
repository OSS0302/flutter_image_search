import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';

import '../../data/model/pixabay_item.dart';
import '../../data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final PixabayRepository _repository;

   PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

  bool isLoading = false;

  List<PixabayItem> _pixabyaItem = [];
  List<PixabayItem> get pixabyaItem => List.unmodifiable(_pixabyaItem);



  Future<void> fetchImage(String query) async{
    isLoading = true;
    notifyListeners();

    _pixabyaItem = await _repository.getPixabayItem(query);
    isLoading = false;
    notifyListeners();
  }
}