import 'package:flutter/widgets.dart';

extension SizeExtension on BuildContext {
  MediaQueryData get iMediaQuery => MediaQuery.of(this);
  Size get iSize => MediaQuery.of(this).size;
}
