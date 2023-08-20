with System;
with Interfaces; use Interfaces;

package body Sim with
   SPARK_Mode => On
is
   --   This is the only register we care about so we don't need to type out
   --   the whole record;
   Scgc5 : Unsigned_32 with
      Address => System'To_Address (16#4004_8038#), Import;

   procedure Enable_Clock (C : Clock) is
      S : Unsigned_32;
   begin
      case C is
         when Port_C =>
            S     := Scgc5;
            Scgc5 := S or 16#0000_0800#;
      end case;
   end Enable_Clock;
end Sim;
