--------------------------------------------------
-- Author        : Sabri Challouf               --
-- Creation date : 23 - 10 - 2016               --
--                                              --
-- File description:                            --
-- This LCLK entity hase 2 jobs :               --
--      + Increment local clock (LCLK)          --  
--      + Send BroadCast signal every 100 edge  --
--------------------------------------------------

LIBRARY 	IEEE;
USE 		IEEE.STD_LOGIC_1164.ALL;
USE 		IEEE.STD_LOGIC_ARITH.ALL;
USE		IEEE.STD_LOGIC_UNSIGNED.ALL;
USE		work.SiSP_Tools.ALL;

ENTITY Lclk_Manager IS
   
	PORT( 	LCLK_Clock						: IN	STD_LOGIC;
			LCLK_Broadcast_Out				: OUT 	STD_LOGIC := '0');
				
	SHARED	VARIABLE  Lclk 					: 		SiSP_Vector :=	Full_0;
	
END Lclk_Manager;
 
 
 
ARCHITECTURE Lclk_Manager_Behavior OF Lclk_Manager IS
	SIGNAL Out_Broadcast : STD_LOGIC := '0';
BEGIN   

	PROCESS(LCLK_Clock)
		BEGIN

			IF (rising_edge(LCLK_Clock)) 
			THEN 	Lclk := Lclk + 1;
					IF (conv_integer(Lclk) mod 99) = 0  -- a changer
					THEN
							-- Generate and edge (1 or 0) to the SisP_Body to broadcast the sclk.
							
								Out_Broadcast <= not Out_Broadcast ; 
								Lclk := Full_0;
					END IF;
					
					LCLK_Broadcast_Out <= Out_Broadcast ; 
					
			END IF;
			
	END PROCESS;
   
END Lclk_Manager_Behavior;