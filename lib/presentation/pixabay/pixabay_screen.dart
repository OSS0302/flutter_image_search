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
  final pixbaySearchController = TextEditingController();
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
                    title: const Text('pixbay Image Search App'),
                    content: const Text('데이터 가져 오기 완료 '),
                    actions: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text('확인'),
                        ),
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
    pixbaySearchController.dispose();
    subscription?.cancel();
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
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
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
                      if (result == false) {
                        const snackBar = SnackBar(content: Text('오류'));
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                      setState(() {});
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              state.isLoading
                  ? const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('잠시만 기다려 주세요 로딩중 입니다.'),
                        ],
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 32,
                                crossAxisSpacing: 32),
                        itemCount: state.pixabayItem.length,
                        itemBuilder: (context, index) {
                          final pixabayItems = state.pixabayItem[index];
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
