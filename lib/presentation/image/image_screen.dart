import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/image/image_view_model.dart';
import 'package:image_search_app/presentation/widget/image_widget.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final imageSearchController = TextEditingController();
  final imageViewModel = ImageViewModel();

  @override
  void dispose() {
    imageSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('image Search app'),
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
                      color: Colors.redAccent,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 2,
                    ),
                  ),
                  hintText: '이미지를 검색 해주세요',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.redAccent,
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
              StreamBuilder<bool>(
                initialData: false,
                  stream: imageViewModel.isLoadingStream,
                  builder: (context, snapshot) {
                    if (snapshot.data! == null) {
                      return Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('(잠시만 기달려주세요)')
                        ],
                      );
                    }
                    return Expanded(
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
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
