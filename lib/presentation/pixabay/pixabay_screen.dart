import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_event.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';
import 'package:image_search_app/presentation/widget/pixabay_widget.dart';
import 'package:provider/provider.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final textSearchController = TextEditingController();
  StreamSubscription<PixabayEvent>? subscription;

  @override
  void initState() {
    Future.microtask(() {
      subscription =
          context.read<PixabayViewModel>().eventStream.listen((event) {
        switch (event) {
          case ShowDialog():
            final snackBar = SnackBar(content: Text(event.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ShowSnackBar():
            showDialog(
                context: context,
                builder: (context) {
                  return  AlertDialog(
                    title: Text('pixabay image Search App'),
                    content: Text('데이터 가져오기 완료'),
                    actions: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.amberAccent,
                        ),
                        child: TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: Text('확인')),
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
    textSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pixabayViewModel = context.read<PixabayViewModel>();
    final state = pixabayViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('pixabay image Search App'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: textSearchController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.amberAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.amberAccent,
                    ),
                  ),
                  hintText: '이미지 검색 하세요',
                  suffixIcon: IconButton(
                    onPressed: () async {
                      await pixabayViewModel
                          .fetchImage(textSearchController.text);
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.ads_click_sharp,
                      color: Colors.amberAccent,
                    ),
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
                          Text('데이터 로딩중입니다.')
                        ],
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        itemCount: state.pixabayItem.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 32,
                                mainAxisSpacing: 32),
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
