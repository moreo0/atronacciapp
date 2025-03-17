// ignore_for_file: use_super_parameters

import 'dart:async';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:univs/core/resources/theme/colors.dart';
import 'package:univs/core/utils/text/text_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Future<void> showSheet(
  BuildContext ctx,
  Widget sheet, {
  bool isControlled = true,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isDismissible: isControlled,
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: sheet,
    ),
    context: ctx,
    isScrollControlled: isControlled,
    enableDrag: isControlled,
  );
}

void showAlert(
  BuildContext ctx, {
  bool isControlled = true,
  required String text,
  required VoidCallback yes,
}) {
  showDialog<void>(
    context: ctx,
    barrierDismissible: isControlled,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const TextBold(
          'Confirm',
          alignment: TextAlign.left,
        ),
        content: TextMedium(text),
        actions: <Widget>[
          TextButton(
            child: const TextBold('No'),
            onPressed: () {
              // ignore: deprecated_member_use
              ctx.router.pop();
            },
          ),
          TextButton(
            onPressed: yes,
            child: const TextBold('Yes'),
          ),
        ],
      );
    },
  );
}

class BottomDrawer extends StatelessWidget {
  final Widget child;
  final bool withBack;

  const BottomDrawer({
    Key? key,
    required this.child,
    this.withBack = false,
  }) : super(key: key);

  @override
  Widget build(context) {
    return withBack
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: _backButton(context),
              ),
              _main(),
            ],
          )
        : _main();
  }

  Widget _main() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: child,
    );
  }

  Widget _backButton(BuildContext ctx) {
    return ElevatedButton(
      onPressed: () => Navigator.of(ctx).pop(),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
      ),
      child: const Icon(Icons.arrow_back_ios),
    );
  }
}

Widget loader() {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
    child: Container(
      color: Colors.grey[200]!.withOpacity(0.4),
      child: const Center(
        child: SpinKitThreeBounce(
          color: AppColors.primaryColor,
        ),
      ),
    ),
  );
}

class Loadable extends StatefulWidget {
  final Widget? action;
  final Function()? onRefresh;
  final RefreshController? refreshController;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Widget child;
  final Widget? extra;
  final Widget? floatingActionButton;
  final bool loading;
  final bool safeTop;
  final bool extendBodyBehindAppBar;

  const Loadable({
    Key? key,
    this.action,
    this.appBar,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.bottomSheet,
    required this.child,
    this.extra,
    this.floatingActionButton,
    this.loading = false,
    this.safeTop = true,
    this.extendBodyBehindAppBar = false,
    this.onRefresh,
    this.refreshController,
  }) : super(key: key);

  @override
  createState() => _State();
}

class _State extends State<Loadable> {
  @override
  Widget build(context) {
    return widget.refreshController != null
        ? MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: SmartRefresher(
              controller: widget.refreshController ??
                  RefreshController(initialRefresh: false),
              enablePullUp: true,
              onRefresh: () {
                widget.refreshController?.refreshCompleted();
                widget.refreshController?.loadComplete();
                widget.onRefresh?.call();
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Scaffold(
                    appBar: widget.appBar,
                    backgroundColor: widget.backgroundColor,
                    extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
                    body: Stack(
                      fit: StackFit.expand,
                      children: [
                        widget.child,
                        if (widget.extra != null) widget.extra!,
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: widget.bottomSheet ?? const SizedBox()),
                      ],
                    ),
                    bottomNavigationBar: widget.bottomNavigationBar,
                    floatingActionButton: widget.floatingActionButton,
                  ),
                  if (widget.loading) loader(),
                ],
              ),
            ),
          )
        : MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Scaffold(
                  appBar: widget.appBar,
                  backgroundColor: widget.backgroundColor,
                  extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
                  body: Stack(
                    fit: StackFit.expand,
                    children: [
                      widget.child,
                      if (widget.extra != null) widget.extra!,
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: widget.bottomSheet ?? const SizedBox()),
                    ],
                  ),
                  bottomNavigationBar: widget.bottomNavigationBar,
                  floatingActionButton: widget.floatingActionButton,
                ),
                if (widget.loading) loader(),
              ],
            ),
          );
  }
}

class GenericButton extends StatelessWidget {
  final VoidCallback ontap;
  final bool disable;
  final String text;
  final Color color;

  const GenericButton(
    this.text, {
    super.key,
    required this.ontap,
    this.disable = false,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: !disable ? ontap : null,
      child: Ink(
        decoration: BoxDecoration(
          color: !disable ? color : AppColors.colorGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: !disable
              ? TextBold(
                  text,
                  alignment: TextAlign.center,
                )
              : TextMedium(
                  text,
                  alignment: TextAlign.center,
                ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback ontap;
  final bool disable;
  final Color? color;
  final Widget? child;
  final double radius;

  const CustomButton({
    super.key,
    required this.ontap,
    this.disable = false,
    this.color,
    this.child,
    this.radius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: !disable ? ontap : null,
      child: Ink(
        decoration: BoxDecoration(
          color: !disable
              ? (color ?? AppColors.colorBlueFacebook)
              : AppColors.colorGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
      ),
    );
  }
}

class BackAppBar extends AppBar {
  BackAppBar(BuildContext ctx, String text,
      {Key? key,
      List<Widget> actions = const [],
      PreferredSizeWidget? bottom,
      bool forceBack = false,
      bool center = false,
      double? elevation,
      Color? backgroundColor,
      Future<bool> Function()? onWillPop})
      : super(
          key: key,
          actions: actions,
          bottom: bottom,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark),
          centerTitle: center,
          leading: (ModalRoute.of(ctx)?.canPop ?? false) || forceBack
              // ignore: deprecated_member_use
              ? WillPopScope(
                  onWillPop: onWillPop,
                  child: const AutoLeadingButton(color: Colors.black))
              : null,
          title: TextBold(
            text,
            fontSize: 12,
          ),
          elevation: elevation,
          backgroundColor: backgroundColor,
        );
}

class Spinner<T> extends StatelessWidget {
  final bool autofocus;
  final bool dense;
  final String? helperText;
  final String? hintText;
  final List<DropdownMenuItem<T>> items;
  final String? label;
  final ValueChanged<T?>? onChanged;
  final FormFieldSetter<T>? onSaved;
  final FormFieldValidator<T>? validator;
  final T? value;
  final bool isExpanded;

  const Spinner({
    Key? key,
    this.autofocus = false,
    this.dense = false,
    this.helperText,
    this.hintText,
    this.items = const [],
    this.label,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.value,
    this.isExpanded = true,
  }) : super(key: key);

  @override
  Widget build(context) {
    return DropdownButtonFormField(
      autofocus: autofocus,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        contentPadding: dense ? const EdgeInsets.fromLTRB(12, 9, 12, 10) : null,
        helperMaxLines: 3,
        helperText: helperText,
        hintText: hintText,
        isDense: dense,
        filled: true,
      ),
      items: items,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      value: value,
      isExpanded: isExpanded,
    );
  }
}
