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
  final textSearchController = TextEditingController();

  @override
  void dispose() {
    textSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    borderSide: BorderSide(
                      color: Colors.amberAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.amberAccent,
                    ),
                  ),
                  hintText: '이미지 검색 하세요',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {

                      });
                    },
                    icon: Icon(
                      Icons.ads_click_sharp,
                      color: Colors.amberAccent,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              FutureBuilder<List<PixabayItem>>(
                  future: PixabayRepositoryImpl()
                      .getPixabayItem(textSearchController.text),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            Text('데이터 로딩중입니다.')
                          ],
                        ),
                      );
                    }
                    final pixabayItem = snapshot.data!;
                    return Expanded(
                      child: GridView.builder(
                        itemCount: pixabayItem.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 32,
                            mainAxisSpacing: 32),
                        itemBuilder: (context, index) {
                          final pixabayItems = pixabayItem[index];
                         return PixabayWidget(pixabayItems: pixabayItems);
                        },
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
