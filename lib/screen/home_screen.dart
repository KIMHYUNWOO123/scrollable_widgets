import 'package:flutter/material.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';
import 'package:scrollable_widgets/screen/single_child_scroll_view_screen.dart';

import 'list_view_screen.dart';

class ScreenModel {
  final WidgetBuilder builder;
  final String name;

  ScreenModel({
    required this.builder,
    required this.name,
  });
}

class HomeScreen extends StatelessWidget {
  final screen = [
    ScreenModel(
        builder: (_) => SingleChildScrollViewScreen(),
        name: 'SingleChildViewScreen'),
    ScreenModel(
      builder: (_) => ListViewScreen(),
      name: 'ListViewScreen',
    ),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        title: 'Home',
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: screen
                .map((screen) => ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: screen.builder),
                      );
                    },
                    child: Text(screen.name)))
                .toList(),
          ),
        ));
  }
}