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
  final pixabaySearchController = TextEditingController();

  @override
  void dispose() {
    pixabaySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('pixbay Search App'),
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
                        width: 2,
                        color: Colors.blueAccent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.blueAccent,
                      ),
                    ),
                    hintText: '이미지를 검색하세요',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.ads_click_outlined,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ),
                ),
                SizedBox(height: 24,),
                FutureBuilder<List<PixabayItem>>(future: PixabayRepositoryImpl().getPixabayItem(
                    pixabaySearchController.text),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: Column(
                          children: [
                            CircularProgressIndicator(),
                            Text('잠시만 기다려 주세요 데이터 로딩중입니다.'),
                          ],
                        ),);
                      }
                      final pixabayItem = snapshot.data!;
                      return Expanded(child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 32,
                              mainAxisSpacing: 32),
                          itemCount: pixabayItem.length,
                          itemBuilder: (context, index) {
                              final pixabayItems = pixabayItem[index];
                              return PixabayWidget(pixabayItems: pixabayItems);
                          }));
                    })
              ],
            ),
          )),
    );
  }
}
