import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/image/image_view_model.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';
import 'package:provider/provider.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final imageSearchController = TextEditingController();


  @override
  void dispose() {
    imageSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageViewModel = context.read<ImageViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Image Search App'),
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
                        color: Colors.indigoAccent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.indigoAccent,
                      ),
                    ),
                    hintText: '이미지 검색 하세요~',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search_rounded,
                        color: Colors.indigoAccent,
                      ),
                      onPressed: () async {
                        await imageViewModel.fetchImage(imageSearchController.text);
                        setState(
                          () {},
                        );
                      },
                    )),
              ),
              SizedBox(
                height: 24,
              ),
              imageViewModel.isLoading ? Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text('잠시만 기다려 주세요 '),
                    Text('로딩 중 입니다.'),
                  ],
                ),
              )
              : Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 32,
                            crossAxisSpacing: 32),
                        itemCount: imageViewModel.imageItem.length,
                        itemBuilder: (context, index) {
                          final imageItems = imageViewModel.imageItem[index];
                          return ImageWidget(imageItems: imageItems);
                        },
                      ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
