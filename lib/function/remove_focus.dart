import 'package:flutter/cupertino.dart';

void removeFocus(BuildContext context) {
  final currentScope = FocusScope.of(context);
  if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
    FocusManager.instance.primaryFocus.unfocus();
  }
}
