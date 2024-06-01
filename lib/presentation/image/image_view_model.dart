import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/presentation/image/image_state.dart';

import '../../data/model/image_item.dart';
import '../../data/repository/image_repository.dart';
import 'image_event.dart';

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

  final _eventController = StreamController<ImageEvent>();

  Stream<ImageEvent> get eventStream => _eventController.stream;

  Future<void> fetchImage(String query) async {
    _state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    final result = await _repository.getImageItems(query);
    switch(result) {
      case Success<List<ImageItem>>():

        _state.copyWith(
          isLoading: false,
          imageItem: result.data.toList(),
        );
        notifyListeners();
        _eventController.add(ImageEvent.showSnackBar('성공!!'));
        _eventController.add(ImageEvent.showDialog('다이얼로그!!'));

      case Error<List<ImageItem>>():
        // TODO: Handle this case.
    }



  }
}
