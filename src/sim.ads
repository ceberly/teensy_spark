package Sim with
   SPARK_Mode => On
is
   type Clock is (Port_C);

   procedure Enable_Clock (C : Clock);
end Sim;
