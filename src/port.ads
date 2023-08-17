with Types; use Types;

package Port is
   type Port_Name is (C);
   type Pin_Control_Index is range 0 .. 32;

   procedure Set_Pin_Mode (P : Pin_Control_Index; Mode : U32);

   procedure Turn_On_Light;
end Port;
