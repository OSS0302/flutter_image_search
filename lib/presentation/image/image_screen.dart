import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../data/model/image_item.dart';
import '../widget/image_widget.dart';
import 'image_event.dart';
import 'image_view_model.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final imageSearchController = TextEditingController();
  StreamSubscription<ImageEvent>? subscription;

  @override
  void initState() {
    Future.microtask(() {
      subscription = context.read<ImageViewModel>().eventStream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            final snackBar = SnackBar(content: Text(event.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ShowDialog():
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('image Search App'),
                    content: Text('이미지 가져오기 완료'),
                    actions: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueAccent,

                        ),
                        child: TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: Text('확인')),
                      )
                    ],
                  );
                });
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    imageSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageViewModel = context.read<ImageViewModel>();
    final state = imageViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: Text('image Search App'),
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
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.blue,
                    ),
                  ),
                  hintText: '이미지를 검색 하세요',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.blue,
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
              if (state.isLoading) Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('잠시만 기다려 주세요'),
                          Text('로딩 중 입니다.'),
                        ],
                      ),
                    ) else Expanded(
                      child: GridView.builder(
                        itemCount: state.imageItem.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 32,
                          crossAxisSpacing: 32,
                        ),
                        itemBuilder: (context, index) {
                          final imageItems = state.imageItem[index];
                          return GestureDetector(
                            onTap: () async{
                              await showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  title: Text('image Search App'),
                                  content: Text('이미지 가져오기 완료'),
                                  actions: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blueAccent,

                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            context.push('/hero', extra: imageItems);
                                            context.pop();
                                          },
                                          child: Text('확인')),
                                    ),Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blueAccent,

                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            context.pop();
                                          },
                                          child: Text('취소')),
                                    ),
                                  ],
                                );
                              }).then((value) {
                                if(value != null && value) {}
                              });
                            },
                              child: ImageWidget(imageItems: imageItems));
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
