
import 'dart:math';
import 'dart:ui';

class THColor {

   static Color get random => Color.fromRGBO(255.random, 255.random, 255.random, 1);
   static Color get white => const Color(0xFFFFFFFF);
   static Color get black => const Color(0xFF000000);
   static Color get translucent => const Color(0x00000000);

   static Color get redFF596B => const Color(0xFFFF596B);
   static Color get orangeED702D => const Color(0xFFED702D);
   static Color get orangeFF6600 => const Color(0xFFFF6600);
   static Color get orangeAEAFB1 => const Color(0xFFaeafb1);

   static Color get blackE6000000 => const Color(0xE6000000);
   static Color get black99000000 => const Color(0x99000000);
   static Color get black66000000 => const Color(0x66000000);
   static Color get black42000000 => const Color(0x42000000);
   static Color get blackFF2A2A2A => const Color(0xFF2A2A2A);
   static Color get blackFF2E2E2E => const Color(0xFF2E2E2E);


   static Color get gray333333 => const Color(0xFF333333);
   static Color get grayCCCCCC => const Color(0xFFCCCCCC);
   static Color get grayFFFFFF => const Color(0xFF777777);
   static Color get grayA8A6A9 => const Color(0xFFA8A6A9);
   static Color get grayBBBBBB => const Color(0xffbbbbbb);
   static Color get grayE5E6E8 => const Color(0xFFE5E6E8);
   static Color get grayD9D9D9 => const Color(0xffD9D9D9);
   static Color get grayE7E7E7 => const Color(0xFFE7E7E7);
   static Color get grayEEEEEE => const Color(0xFFEEEEEE);
   static Color get grayF3F3F3 => const Color(0xFFF3F3F3);

   static Color get blue5E92F6 => const Color(0xFF5E92F6);

   static Color hex(int hex, {double alpha = 1}) {
      if (alpha < 0) {
         alpha = 0;
      } else if (alpha > 1) {
         alpha = 1;
      }
      return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8,
          (hex & 0x0000FF) >> 0, alpha);
   }

}

extension THInt on int {

  int get random => Random().nextInt(this);

}

