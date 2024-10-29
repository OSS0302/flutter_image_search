import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../widget/image_widget.dart';
import 'image_event.dart';
import 'image_view_model.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final imageSearchSearchController = TextEditingController();
  StreamSubscription<ImageEvent>? subscription;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      subscription = context.read<ImageViewModel>().eventStream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            final snackBar = SnackBar(content: Text(event.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ShowDialog():
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Image Search App'),
                    content: Text('이미지 데이터 가져오기 완료'),
                    actions: [
                      _buildDialogButton(context, '확인', () => context.pop()),
                    ],
                  );
                });
        }
      });
    });
  }

  @override
  void dispose() {
    imageSearchSearchController.dispose();
    subscription?.cancel();
    super.dispose();
  }

  Widget _buildDialogButton(BuildContext context, String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.pink,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageViewModel = context.read<ImageViewModel>();
    final state = imageViewModel.state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          'Image Search App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                controller: imageSearchSearchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search for images...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Colors.pink),
                    onPressed: () async {
                      final result = await imageViewModel.fetchImage(imageSearchSearchController.text);
                      if (!result) {
                        _showSnackBar(context, 'Error fetching images');
                      }
                      setState(() {});
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.pink, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.pink, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.pink, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              if (state.isLoading)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircularProgressIndicator(color: Colors.pink),
                      SizedBox(height: 8),
                      Text('Loading, please wait...', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                )
              else
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: state.imageItem.length,
                    itemBuilder: (context, index) {
                      final imageItems = state.imageItem[index];
                      return GestureDetector(
                        onTap: () => _showImageDialog(context, imageItems),
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: ImageWidget(imageItems: imageItems),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: const TextStyle(color: Colors.white)), backgroundColor: Colors.pink),
    );
  }

  void _showImageDialog(BuildContext context, imageItems) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Image Search App'),
        content: const Text('이미지 데이터 가져오기 완료'),
        actions: [
          _buildDialogButton(context, '확인', () {
            context.push('/hero', extra: imageItems);
            context.pop();
          }),
          _buildDialogButton(context, '취소', () => context.pop()),
        ],
      ),
    );
  }
}
