import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/ui/image/image_state.dart';

import '../../data/model/image_item.dart';
import '../../data/repository/image_repository.dart';

class ImageViewModel extends ChangeNotifier {
  final  ImageRepository _repository;

   ImageViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  ImageState _state =  ImageState(isLoading: false, imageItem: List.unmodifiable([]));
  
  ImageState get state => _state;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );

    final result = await _repository.getImageItem(query);

    _state = state.copyWith(
      isLoading: false,
      imageItem: result,
    );
    notifyListeners();
  }
}
