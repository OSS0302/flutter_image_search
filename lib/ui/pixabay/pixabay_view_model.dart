import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';

class PixabayViewModel with ChangeNotifier {
  final _repository = PixabayRepositoryImpl();

  List<PixabayItem> _pixabayItem = [];
  List<PixabayItem> get pixabayItem => List.unmodifiable(_pixabayItem);

  bool isLoading = false;

  final _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  Future<void> fetchImage(String query) async {
    _isLoadingController.add(true);

    _pixabayItem = await _repository.getImageResult(query);

    _isLoadingController.add(false);
  }
}
