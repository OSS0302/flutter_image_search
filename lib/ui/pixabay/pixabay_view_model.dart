import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/ui/pixabay/pixabay_state.dart';

import '../../data/model/pixabay_item.dart';
import '../../data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final  PixabayRepository _repository;

   PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;



  PixabayState _state =  PixabayState(isLoading: false, pixabayItem: List.unmodifiable([]));

  PixabayState get state => _state;

  Future<bool> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    try {
      final result  = await _repository.getPixabayItems(query);
      switch(result) {

        case Success<List<PixabayItem>>():
          _state = state.copyWith(
            isLoading: false,
            pixabayItem: result.data.toList(),
          );
          notifyListeners();
        case Error<List<PixabayItem>>():
          _state = state.copyWith(
            isLoading: false,
          );
          notifyListeners();
      }

      return true;
    }catch(e) {
      return false;
    }


  }
}