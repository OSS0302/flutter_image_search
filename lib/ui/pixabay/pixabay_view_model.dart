import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/ui/pixabay/pixabay_state.dart';

import '../../data/model/pixabay_item.dart';

class PixabayViewModel extends ChangeNotifier {
  final PixabayRepository _repository;

  PixabayViewModel({
    required PixabayRepository repository,
  }) : _repository = repository;

  PixabayState _state = PixabayState(
    isLoadiing: false,
    pixabayItem: List.unmodifiable([]),
  );

  PixabayState get state => _state;

  Future<bool> execute(String query) async {
    _state = state.copyWith(
      isLoadiing: true,
    );
    try {
      final result = await _repository.getPixabayItems(query);

      _state = state.copyWith(
        isLoadiing: false,
        pixabayItem: result,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
