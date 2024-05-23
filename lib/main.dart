import 'package:flutter/material.dart';
import 'package:flutter_image_search/data/repository/pixabay_repository_impl.dart';
import 'package:flutter_image_search/di/di_setup.dart';
import 'package:flutter_image_search/presentation/pixabay/pixabay_screen.dart';
import 'package:flutter_image_search/presentation/pixabay/pixabay_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  diSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (_) => PixabayViewModel(repository: PixabayRepositoryImpl()),
        child: PixabayScreen(),
      )
    );
  }
}


