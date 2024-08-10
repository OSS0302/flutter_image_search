import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/model/image_item.dart';
import '../../data/repository/image_repository.dart';

class ImageViewModel extends ChangeNotifier {
  final ImageRepository _repository ;

   ImageViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  List<ImageItem> _imageItem = [];
  List<ImageItem> get imageItem => List.unmodifiable(_imageItem);
  bool isLoading = false;

  final _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  Future<void> fetchImage(String query) async{
    _isLoadingController.add(true);

    _imageItem = await _repository.getImageResult(query);

    _isLoadingController.add(false);
  }
}