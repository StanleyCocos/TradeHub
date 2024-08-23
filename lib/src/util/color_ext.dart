
import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

class THColor {

   static Color get random => Color.fromRGBO(255.random, 255.random, 255.random, 1);
   static Color get white => const Color(0xFFFFFFFF);

   static Color get redFF596B => const Color(0xFFFF596B);
   static Color get orangeED702D => const Color(0xFFED702D);

   static Color get gray333333 => const Color(0xFF333333);
   static Color get grayCCCCCC => const Color(0xFFCCCCCC);
   static Color get grayA8A6A9 => const Color(0xFFA8A6A9);
   static Color get grayBBBBBB => const Color(0xffbbbbbb);
   static Color get grayE5E6E8 => const Color(0xFFE5E6E8);
   static Color get grayD9D9D9 => const Color(0xffD9D9D9);
   static Color get grayE7E7E7 => const Color(0xFFE7E7E7);

   static Color get blue5E92F6 => const Color(0xFF5E92F6);
}

extension THInt on int {

  int get random => Random().nextInt(this);

}

