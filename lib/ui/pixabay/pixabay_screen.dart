import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_search_app/ui/pixabay/pixabay_view_model.dart';
import 'package:image_search_app/ui/widget/pixabay_widget.dart';
import 'package:provider/provider.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final pixbaySearchController = TextEditingController();


  @override
  void dispose() {
    pixbaySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pixabayViewModel = context.read<PixabayViewModel>();
    final state = pixabayViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('pixabay Search App '),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: pixbaySearchController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  hintText: '이미지 검색를 하세요',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Colors.pinkAccent,
                    ),
                    onPressed: () async {
                     final result = await pixabayViewModel
                          .fetchImage(pixbaySearchController.text);
                     if(result == false) {
                       const snackBar = SnackBar(content: Text('오류'));
                       if(mounted) {
                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                       }
                     }
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              state.isLoading
                  ? Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('잠시만 기다려 주세요 로딩중 입니다.'),
                        ],
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 32,
                            crossAxisSpacing: 32),
                        itemCount: state.pixabayItem.length,
                        itemBuilder: (context, index) {
                          final pixabayItems =
                              state.pixabayItem[index];
                          return PixabayWidget(pixabayItems: pixabayItems);
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
