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
  final textEditingController = TextEditingController();
  StreamSubscription<PixabayEvent>? subscription;

  @override
  void initState() {
    Future.microtask(() {
      subscription =
          context.read<PixabayViewModel>().eventStream.listen((event) {
            switch (event) {
              case ShowSnackBar():
                final snackBar = SnackBar(
                  content: Text(event.message),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  duration: const Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              case ShowDialog():
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: const Text('Pixabay Search'),
                      content: const Text('이미지 데이터 가져오기 완료!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.cyan,
                          ),
                          child: const Text('확인'),
                        ),
                      ],
                    );
                  },
                );
            }
          });
    });
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pixabayViewModel = context.watch<PixabayViewModel>();
    final state = pixabayViewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixabay Image Search'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  labelText: '이미지 검색',
                  hintText: '검색어를 입력하세요',
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.cyan,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.cyan,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search_rounded),
                    color: Colors.cyan,
                    onPressed: () async {
                      await pixabayViewModel
                          .fetchImage(textEditingController.text);
                      setState(() {});
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              state.isLoading
                  ? const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('로딩 중입니다...'),
                  ],
                ),
              )
                  : Expanded(
                child: GridView.builder(
                  itemCount: state.pixabayItem.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final pixabayItems = state.pixabayItem[index];
                    return GestureDetector(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Pixabay Image'),
                              content: const Text('이미지 자세히 보시겠습니까?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context.push('/hero',
                                        extra: pixabayItems);
                                    context.pop();
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white, backgroundColor: Colors.cyan,
                                  ),
                                  child: const Text('확인'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: const Text('취소'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: PixabayWidget(pixabayItems: pixabayItems),
                    );
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
