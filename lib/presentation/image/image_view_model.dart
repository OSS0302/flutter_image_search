import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

import 'image_state.dart';

class ImageViewModel extends ChangeNotifier {
  final ImageRepository _repository;


  ImageViewModel({
    required ImageRepository repository,
  }) : _repository = repository;


  ImageState _state =  ImageState(isLoading: false, imageItem: List.unmodifiable([]));

  ImageState get state => _state;



  Future<bool> fetchImage(String query) async{
    _state = state.copyWith(
      isLoading: true,

    );
    notifyListeners();

    try {
      final result = await _repository.getImageItems(query);
      _state = state.copyWith(
        isLoading: false,
        imageItem: List.unmodifiable(result),
      );

      notifyListeners();
      return true;
    }catch(e) {
      return false;
    }



  }
}