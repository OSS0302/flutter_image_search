import 'dart:async';

import 'package:flutter/material.dart';

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

  final _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true
    );
    notifyListeners();

    final result  = await _repository.getImageResult(query);

    _state = state.copyWith(
        isLoading: false,
        imageItem: result,
    );
    notifyListeners();
  }
}
