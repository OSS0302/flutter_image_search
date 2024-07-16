import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository.dart';

import '../../data/model/image_item.dart';

class ImageViewModel extends ChangeNotifier {
  final ImageRepository _repository;

   ImageViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  List<ImageItem> _imageItem = [];
  List<ImageItem> get imageItem => List.unmodifiable(_imageItem);

  bool isLoading = false;



  Future<void> fetchImage(String query) async{
    isLoading = true;
    notifyListeners();

    _imageItem = await _repository.getImageItems(query);

    isLoading = false;
    notifyListeners();

  }
}