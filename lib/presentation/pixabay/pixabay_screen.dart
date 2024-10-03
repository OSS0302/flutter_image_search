import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_event.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
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
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.cyan,
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
        elevation: 0,
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: pixabayViewModel.isLightMode
                ? const Icon(Icons.wb_sunny, color: Colors.yellow)
                : const Icon(Icons.nightlight_round, color: Colors.white),
            onPressed: () {
              setState(() {
                pixabayViewModel.isLightMode = !pixabayViewModel.isLightMode;
              });
              MyApp.themeNotifier.value =
              MyApp.themeNotifier.value == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: pixabayViewModel.isLightMode ? Colors.white : Colors.black87,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Search for Images',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter image keyword',
                  hintText: 'e.g. nature, car, animals',
                  filled: true,
                  fillColor: pixabayViewModel.isLightMode
                      ? Colors.grey[200]
                      : Colors.grey[800],
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
                    Text('Fetching images...'),
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: const Text('Pixabay Image'),
                              content: const Text('View image details?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context.push('/hero',
                                        extra: pixabayItems);
                                    context.pop();
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.cyan,
                                  ),
                                  child: const Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Card(
                        color: pixabayViewModel.isLightMode
                            ? Colors.white
                            : Colors.grey[800], // 배경색 설정
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: PixabayWidget(
                                    pixabayItems: pixabayItems),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                pixabayItems.tags,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: pixabayViewModel.isLightMode
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
