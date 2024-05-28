import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/model/pixabay_item.dart';
import '../../data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final PixabayRepository _repository ;
   PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

  bool isLoading = false;
  List<PixabayItem> _pixabayItem = [];
  List<PixabayItem> get pixabayItem => List.unmodifiable(_pixabayItem);



  Future<void> fetchImaage(String query) async{
    isLoading = true;
    notifyListeners();

    _pixabayItem = await _repository.getPixabayItem(query);
    isLoading = false;
    notifyListeners();
  }

}