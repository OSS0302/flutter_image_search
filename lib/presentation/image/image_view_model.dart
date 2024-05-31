import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';

import '../../data/model/image_item.dart';
import '../../data/repository/image_repository.dart';

class ImageViewModel extends ChangeNotifier {
  final ImageRepository _repository;

   ImageViewModel({
    required ImageRepository repository,
  }) : _repository = repository;

  bool isLoading = false;
  List<ImageItem> _imageItem = [];
  List<ImageItem> get imageItem => List.unmodifiable(_imageItem);


 Future<void> fetchImage(String query) async{
   isLoading = true;
   notifyListeners();

   _imageItem = await _repository.getImageItems(query);
   isLoading = false;
   notifyListeners();

 }
}