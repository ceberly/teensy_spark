with System;

package body Sim with
   SPARK_Mode => On
is
   type U32 is mod 2**32;

   --   This is the only register we care about so we don't need to type out
   --   the whole record;
   Scgc5 : U32 with
      Address => System'To_Address (16#4004_8038#),
      Volatile;

   procedure Enable_Clock (C : Clock) is
      S : U32;
   begin
      case C is
         when Port_C =>
            S     := Scgc5;
            Scgc5 := S or 16#0000_0800#;
      end case;
   end Enable_Clock;
end Sim;
