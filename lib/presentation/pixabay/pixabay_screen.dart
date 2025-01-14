import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_event.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

class PixabayScreen extends StatefulWidget {
  const PixabayScreen({super.key});

  @override
  State<PixabayScreen> createState() => _PixabayScreenState();
}

class _PixabayScreenState extends State<PixabayScreen> {
  final textEditingController = TextEditingController();
  final List<String> searchHistory = [];
  StreamSubscription<PixabayEvent>? subscription;
  String sortOption = 'Relevance'; // 기본 정렬 옵션

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      subscription = context.read<PixabayViewModel>().eventStream.listen((event) {
        if (event is ShowSnackBar) {
          final snackBar = SnackBar(
            content: Text(event.message),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (event is ShowDialog) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: const Text('Pixabay Search'),
                content: const Text('Image data loaded!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.cyan,
                    ),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      });
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    subscription?.cancel();
    super.dispose();
  }

  Future<void> _searchImages(BuildContext context) async {
    final query = textEditingController.text.trim();
    if (query.isEmpty) {
      return;
    }
    final pixabayViewModel = context.read<PixabayViewModel>();
    await pixabayViewModel.fetchImage(query);
    setState(() {
      if (!searchHistory.contains(query)) {
        searchHistory.add(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pixabayViewModel = context.watch<PixabayViewModel>();
    final state = pixabayViewModel.state;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixabay Image Search'),
        elevation: 0,
        backgroundColor: isDarkMode ? Colors.black : Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              context.go('/');
            }
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                sortOption = value;
              });
            },
            icon: const Icon(Icons.sort),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Relevance', child: Text('Relevance')),
              const PopupMenuItem(value: 'Popular', child: Text('Popular')),
              const PopupMenuItem(value: 'Latest', child: Text('Latest')),
            ],
          ),
          IconButton(
            icon: isDarkMode
                ? const Icon(Icons.nightlight_round, color: Colors.white)
                : const Icon(Icons.wb_sunny, color: Colors.yellow),
            onPressed: () {
              MyApp.themeNotifier.value =
              MyApp.themeNotifier.value == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black : Colors.white,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 8,
                shadowColor: isDarkMode ? Colors.teal : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  children: [
                    TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        labelText: 'Search images...',
                        labelStyle: TextStyle(
                          color: isDarkMode ? Colors.white70 : Colors.teal[700],
                        ),
                        filled: true,
                        fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search_rounded),
                          color: Colors.teal,
                          onPressed: () => _searchImages(context),
                        ),
                      ),
                    ),
                    if (searchHistory.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: searchHistory.map((query) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  textEditingController.text = query;
                                  _searchImages(context);
                                },
                                child: Chip(
                                  label: Text(query),
                                  backgroundColor: Colors.teal[100],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : state.pixabayItem.isEmpty
                    ? Center(
                  child: Text(
                    '검색 결과가 없습니다.',
                    style: TextStyle(
                      color: isDarkMode
                          ? Colors.white70
                          : Colors.grey[700],
                    ),
                  ),
                )
                    : GridView.builder(
                  itemCount: state.pixabayItem.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final pixabayItems = state.pixabayItem[index];
                    return GestureDetector(
                      onTap: () => context.push('/hero',
                          extra: pixabayItems),
                      child: Hero(
                        tag: pixabayItems.id,
                        child: Card(
                          color: isDarkMode
                              ? Colors.grey[800]
                              : Colors.grey[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: isDarkMode
                                  ? Colors.white
                                  : Colors.teal,
                              width: 1.5,
                            ),
                          ),
                          elevation: 6,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(16),
                                  child: Image.network(
                                    pixabayItems.imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    loadingBuilder:
                                        (context, child,
                                        loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child:
                                        CircularProgressIndicator(
                                          value: loadingProgress
                                              .expectedTotalBytes !=
                                              null
                                              ? loadingProgress
                                              .cumulativeBytesLoaded /
                                              (loadingProgress
                                                  .expectedTotalBytes ??
                                                  1)
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  pixabayItems.tags,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isDarkMode
                                        ? Colors.white70
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
}
