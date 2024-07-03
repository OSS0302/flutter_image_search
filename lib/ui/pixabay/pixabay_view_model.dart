import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/ui/pixabay/pixabay_state.dart';

import '../../data/model/pixabay_item.dart';
import '../../data/repository/pixabay_respository.dart';

class PixabayViewModel extends ChangeNotifier {
  final PixabayRepository _repository;

  PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

  PixabayState _state =
      PixabayState(isLoading: false, pixabayItem: List.unmodifiable([]));

  PixabayState get state => _state;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    final result = await _repository.getPixabayItem(query);
    _state = state.copyWith(
        isLoading: false,
        pixabayItem: result,
    );
    notifyListeners();
  }
}
