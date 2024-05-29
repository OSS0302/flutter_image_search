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
        title: const Text('이미지 검색앱'),
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
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.tealAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.tealAccent,
                    ),
                  ),
                  hintText: '이미지 검색앱',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.ads_click_rounded),
                    color: Colors.tealAccent,
                    onPressed: () async{
                      await imageViewModel.fetchImage(imageSearchController.text);
                      setState(() {});
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
             StreamBuilder<bool>(
               initialData:  false,
                 stream: imageViewModel.isLoadingStream, builder: (context,snapshot){
               if(snapshot.data! == true) {
                 return Center(
                   child: Column(
                     children: [
                       CircularProgressIndicator(),
                       Text('잠시만 기다려 주세요'),
                     ],
                   ),
                 );
               }
               return Expanded(
                 child: GridView.builder(
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 4,
                       mainAxisSpacing: 32,
                       crossAxisSpacing: 32),
                   itemCount: imageViewModel.imageItem.length,
                   itemBuilder: (context, index) {
                     final imageItems = imageViewModel.imageItem[index];
                     return ImageWidget(imageItem: imageItems);
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
