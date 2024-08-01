import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';

import '../../data/model/pixabay_item.dart';

class PixabayViewModel extends ChangeNotifier {
  final _repository = PixabayRepositoryImpl();
  bool isLoading = false;
  List<PixabayItem> _pixabayItem = [];
  List<PixabayItem> get pixabayItem => List.unmodifiable(_pixabayItem);

  final _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  Future<void> fetchImage(String query) async {
    _isLoadingController.add(true);

    _pixabayItem = await _repository.getPixabayItems(query);

    _isLoadingController.add(false);
  }
}