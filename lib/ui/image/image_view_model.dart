import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/Image_repository_impl.dart';

import '../../data/model/image_item.dart';

class ImageViewModel extends ChangeNotifier {
  final repository = ImageRepositoryImpl();

  List<ImageItem> _imageItem = [];
  List<ImageItem> get imageItem => List.unmodifiable(_imageItem);

  bool isLoading = false;

  final _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  Future<void> fetchImage(String query) async{
    _isLoadingController.add(true);

    _imageItem = await repository.getImageItems(query);

    _isLoadingController.add(false);

  }

}