with Watchdog;
with Sim;

procedure Teensy_Spark is
begin
   Watchdog.Disable;
   Sim.Enable_Clock (Sim.Port_C);

   loop
      null;
   end loop;
end Teensy_Spark;
