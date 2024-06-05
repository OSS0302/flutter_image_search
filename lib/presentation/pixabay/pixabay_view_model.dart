import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_state.dart';

import '../../data/model/pixabay_item.dart';
import '../../data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final PixabayRepository _repository;

  PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

  PixabayState _state = PixabayState(
    isLoading: false,
    pixabyaItem: List.unmodifiable([]),
  );

  PixabayState get state => _state;

  Future<void> fetchImage(String query) async {

    _state.copyWith(
      isLoading: true,
    );
    notifyListeners();


    _state.copyWith(
      isLoading: false,
      pixabyaItem: List.unmodifiable(
          (await _repository.getPixabayItem(query)).toList()),
    );
    notifyListeners();
  }
}
