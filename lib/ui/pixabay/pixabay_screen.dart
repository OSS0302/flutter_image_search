import 'package:flutter/material.dart';
import 'package:image_search_app/ui/pixabay/pixabay_view_model.dart';
import 'package:image_search_app/ui/widget/pixabay_widget.dart';

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
        title: const Text('pixabay search App'),
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
                  hintText: '이미지를 검색 하세요',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Colors.cyan,
                    ),
                    onPressed: () async {
                      await pixabayViewModel
                          .fetchImage(textEditingController.text);
                      setState(() {});
                    },

                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              pixabayViewModel.isLoading
                  ? const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('잠시민 기다려 주세요 로딩 중 입니다.'),
                        ],
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        itemCount: pixabayViewModel.pixabayItem.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 32,
                            mainAxisSpacing: 32),
                        itemBuilder: (context, index) {
                          final pixabayItems =
                              pixabayViewModel.pixabayItem[index];
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
