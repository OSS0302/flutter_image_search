import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  final int _maxImages = 10;
  bool _isMultiSelectMode = false;
  final Set<int> _selectedForDeletion = {};

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        final selectedImages = pickedFiles.map((file) => File(file.path)).toList();
        if (selectedImages.length + _selectedImages.length <= _maxImages) {
          _selectedImages.addAll(selectedImages);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('최대 $_maxImages개의 이미지만 선택할 수 있습니다.'),
            ),
          );
        }
      });
    }
  }

  void _removeSelectedImages() {
    setState(() {
      _selectedForDeletion.toList().reversed.forEach((index) {
        _selectedImages.removeAt(index);
      });
      _selectedForDeletion.clear();
      _isMultiSelectMode = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('선택된 이미지가 삭제되었습니다.')),
    );
  }

  void _uploadImages() {
    // 업로드 로직을 추가하세요 (예: Firebase, 서버 업로드 등)
    print('이미지 업로드: ${_selectedImages.length}개');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('이미지가 업로드되었습니다!')),
    );
  }

  void _toggleMultiSelect(int index) {
    setState(() {
      if (_selectedForDeletion.contains(index)) {
        _selectedForDeletion.remove(index);
      } else {
        _selectedForDeletion.add(index);
      }
    });
  }

  void _showFullImage(File image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Center(
            child: Image.file(image),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isMultiSelectMode ? '이미지 선택 (${_selectedForDeletion.length})' : '갤러리'),
        backgroundColor: isDarkMode ? Colors.black87 : Colors.cyan,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        actions: [
          if (_isMultiSelectMode)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _removeSelectedImages,
              tooltip: '선택된 이미지 삭제',
            )
          else if (_selectedImages.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.cloud_upload),
              onPressed: _uploadImages,
              tooltip: '이미지 업로드',
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.black, Colors.grey[900]!]
                : [Colors.white, Colors.teal[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // 헤더: 이미지 수 표시 및 추가 버튼
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '선택된 이미지: ${_selectedImages.length} / $_maxImages',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _pickImages,
                    icon: const Icon(Icons.photo_library),
                    label: const Text('추가'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.tealAccent : Colors.cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 이미지 그리드 또는 Empty State
            Expanded(
              child: _selectedImages.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo_library_outlined,
                      size: 100,
                      color: isDarkMode ? Colors.white30 : Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '이미지를 선택해주세요.',
                      style: TextStyle(
                        fontSize: 18,
                        color: isDarkMode ? Colors.white70 : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              )
                  : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: _selectedImages.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedForDeletion.contains(index);
                  return GestureDetector(
                    onLongPress: () {
                      setState(() {
                        _isMultiSelectMode = true;
                        _toggleMultiSelect(index);
                      });
                    },
                    onTap: _isMultiSelectMode
                        ? () => _toggleMultiSelect(index)
                        : () => _showFullImage(_selectedImages[index]),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: isSelected
                                ? Border.all(color: Colors.redAccent, width: 3)
                                : null,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _selectedImages[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                        if (isSelected)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.redAccent,
                              size: 24,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
