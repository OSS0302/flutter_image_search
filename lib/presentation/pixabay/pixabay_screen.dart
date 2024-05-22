import 'package:flutter/material.dart';
import 'package:flutter_image_search/presentation/pixabay/pixabay_view_model.dart';
import 'package:flutter_image_search/presentation/widget/pixabay_widget.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final textController = TextEditingController();
  final pixbayViewModel = PixabayViewModel();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('이미지 검색앱'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.tealAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.tealAccent,
                    ),
                  ),
                  hintText: '이미지 검색앱',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.tealAccent,
                    ),
                    onPressed: () async{
                      await pixbayViewModel.fetchImage(textController.text);
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              pixbayViewModel.isLoading
                  ? Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('잠시만 기다려 주세요 '),
                        ],
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        itemCount: pixbayViewModel.pixabayItem.length,
                        itemBuilder: (context, index) {
                          final pixabayItems =
                              pixbayViewModel.pixabayItem[index];
                          return PixabayWidget(pixabayItems: pixabayItems);
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 32,
                            crossAxisSpacing: 32),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
