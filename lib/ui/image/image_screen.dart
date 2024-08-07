import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/ui/image/image_view_model.dart';
import 'package:image_search_app/ui/widget/image_widget.dart';

import '../../data/model/image_item.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final imageSearchController = TextEditingController();
  final imageViewModel = ImaageViewModel();

  @override
  void dispose() {
    imageSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('image Search App'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: imageSearchController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.red,
                    ),
                  ),
                  helperText: '이미지 검색 하세요',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      await imageViewModel
                          .fetchImage(imageSearchController.text);
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              StreamBuilder(
                  stream: imageViewModel.isLoadingStream,
                  builder: (context, snapshot) {
                    if (snapshot.data! == null) {
                      return Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('데이터 로딩 중입니다. 잠시만 기다려 주세요'),
                        ],
                      );
                    }
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 32,
                            mainAxisSpacing: 32),
                        itemCount: imageViewModel.imageItem.length,
                        itemBuilder: (context, index) {
                          final imageItems = imageViewModel.imageItem[index];
                          return ImageWidget(imageItems: imageItems);
                        },
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
