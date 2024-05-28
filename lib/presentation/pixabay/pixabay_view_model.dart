import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/core/result.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_event.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_state.dart';

import '../../data/model/pixabay_item.dart';
import '../../data/repository/pixabay_repository.dart';

class PixabayViewModel extends ChangeNotifier {
  final PixabayRepository _repository ;
   PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

  PixabayState _state =  PixabayState(isLoading: false, pixabayItem: List.unmodifiable([]));

  PixabayState get state => _state;

  final _eventController = StreamController<PixabayEvent>();

  Stream<PixabayEvent> get eventStream => _eventController.stream;

  Future<void> fetchImage(String query) async {
    _state = state.copyWith(
      isLoading: true,

    );
    notifyListeners();

    final result = await _repository.getPixabayItem(query);
    switch(result) {

      case Success<List<PixabayItem>>():
        _state = state.copyWith(
          isLoading: false,
          pixabayItem: result.data.toList(),
        );
        notifyListeners();
        _eventController.add(PixabayEvent.showSnackBar('성공'));
        _eventController.add(PixabayEvent.showDialog('다이얼로그'));
      case Error<List<PixabayItem>>():
        _state = state.copyWith(
          isLoading: false,
        );
    }
    notifyListeners();
  }


}