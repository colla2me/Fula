import 'package:flutter/material.dart';

class SliverDoubanHeader extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final Widget child;

  SliverDoubanHeader({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(SliverDoubanHeader oldDelegate) {
    return minHeight != oldDelegate.minHeight ||
          maxHeight != oldDelegate.maxHeight ||
          child != oldDelegate.child;
  }
}
