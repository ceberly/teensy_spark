with System;
with System.Machine_Code; use System.Machine_Code;

package body Watchdog is
   type U16 is mod 2**16;
   type Registers is limited record
      Stctrlh : U16;
      Stctrll : U16;
      Tovalh  : U16;
      Tovall  : U16;
      Winh    : U16;
      Winl    : U16;
      Refresh : U16;
      Unlock  : U16;
      Tmrouth : U16;
      Tmroutl : U16;
      Rstcnt  : U16;
      Presc   : U16;
   end record with
      Volatile;

   for Registers use record
      Stctrlh at  0 range 0 .. 31;
      Stctrll at  4 range 0 .. 31;
      Tovalh  at  8 range 0 .. 31;
      Tovall  at 12 range 0 .. 31;
      Winh    at 16 range 0 .. 31;
      Winl    at 20 range 0 .. 31;
      Refresh at 24 range 0 .. 31;
      Unlock  at 28 range 0 .. 31;
      Tmrouth at 32 range 0 .. 31;
      Tmroutl at 36 range 0 .. 31;
      Rstcnt  at 40 range 0 .. 31;
      Presc   at 44 range 0 .. 31;
   end record;

   W : Registers with
      Address => System'To_Address (16#4005_2000#);

   procedure Disable is
      C : U16 with
         Volatile => True;
   begin
      W.Unlock := 16#C520#;
      W.Unlock := 16#D928#;

      Asm ("NOP", Volatile => True);
      Asm ("NOP", Volatile => True);

      C := W.Stctrlh;
      C := C and 16#0000_0001#;

      W.Stctrlh := C;
   end Disable;
end Watchdog;
