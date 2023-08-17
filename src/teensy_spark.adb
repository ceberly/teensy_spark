with Watchdog;
with Sim;
with Port;

procedure Teensy_Spark is
begin
   Watchdog.Disable;
   Sim.Enable_Clock (Sim.Port_C);

   Port.Turn_On_Light;

   loop
      null;
   end loop;
end Teensy_Spark;
