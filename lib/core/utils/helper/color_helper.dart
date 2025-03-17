import 'package:flutter/material.dart';
import 'package:univs/core/resources/theme/colors.dart';

class ColorHelper {
  static Color categoryColorHelper(String categoryName) {
    switch (categoryName) {
      case 'VIP':
        return AppColors.colorYellow2;
      case 'Critical':
        return AppColors.colorRed;
      case 'High':
        return const Color(0xffFF5757);
      case 'Medium':
        return AppColors.colorYellow2;
      case 'Low':
        return AppColors.colorSecondary;
      default:
        return Colors.grey;
    }
  }

  static Color statusColorHelper(bool isAvalilable) {
    switch (isAvalilable) {
      case true:
        return AppColors.colorGreen;
      default:
        return Colors.grey;
    }
  }

  static Color statusStepperColor(bool isDone) {
    switch (isDone) {
      case true:
        return AppColors.primaryColor;
      default:
        return AppColors.colorSecondary;
    }
  }

  static Color colorWorkStatus(String status) {
    switch (status) {
      case 'UNASSIGNED':
        return AppColors.colorGrey2;
      case 'ASSIGNED':
        return AppColors.colorGrey2;
      case 'WORK_STARTED':
        return AppColors.colorGreen;
      case 'PENDING':
        return AppColors.colorYellow;
      case 'CANCELLED':
        return AppColors.colorRed;
      case 'WORK_FINISHED':
        return AppColors.colorGreen;
      default:
        return Colors.grey;
    }
  }
}
