import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderSliverAppBar(),
          SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: _SliverFixedHeaderDelegate(
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      '신기하지',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                maxHeight: 150,
                minHeight: 100,
              )),
          renderBuilderSliverList(),
          renderSliverGridBuilder(),
          renderBuilderSliverList()
        ],
      ),
    );
  }

  SliverAppBar renderSliverAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: true,
      stretch: false,
      expandedHeight: 200,
      collapsedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('FlexibleSpace'),
      ),
      title: Text('CustomScrollViewScreen'),
    );
  }

  SliverGrid renderSliverGridBuilder() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 100,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
    );
  }

  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(numbers
          .map(
            (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e),
          )
          .toList()),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  SliverList renderBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return renderContainer(
            color: rainbowColors[index % rainbowColors.length], index: index);
      }, childCount: 10),
    );
  }

  SliverList renderChildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(numbers
          .map(
            (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e),
          )
          .toList()),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    return Container(
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
