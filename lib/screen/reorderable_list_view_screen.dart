import 'package:flutter/material.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

import '../const/colors.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({super.key});

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ReorderableListViewScreen',
      body: ReorderableListView.builder(
          itemBuilder: (context, index) {
            return renderContainer(
                color: rainbowColors[numbers[index] % rainbowColors.length],
                index: numbers[index]);
          },
          itemCount: numbers.length,
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }

              final item = numbers.removeAt(oldIndex);
              numbers.insert(newIndex, item);
            });
          }),
    );
  }

  Widget renderBuilder() {
    return ReorderableListView.builder(
        itemBuilder: (context, index) {
          return renderContainer(
              color: rainbowColors[numbers[index] % rainbowColors.length],
              index: numbers[index]);
        },
        itemCount: numbers.length,
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            final item = numbers.removeAt(oldIndex);
            numbers.insert(newIndex, item);
          });
        });
  }

  Widget renderDefault() {
    return ReorderableListView(
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
      },
      children: numbers
          .map((e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length], index: e))
          .toList(),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    return Container(
      key: Key(index.toString()),
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
