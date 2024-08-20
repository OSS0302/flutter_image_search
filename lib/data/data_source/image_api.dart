import 'dart:convert';

import 'package:image_search_app/key.dart';

import '../dto/image_dto.dart';
import 'package:http/http.dart'as http;

class ImageApi {
  Future<ImageDto> getImageResult(String query) async{
    final response = await http.get(Uri.parse('https://pixabay.com/api/?key=$key&q=$query&image_type=photo&pretty=true'));
    return ImageDto.fromJson(jsonDecode(response.body));
  }
}
