import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/preseantation/pixabay/pixabay_event.dart';
import 'package:image_search_app/preseantation/pixabay/pixabay_view_model.dart';
import 'package:provider/provider.dart';

import '../widget/pixbay_widget.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final pixabaySearchController = TextEditingController();
  StreamSubscription<PixabayEvent>? subscription;

  @override
  void initState() {
    Future.microtask(() {
      subscription =
          context.read<PixabayViewModel>().eventStream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            final snackBar = SnackBar(content: Text(event.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ShowDialog():
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('pixabay Search App'),
                    content: Text('이미지 데이터 가져오기 완료'),
                    actions: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.redAccent,
                        ),
                        child: TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(
                            '확인',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
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
                        final result = await pixbayViewModel
                            .fetchImage(pixabaySearchController.text);
                        if (result == false) {
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
                          return GestureDetector(
                            onTap: () async{
                              await showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  title: Text('pixabay Search App'),
                                  content: Text('이미지 데이터 가져오기 완료'),
                                  actions: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.redAccent,
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          context.push('/hero',extra:pixbayItems);
                                          context.pop();
                                        },
                                        child: Text(
                                          '확인',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).then((value) {
                                if(value != null && value){}
                              });
                            },
                              child: PixbayWidget(pixabayItems: pixbayItems));
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
