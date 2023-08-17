with System;

with Interfaces; use Interfaces;

package body Port is
   type Pcr_Type is array (Pin_Control_Index'Range) of Unsigned_32 with
      Volatile_Components;

   type Port_Repr is limited record
      Pcr : Pcr_Type;
   end record with
      Volatile;

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

   Port_C : Port_Repr with
      Address => System'To_Address (16#4004_B000#),
      Import;

   GPIO_C : Bit_Band with
      Address => System'To_Address (16#43FE_1000#),
      Import;

   procedure Set_Pin_Mode (P : Pin_Control_Index; Mode : Unsigned_32) is
      R : Unsigned_32;
   begin
      R := Port_C.Pcr (P);
      R := R and 16#FFFF_F8FF#;

      R := R or Shift_Left (Mode and 16#0000_0007#, 8);

      Port_C.Pcr (P) := R;
   end Set_Pin_Mode;

   procedure Turn_On_Light is
   begin
      Set_Pin_Mode (5, 1);
      GPIO_C.Pddr (5) := 1;
      GPIO_C.Psor (5) := 1;
   end Turn_On_Light;
end Port;
