import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_event.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';
import 'package:provider/provider.dart';

import '../widget/pixabay_widget.dart';
class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final textController = TextEditingController();
  StreamSubscription<PixabayEvent>? subscription;


  @override
  void initState() {
    subscription = context.read<PixabayViewModel>().eventStream.listen((event) { 
      switch(event) {
        
        case ShowSnackBar():
          final snackBar = SnackBar(content: Text(event.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        case ShowDialog():
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text('이미지 검색앱 '),
              content: Text('이미지 가져오기 완료'),
              actions: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.tealAccent,
                  ),
                  child: TextButton(onPressed: () {
                    context.pop();
                  }, child: Text('확인')),
                )
              ],
            );
          });
      }
    });
    super.initState();
  }
  
  @override
  void dispose() {
    subscription?.cancel();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pixbayViewModel = context.read<PixabayViewModel>();
    final state = pixbayViewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: Text('이미지 검색앱'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.tealAccent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.tealAccent,
                    ),
                  ),
                  hintText: '이미지 검색앱',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.tealAccent,
                    ),
                    onPressed: () async {
                     final result =  await pixbayViewModel.fetchImage(textController.text);

                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              if (state.isLoading) Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('잠시만 기다려 주세요'),
                        ],
                      ),
                    ) else Expanded(
                      child: GridView.builder(
                        itemCount: state.pixabayItem.length,
                        itemBuilder: (context, index) {
                          final pixabayItems =
                          state.pixabayItem[index];
                          return GestureDetector(
                            onTap: () async{
                              await showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  title: Text('이미지 검색앱'),
                                  content: Text('자세히 보시 겠 습니까'),
                                  actions: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.tealAccent,
                                      ),
                                      child: TextButton(onPressed: () {
                                        context.push('/detail', extra: pixabayItems);
                                        context.pop();
                                      }, child: Text('확인')),
                                    ),Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.tealAccent,
                                      ),
                                      child: TextButton(onPressed: () {
                                        context.pop();
                                      }, child: Text('취소')),
                                    )
                                  ],

                                );
                              }).then((value) {
                                if(value != null && value){}
                              });
                            },
                              child: PixabayWidget(pixabayItems: pixabayItems));
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 32,
                            crossAxisSpacing: 32),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
