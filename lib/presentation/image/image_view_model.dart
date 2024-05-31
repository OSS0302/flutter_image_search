import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/presentation/image/image_state.dart';

import '../../data/model/image_item.dart';
import '../../data/repository/image_repository.dart';

class ImageViewModel extends ChangeNotifier {
  final ImageRepository _repository;

  ImageViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  ImageState _state = ImageState(
    isLoading: false,
    imageItem: List.unmodifiable([]),
  );

  ImageState get state => _state;

  Future<bool> fetchImage(String query) async {
    _state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    try {
      final result = await _repository.getImageItems(query);
      _state.copyWith(
        isLoading: false,
        imageItem: result,
      );
      notifyListeners();
      return true;
    }catch(e) {
      return false;
    }


  }
}
