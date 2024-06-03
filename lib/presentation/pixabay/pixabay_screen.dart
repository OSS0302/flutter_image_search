
import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';
import 'package:image_search_app/presentation/widget/pixabay_widget.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final textEditingController = TextEditingController();
  final pixabayViewModel = PixabayViewModel();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색 앱'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.purpleAccent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.purpleAccent,
                      ),
                    ),
                    hintText: '이미지를 검색하세요',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search_rounded,
                        color: Colors.purpleAccent,
                      ),
                      onPressed: () async{
                        await pixabayViewModel.fetchImage(textEditingController.text);
                        setState(() {});
                      },
                    )),
              ),
              SizedBox(
                height: 24,
              ),
              pixabayViewModel.isLoading ?  Center(
                child: Column(
                  children: [
                    Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('잠시만 기다려 주세요'),
                      ],
                    ),
                  ],
                ),
              )
              :Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 32,
                                    mainAxisSpacing: 32),
                            itemCount: pixabayViewModel.pixabyaItem.length,
                            itemBuilder: (context, index) {
                              final pixabayItems = pixabayViewModel.pixabyaItem[index];
                              return PixabayWidget(pixabayItems: pixabayItems);
                            }))

            ],
          ),
        ),
      ),
    );
  }
}
