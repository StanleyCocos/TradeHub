
import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

class THColor {

   static Color get random => Color.fromRGBO(255.random, 255.random, 255.random, 1);

}

extension THInt on int {

  int get random => Random().nextInt(this);

}

