import 'dart:convert';

import '../dto/image_dto.dart';
import 'package:http/http.dart'as http;

class ImageApi {
  Future<ImageDto> getImageResult(String query) async{
    final response = await http.get(Uri.parse('https://pixabay.com/api/?key=38081108-118a6127b8642576a388e6c5e&q=yellow+flowers&image_type=photo&pretty=true'));
    return ImageDto.fromJson(jsonDecode(response.body));
  }
}
