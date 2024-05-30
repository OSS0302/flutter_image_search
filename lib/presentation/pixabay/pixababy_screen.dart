import 'package:flutter/material.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';
import 'package:image_search_app/presentation/widget/pixabay_widget.dart';

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
                    onPressed: () async {
                      await pixabayViewModel
                          .searchImage(textEditingController.text);
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
                        Text('잠시만 기다려 주세요'),
                      ],
                    ),
                  );
                }
               return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 32,
                        crossAxisSpacing: 32),
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
