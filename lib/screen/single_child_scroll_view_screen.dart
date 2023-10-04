import 'package:flutter/material.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

import '../const/colors.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  SingleChildScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'SingleChildScollViewScreen',
      body: SingleChildScrollView(
        child: Column(
          children: numbers
              .map(
                (e) => renderContainer(
                  color: rainbowColors[e % rainbowColors.length],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    int? index,
  }) {
    if(index != null) {
    }
    return Container(
      height: 300,
      color: color,
    );
  }

  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors.map((e) => renderContainer(color: e)).toList(),
      ),
    );
  }

  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [renderContainer(color: Colors.black)],
      ),
    );
  }

  Widget renderClip() {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [renderContainer(color: Colors.black)],
      ),
    );
  }
}
