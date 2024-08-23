import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/ui/image/image_state.dart';

import '../../data/model/image_item.dart';
import '../../data/repository/image_repository.dart';
import 'image_event.dart';

class ImageViewModel extends ChangeNotifier {
  final ImageRepository _repository;

  ImageViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  ImageState _state = ImageState(
      isLoading: false, imageItem: List.unmodifiable([]));

  ImageState get state => _state;

  final _eventController = StreamController<ImageEvent>();

  Stream<ImageEvent> get eventStream => _eventController.stream;

  Future<bool> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    try {
      final result = await _repository.getImageItem(query);
      switch(result){

        case Success<List<ImageItem>>():
          _state = state.copyWith(

            isLoading: false,
            imageItem: result.data.toList(),
          );
          _eventController.add(ImageEvent.showSnackBar('데이터 가져오기 성공'));
          _eventController.add(ImageEvent.showDialog('다이얼로그 '));
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
