import 'package:flutter/cupertino.dart';

import 'th_dropdown_menu.dart';
import 'th_dropdown_popup.dart';


class THDropdownInherited extends InheritedWidget {
  const THDropdownInherited({required Widget child, required this.popupState, required this.directionListenable, Key? key})
      : super(child: child, key: key);

  final THDropdownPopup popupState;
  final ValueNotifier<THDropdownMenuDirection> directionListenable;

  @override
  bool updateShouldNotify(covariant THDropdownInherited oldWidget) {
    return true;
  }

  static THDropdownInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<THDropdownInherited>();
  }
}
