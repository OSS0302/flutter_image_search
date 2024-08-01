import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/ui/pixabay/pixabay_view_model.dart';
import 'package:image_search_app/ui/widget/pixbay_widget.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final pixabaySearchController = TextEditingController();
  final pixbayViewModel = PixabayViewModel();

  @override
  void dispose() {
    pixabaySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('pixabay Search App'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: pixabaySearchController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.redAccent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.redAccent,
                      ),
                    ),
                    labelText: '이미지를 검색 하세요',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search_rounded,
                        color: Colors.redAccent,
                      ),
                      onPressed: () async {
                        await pixbayViewModel
                            .fetchImage(pixabaySearchController.text);
                        setState(() {});
                      },
                    )),
              ),
              SizedBox(
                height: 24,
              ),
              StreamBuilder(
                initialData: false,
                  stream: pixbayViewModel.isLoadingStream, builder: (context, snapshot){
                if(snapshot.data! == true) {
                  return  Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('로딩 중 입니다. 잠시만 기다려 주세요'),
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: GridView.builder(
                    itemCount: pixbayViewModel.pixabayItem.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 32,
                        mainAxisSpacing: 32),
                    itemBuilder: (context, index) {
                      final pixbayItems =
                      pixbayViewModel.pixabayItem[index];
                      return PixbayWidget(pixabayItems: pixbayItems);
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
