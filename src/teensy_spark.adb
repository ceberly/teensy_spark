with Watchdog;

procedure Teensy_Spark is
begin
   Watchdog.Disable;

   loop
      null;
   end loop;
end Teensy_Spark;
