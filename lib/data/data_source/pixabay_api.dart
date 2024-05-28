import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_search_app/data/dto/pixabay_dto.dart';

import '../../key.dart';
class PixabayApi {
  Future<PixabayDto> getImageResult(String query ) async{
   final response = await http.get(Uri.parse('https://pixabay.com/api/?key=$key&q=$query&image_type=photo&pretty=true'));
   return PixabayDto.fromJson(jsonDecode(response.body));
  }
}