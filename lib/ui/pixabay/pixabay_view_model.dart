import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';

class PixabayViewModel with ChangeNotifier {
  final _repository = PixabayRepositoryImpl();

  List<PixabayItem> pixabayItem = [];


  bool isLoading = false;

  Future<void> fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    pixabayItem = await _repository.getImageResult(query);

    isLoading = false;
    notifyListeners();
  }
}
