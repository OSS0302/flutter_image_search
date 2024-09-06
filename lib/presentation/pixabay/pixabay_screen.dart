import 'dart:async';

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
  final textEditingController = TextEditingController();
  StreamSubscription<PixabayEvent>? subscription;

  @override
  void initState() {
   Future.microtask((){
     subscription =  context.read<PixabayViewModel>().eventStream.listen((event){
       switch(event){

         case ShowSnackBar():
          final snackBar = SnackBar(content: Text(event.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
         case ShowDialog():
           showDialog(context: context, builder: (context){
             return AlertDialog(
               title: Text('pixabay search App'),
               content: Text('이미지 데이터 가져오기 완료'),
               actions: [
                 Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20),
                     color: Colors.cyan,
                   ),
                   child: TextButton(onPressed: () {
                     context.pop();
                                }, child: Text('확인')),
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
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pixabayViewModel = context.read<PixabayViewModel>();
    final state = pixabayViewModel.state;
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
              state.isLoading
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
                        itemCount: state.pixabayItem.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 32,
                                mainAxisSpacing: 32),
                        itemBuilder: (context, index) {
                          final pixabayItems =
                              state.pixabayItem[index];
                          return GestureDetector(
                            onTap: () async{
                              await showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  title: Text('pixabay search App'),
                                  content: Text('이미지 자세히 보시겠습니까 ?'),
                                  actions: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.cyan,
                                      ),
                                      child: TextButton(onPressed: () {
                                        context.push('/hero',extra: pixabayItems);
                                        context.pop();
                                      }, child: Text('확인')),
                                    ),Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.cyan,
                                      ),
                                      child: TextButton(onPressed: () {
                                        context.pop();
                                      }, child: Text('취소')),
                                    ),
                                  ],
                                );
                              });
                            },
                              child: PixabayWidget(pixabayItems: pixabayItems));
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
