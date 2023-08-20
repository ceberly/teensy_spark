package Port is
   type Port_Name is (C);
   type Pin_Control_Index is range 0 .. 32;

   procedure Turn_On_Light;
   procedure Turn_Off_Light;
   procedure Setup;
end Port;
