with System;

with Interfaces; use Interfaces;

package body Port is
   type Bit_Band_Member is array (Natural range 0 .. 31) of Unsigned_32 with
     Volatile_Components;

   type Bit_Band is limited record
      Pdor : Bit_Band_Member;
      Psor : Bit_Band_Member;
      Pcor : Bit_Band_Member;
      Ptor : Bit_Band_Member;
      Pdir : Bit_Band_Member;
      Pddr : Bit_Band_Member;
   end record with
     Volatile;

   Port_C_Pin5 : Unsigned_32 with
     Address => System'To_Address (16#4004_B014#), Import;

   GPIO_C : Bit_Band with
     Address => System'To_Address (16#43FE_1000#), Import;

   procedure Set_Pin_Mode is
      R    : Unsigned_32;
      Mode : Unsigned_32 := 1 and 16#0000_0007#;
   begin
      R := Port_C_Pin5;

      Mode := Shift_Left (Mode, 8);

      R := R and 16#FFFF_F8FF#;
      R := R or Mode;

      Port_C_Pin5 := R;
   end Set_Pin_Mode;

   procedure Setup is
   begin
      Set_Pin_Mode;
      GPIO_C.Pddr (5) := 1;
   end Setup;

   procedure Turn_On_Light is
   begin
      GPIO_C.Psor (5) := 1;
   end Turn_On_Light;

   procedure Turn_Off_Light is
   begin
      GPIO_C.Pcor (5) := 1;
   end Turn_Off_Light;
end Port;
