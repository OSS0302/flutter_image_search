import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';
import 'package:image_search_app/ui/image/image_state.dart';

import '../../data/model/image_item.dart';

class ImageViewModel extends ChangeNotifier {
  final ImageRepository _repository;

   ImageViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  ImageState _state =  ImageState(imageItem: List.unmodifiable([]), isLoading: false);

  ImageState get state => _state;



  Future<void> fetchImage(String query) async{
    _state =state.copyWith(
      isLoading: true,

    );
    notifyListeners();

    final result = await _repository.getImageItems(query);
    _state =state.copyWith(
      isLoading: false,
      imageItem: result,
    );
    notifyListeners();

  }
}