import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/domain/use_case/image_search_use_case.dart';
import 'package:image_search_app/presentation/image/image_event.dart';

import '../../domain/model/image_item.dart';
import 'image_state.dart';

class ImageViewModel extends ChangeNotifier {
  final ImageSearchUseCase _searchUseCase;

   ImageViewModel({
    required ImageSearchUseCase searchUseCase,
  }) : _searchUseCase = searchUseCase;

  ImageState _state =
      ImageState(isLoading: false, imageItem: List.unmodifiable([]));

  ImageState get state => _state;

  final _eventController = StreamController<ImageEvent>();

  Stream<ImageEvent> get eventStream => _eventController.stream;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    final result = await _searchUseCase.execute(query);
    switch (result) {
      case Success<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
          imageItem: result.data.toList(),
        );
        notifyListeners();

        _eventController.add(const ImageEvent.showSnackBar('성공!!!'));
        _eventController.add(const ImageEvent.showDialog('다이얼로그'));

      case Error<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
        );
        notifyListeners();
    }
  }
}
