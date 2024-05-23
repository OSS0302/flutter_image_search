import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_image_search/data/repository/pixabay_repository_impl.dart';

import '../../data/model/pixabay_item.dart';

class PixabayViewModel extends ChangeNotifier {
  final _reposiotry = PixabayRepositoryImpl();
  List<PixabayItem> _pixabayItem = [];
  List<PixabayItem> get pixabayItem => List.unmodifiable(_pixabayItem);

  bool isLoading = false;

  final _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  Future<void> fetchImage(String query) async{
    _isLoadingController.add(true);

    _pixabayItem = await _reposiotry.getPixabayItem(query);
    _isLoadingController.add(false);
  }
}