import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';
import 'package:image_search_app/presentation/widget/pixabay_widget.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final pixabaySearchController = TextEditingController();
  final pixabayViewModel = PixabayViewModel();

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
                    onPressed: () async {
                      await pixabayViewModel
                          .searchImage(pixabaySearchController.text);

                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              StreamBuilder<bool>(
                initialData: false,
                  stream: pixabayViewModel.isLoadingStream, builder: (context,snapshot){
                if(snapshot.data! == true) {
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('잠시만 기다려 주세요 데이터 로딩중입니다.'),
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 32,
                        mainAxisSpacing: 32),
                    itemCount: pixabayViewModel.pixabayItem.length,
                    itemBuilder: (context, index) {
                      final pixabayItems =
                      pixabayViewModel.pixabayItem[index];
                      return PixabayWidget(pixabayItems: pixabayItems);
                    },
                  ),
                );
              })

            ],
          ),
        ),
      ),
    );
  }
}
