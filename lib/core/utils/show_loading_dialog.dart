import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:telusur/core/resources/theme/colors.dart';
// import 'package:telusur/core/resources/theme/theme.dart';
// import 'package:telusur/core/utils/container/container.dart';

import 'widget/loading_indicator.dart';

class Dialogs {
  static Future<void> showErrorDialog(
      BuildContext context, String errorMessage) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                dismiss(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showLoadingDialog(BuildContext context,
      {String text = ""}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async => false,
          child: GestureDetector(
            onDoubleTap: () {
              // Debugging Escape
              if (kDebugMode || kProfileMode) Navigator.of(context).pop();
            },
            child: const Center(
              child: SizedBox(
                width: 170,
                height: 200,
                child: SimpleDialog(
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          // Text(
                          //   (text == "") ? "" : text,
                          //   style: AppTheme.subtitle.copyWith(
                          //     fontWeight: FontWeight.bold,
                          //     color: AppColors.colorWhite,
                          //   ),
                          // ).topPadded(10)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static show(BuildContext context, {bool? dismissible}) {
    return showGeneralDialog(
      context: context,
      barrierLabel: 'Barrier',
      barrierDismissible: kDebugMode,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: const PlatformLoadingIndicator(),
          ),
        );
      },
    );
  }

  static dismiss(BuildContext context) => Navigator.of(context).pop();
}
