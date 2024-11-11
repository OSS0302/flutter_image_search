import 'package:flutter/material.dart';
import 'package:image_search_app/domain/model/pixabay_item.dart';

class HeroScreen extends StatelessWidget {
  final PixabayItem pixabayItem;

  const HeroScreen({super.key, required this.pixabayItem});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pixabayItem.tags,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.grey[850] : Colors.cyan,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.black, Colors.grey[850]!]
                : [Colors.cyan[200]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: GestureDetector(
              onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode
                              ? Colors.black.withOpacity(0.5)
                              : Colors.grey.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      border: Border.all(
                        color: isDarkMode ? Colors.white : Colors.cyan,
                        width: 2,
                      ),
                    ),
                    child: Hero(
                      tag: pixabayItem.imageUrl,
                      child: Image.network(
                        pixabayItem.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 450,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: isDarkMode ? Colors.black87 : Colors.grey[200],
    );
  }
}
