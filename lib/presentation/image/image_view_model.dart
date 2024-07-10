import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/domain/use_case/search_use_case.dart';
import 'package:image_search_app/presentation/image/image_event.dart';

import '../../domain/model/image_item.dart';
import 'image_state.dart';

class ImageViewModel extends ChangeNotifier {
  final SearchUseCase _searchUseCase;

  ImageViewModel({
    required SearchUseCase searchUseCase,
  }) : _searchUseCase = searchUseCase;

  ImageState _state = ImageState(
    imageItem: List.unmodifiable([]),
    isLoading: false,
  );

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
        _eventController.add(ImageEvent.showSnackBar('성공'));
        _eventController.add(ImageEvent.showDialog('다이얼로그'));
      case Error<List<ImageItem>>():
        _state = state.copyWith(
          isLoading: false,
        );
        notifyListeners();
    }
  }
}
