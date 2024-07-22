import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/ui/widget/pixabay_widget.dart';

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
                  hintText: '이미지 검색앱',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.indigo,
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(height: 24,),
              FutureBuilder(future: PixabayRepositoryImpl().getPixabayItem(pixabaySearchController.text), builder: (context,snapshot){
                if(!snapshot.hasData) {
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('잠시만 기다려 주세요'),
                        Text('로딩 중 입니다.'),
                      ],
                    ),
                  );
                }
                final pixabayItem = snapshot.data!;
                return Expanded(
                  child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,mainAxisSpacing: 32,crossAxisSpacing: 32), itemCount: pixabayItem.length,itemBuilder: (context,index){
                    final pixabayItems = pixabayItem[index];
                    return PixabayWidget(pixabayItems: pixabayItems);
                  }),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
