with System;
with System.Machine_Code; use System.Machine_Code;
with Interfaces;          use Interfaces;

package body Watchdog with
  SPARK_Mode => On
is
   Unlock : Unsigned_16 with
     Volatile => True, Address => System'To_Address (16#4005_200E#);

   Stctrlh : Unsigned_16 with
     Volatile => True, Address => System'To_Address (16#4005_2000#);

   procedure Disable is
      C : Unsigned_16;
   begin
      Unlock := 16#C520#;
      Unlock := 16#D928#;

      Asm ("nop", Volatile => True);
      Asm ("nop", Volatile => True);

      C       := Stctrlh;
      Stctrlh := C and not 16#0000_0001#;
   end Disable;
end Watchdog;
