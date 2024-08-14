import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';

import '../../data/model/image_item.dart';
import '../../data/repository/image_repository.dart';
import 'image_state.dart';

class ImageViewModel extends ChangeNotifier {
  final ImageRepository _repository;

  ImageViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  ImageState _state = ImageState(
    imageItem: List.unmodifiable([]),
    isLoading: false,
  );

  ImageState get state => _state;



  Future<bool> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true
    );
    notifyListeners();

    try {
      final result  = await _repository.getImageResult(query);

      switch(result) {

        case Success<List<ImageItem>>():
          _state = state.copyWith(
            isLoading: false,
            imageItem: result.data.toList(),
          );
          notifyListeners();

        case Error<List<ImageItem>>():
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
