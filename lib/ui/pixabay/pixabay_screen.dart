
import 'package:flutter/material.dart';
import 'package:image_search_app/ui/pixabay/pixabay_view_model.dart';
import 'package:image_search_app/ui/widget/pixbay_widget.dart';
import 'package:provider/provider.dart';

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
    final pixbayViewModel = context.read<PixabayViewModel>();
    final state = pixbayViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('pixabay Search App'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: pixabaySearchController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.redAccent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.redAccent,
                      ),
                    ),
                    labelText: '이미지를 검색 하세요',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search_rounded,
                        color: Colors.redAccent,
                      ),
                      onPressed: () async {
                       final result =  await pixbayViewModel
                            .fetchImage(pixabaySearchController.text);
                       if(result == false) {
                         const snackBar = SnackBar(content: Text('오류'));
                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                       }
                        setState(() {});
                      },
                    )),
              ),
              SizedBox(
                height: 24,
              ),
              pixbayViewModel.state.isLoading
                  ? Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('로딩 중 입니다. 잠시만 기다려 주세요'),
                        ],
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        itemCount: pixbayViewModel.state.pixabayItem.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 32,
                            mainAxisSpacing: 32),
                        itemBuilder: (context, index) {
                          final pixbayItems =
                              pixbayViewModel.state.pixabayItem[index];
                          return PixbayWidget(pixabayItems: pixbayItems);
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
