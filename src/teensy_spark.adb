with Watchdog;
with Sim;
with Port;

with System.Machine_Code; use System.Machine_Code;

procedure Teensy_Spark is
   --   replace this with Ada delay
   procedure Wait is
      I : Natural := 0 with Volatile => True;
   begin
      while I < 250000 loop
         Asm ("yield", Volatile => True);
         I := I + 1;
      end loop;
   end Wait;
begin
   Watchdog.Disable;
   Sim.Enable_Clock (Sim.Port_C);

   Port.Setup;

   loop
      Port.Turn_On_Light;
      Wait;
      Port.Turn_Off_Light;
      Wait;
   end loop;
end Teensy_Spark;
