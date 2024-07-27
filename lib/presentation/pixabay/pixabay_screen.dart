import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_event.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';

import 'package:provider/provider.dart';

import '../widget/pixabay_widget.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final pixabaySearchController = TextEditingController();
  StreamSubscription<PixabayEvent>? subscription;

  @override
  void initState() {
    Future.microtask(() {
      subscription =
          context.read<PixabayViewModel>().eventStream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            final snackBar = SnackBar(content: Text(event.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ShowDialog():
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('pixabay Search App'),
                    content: Text('pixabay data complete'),
                    actions: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.indigo),
                        child: TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: Text(
                              '확인',
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
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
    pixabaySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pixabayViewModel = context.read<PixabayViewModel>();
    final state = pixabayViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: Text('pixabay Search app'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: pixabaySearchController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.indigo,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.indigo,
                      width: 2,
                    ),
                  ),
                  hintText: '이미지 검색를 하세요',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.indigo,
                    ),
                    onPressed: () async {
                      await pixabayViewModel
                          .fetchImage(pixabaySearchController.text);

                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              if (state.isLoading)
                Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('잠시만 기다려 주세요'),
                      Text('로딩 중 입니다.'),
                    ],
                  ),
                )
              else
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 32,
                        crossAxisSpacing: 32),
                    itemCount: state.pixabayItem.length,
                    itemBuilder: (context, index) {
                      final pixabayItems = state.pixabayItem[index];
                      return GestureDetector(
                          onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('pixabay Search App'),
                                    content: Text('pixabay data complete'),
                                    actions: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.indigo),
                                        child: TextButton(
                                            onPressed: () {
                                              context.push('/hero',
                                                  extra: pixabayItems);
                                              context.pop();
                                            },
                                            child: Text(
                                              '확인',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.indigo),
                                        child: TextButton(
                                            onPressed: () {
                                              context.pop();
                                            },
                                            child: Text(
                                              '취소',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )),
                                      ),
                                    ],
                                  );
                                }).then((value) {
                              if (value != null && value) {}
                            });
                          },
                          child: PixabayWidget(pixabayItems: pixabayItems));
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
