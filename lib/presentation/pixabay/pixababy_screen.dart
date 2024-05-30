import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/presentation/widget/pixabay_widget.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixabay image Search App'),
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
                      width: 2,
                      color: Colors.purpleAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.purpleAccent,
                    ),
                  ),
                  hintText: '이미지를 검색하시오',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              FutureBuilder<List<PixabayItem>>(
                future: PixabayRepositoryImpl()
                    .getPixabayItem(textEditingController.text),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('잠시만 기다려 주세요'),
                        ],
                      ),
                    );
                  }
                  final pixabayItem = snapshot.data!;
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 32,
                          crossAxisSpacing: 32),
                      itemCount: pixabayItem.length,
                      itemBuilder: (context, index) {
                        final pixabayItems = pixabayItem[index];
                        return PixabayWidget(pixabayItems: pixabayItems);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
