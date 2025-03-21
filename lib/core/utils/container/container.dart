import 'package:flutter/material.dart';

class LeftAlignedColumn extends StatelessWidget {
  final List<Widget> children;

  const LeftAlignedColumn({
    super.key,
    required this.children,
  });

  @override
  Widget build(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

class CenterAlignedColumn extends StatelessWidget {
  final List<Widget> children;

  const CenterAlignedColumn({
    super.key,
    required this.children,
  });

  @override
  Widget build(context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
}

class RightAlignedColumn extends StatelessWidget {
  final List<Widget> children;

  const RightAlignedColumn({
    super.key,
    required this.children,
  });

  @override
  Widget build(context) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
}

class LeftAlignedRow extends StatelessWidget {
  final List<Widget> children;

  const LeftAlignedRow({
    super.key,
    required this.children,
  });

  @override
  Widget build(context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
}

class RightAlignedRow extends StatelessWidget {
  final List<Widget> children;

  const RightAlignedRow({
    super.key,
    required this.children,
  });

  @override
  Widget build(context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
}

class CenterAlignedRow extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;

  final List<Widget> children;

  const CenterAlignedRow({
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.children,
  });

  @override
  Widget build(context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
}

class SideToSideRow extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;

  final Widget left;

  final Widget right;

  const SideToSideRow({
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    required this.left,
    required this.right,
  });

  @override
  Widget build(context) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          left,
          right,
        ],
      );
}

extension PaddedWidget on Widget {
  Widget topPadded4([final value = const EdgeInsets.only(top: 4)]) => Padding(
        padding: value,
        child: this,
      );
  Widget topPadded12([final value = const EdgeInsets.only(top: 12)]) => Padding(
        padding: value,
        child: this,
      );

  Widget topPadded16([final value = const EdgeInsets.only(top: 16)]) => Padding(
        padding: value,
        child: this,
      );

  Widget topPadded20([final value = const EdgeInsets.only(top: 20)]) => Padding(
        padding: value,
        child: this,
      );

  Widget topPadded30([final value = const EdgeInsets.only(top: 30)]) => Padding(
        padding: value,
        child: this,
      );

  Widget bottomPadded24([final value = const EdgeInsets.only(bottom: 24)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget bottomPadded20([final value = const EdgeInsets.only(bottom: 20)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget bottomPadded16([final value = const EdgeInsets.only(bottom: 16)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget bottomPadded12([final value = const EdgeInsets.only(bottom: 12)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget bottomPadded8([final value = const EdgeInsets.only(bottom: 8)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget bottomPadded4([final value = const EdgeInsets.only(bottom: 4)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget bottomPadded6([final value = const EdgeInsets.only(bottom: 6)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget bottomPadded2([final value = const EdgeInsets.only(bottom: 2)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget padded16([final value = const EdgeInsets.all(16)]) => Padding(
        padding: value,
        child: this,
      );

  Widget verticalpadded16(
          [final value = const EdgeInsets.symmetric(vertical: 16)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget horizontalpadded16(
          [final value = const EdgeInsets.symmetric(horizontal: 16)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget withoutTopPadded16(
          [final value = const EdgeInsets.only(
            bottom: 16,
            left: 16,
            right: 16,
          )]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget padded8([final value = const EdgeInsets.all(8)]) => Padding(
        padding: value,
        child: this,
      );

  Widget leftPadded16([final value = const EdgeInsets.only(left: 16)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget leftPadded14([final value = const EdgeInsets.only(left: 14)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget leftPadded8([final value = const EdgeInsets.only(left: 8)]) => Padding(
        padding: value,
        child: this,
      );

  Widget leftPadded4([final value = const EdgeInsets.only(left: 4)]) => Padding(
        padding: value,
        child: this,
      );

  Widget rightPadded14([final value = const EdgeInsets.only(right: 14)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget rightPadded12([final value = const EdgeInsets.only(right: 12)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget rightPadded16([final value = const EdgeInsets.only(right: 16)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget rightPadded10([final value = const EdgeInsets.only(right: 10)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget rightPadded8([final value = const EdgeInsets.only(right: 8)]) =>
      Padding(
        padding: value,
        child: this,
      );
  Widget rightPadded4([final value = const EdgeInsets.only(right: 4)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget rightPadded6([final value = const EdgeInsets.only(right: 6)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget sliderPadded20(
          [final value = const EdgeInsets.only(right: 20, left: 20)]) =>
      Padding(
        padding: value,
        child: this,
      );

  Widget padded([final value = 16]) => Padding(
        padding: EdgeInsets.all(value.toDouble()),
        child: this,
      );

  Widget paddedWithoutBottom([final value = 16]) => Padding(
        padding: EdgeInsets.only(
            left: value.toDouble(),
            right: value.toDouble(),
            top: value.toDouble()),
        child: this,
      );

  Widget paddedLTRB(
          {double left = 16,
          double top = 16,
          double right = 16,
          double bottom = 16}) =>
      Padding(
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: this,
      );

  Widget topPadded([final value = 16]) => Padding(
        padding: EdgeInsets.only(top: value.toDouble()),
        child: this,
      );

  Widget bottomPadded([final value = 16]) => Padding(
        padding: EdgeInsets.only(bottom: value.toDouble()),
        child: this,
      );

  Widget leftPadded([final value = 16]) => Padding(
        padding: EdgeInsets.only(left: value.toDouble()),
        child: this,
      );

  Widget rightPadded([final value = 16]) => Padding(
        padding: EdgeInsets.only(right: value.toDouble()),
        child: this,
      );

  Widget horizontalPadded([final value = 16]) => Padding(
        padding: EdgeInsets.symmetric(horizontal: value.toDouble()),
        child: this,
      );

  Widget verticalPadded([final value = 16]) => Padding(
        padding: EdgeInsets.symmetric(vertical: value.toDouble()),
        child: this,
      );
}
