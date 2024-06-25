

import 'dart:ui';

extension DTextStyle on double? {

  TextStyle? style(){
    return TextStyle(fontSize: this);
  }


}

extension CTextStyle on Color? {

  TextStyle style(){
    return TextStyle(color: this);
  }


}
