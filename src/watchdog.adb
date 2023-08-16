with System;
with System.Machine_Code; use System.Machine_Code;

package body Watchdog with
   SPARK_Mode => On
is
   type U16 is mod 2**16;

   Unlock : U16 with
      Volatile => True,
      Address  => System'To_Address (16#4005_200E#);
   Stctrlh : U16 with
      Volatile => True,
      Address  => System'To_Address (16#4005_2000#);

   procedure Disable is
      C : U16;
   begin
      Unlock := 16#C520#;
      Unlock := 16#D928#;

      Asm ("NOP", Volatile => True);
      Asm ("NOP", Volatile => True);

      C       := Stctrlh;
      Stctrlh := C and not 16#0000_0001#;
   end Disable;
end Watchdog;
