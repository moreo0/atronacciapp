// import 'package:flutter/material.dart';
// import 'package:pgnpartner_mobile/core/utils/widget/dialog_widget.dart';

import 'package:flutter/material.dart';
import 'package:univs/core/resources/theme/colors.dart';
import 'package:univs/core/utils/container/container.dart';
import 'package:univs/core/utils/text/text_util.dart';

class BottomSheetHelper {
  static void showBottomConfirmationSheet(
    BuildContext context, {
    required String title,
    required String message,
    bool isSuccess = false,
    bool canceledButton = false,
    required VoidCallback? onConfirm,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                isSuccess ? Icons.check_circle : Icons.warning_outlined,
                color: isSuccess ? Colors.green : Colors.red,
                size: 48.0,
              ),
              const SizedBox(height: 16.0),
              TextBold(
                title,
                fontSize: 16.0,
              ),
              const SizedBox(height: 16.0),
              TextMedium(
                message,
                fontSize: 14.0,
              ),
              const SizedBox(height: 32.0),
              Row(
                children: [
                  canceledButton
                      ? Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: AppColors.colorRed,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                  color: AppColors.colorGrey.withOpacity(.4),
                                ),
                              ),
                              child: TextMedium("Batalkan",
                                  color: AppColors.colorWhite,
                                  alignment: TextAlign.center),
                            ),
                          ).rightPadded(4),
                        )
                      : const SizedBox(),
                  Expanded(
                    child: GestureDetector(
                      onTap: onConfirm ?? () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.colorSecondary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: AppColors.colorGrey.withOpacity(.4),
                          ),
                        ),
                        child: TextMedium("OK",
                            color: AppColors.colorWhite,
                            alignment: TextAlign.center),
                      ),
                    ).leftPadded(4),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
