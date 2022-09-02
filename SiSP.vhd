--------------------------------------------------
-- Author        : Sabri Challouf               --
-- Creation date : 23 - 10 - 2016               --
--                                              --
-- File description:  This file contains this   --
-- file contains the assembly of the two        --
-- subcomponents SiSP-Core and LCLK-Manager     -- 
-- which contain the implementation of SiSP     --
--------------------------------------------------

LIBRARY 	IEEE;
USE 		IEEE.STD_LOGIC_1164.ALL;
USE 		IEEE.STD_LOGIC_UNSIGNED.ALL;
USE 		IEEE.STD_LOGIC_ARITH.ALL;
USE 		IEEE.NUMERIC_STD.ALL;
USE 		IEEE.NUMERIC_BIT .ALL;
USE		WORK.SiSP_Tools.ALL;

	

ENTITY SiSP IS
	 
	 PORT ( SiSP_Clock    	: IN  	STD_LOGIC    ;  ----> Local clock
		SiSP_Rclk_In  	: IN  	SiSP_Vector  ;  ----> Recieved clock from another mote
		SiSP_Sclk_Out 	: OUT 	SiSP_Vector );  ----> Broadcasted clock
		  
END SiSP; 

 
ARCHITECTURE ARCH_SiSP OF SiSP IS
	SIGNAL 	Broadcast_Wire 	: STD_LOGIC ;
	-- Component 1 --
	COMPONENT SiSP_Body 	PORT (	SBY_Clock	:IN	STD_LOGIC	; 
					SBY_Rclk_in 	:IN	SiSP_Vector	;	                    
					SBY_Sclk_out	:OUT	SiSP_Vector	;	
					SBY_Broadcast_In:OUT	STD_LOGIC	);
	END COMPONENT;
	-- Component 2 --
	COMPONENT Lclk_Manager 	PORT (	LCLK_Clock		:IN	STD_LOGIC	;
					LCLK_Broadcast_Out	:OUT	STD_LOGIC	); 	
	END COMPONENT;
BEGIN
	SISP_LCLK_Manager : ENTITY WORK.Lclk_Manager	PORT MAP (	LCLK_Clock 		=> 	SiSP_Clock,
									LCLK_Broadcast_Out 	=> 	Broadcast_Wire	);															
	SISP_Core: ENTITY WORK.SiSP_Body	PORT MAP (	SBY_Clock	=> 	SiSP_Clock,
								SBY_Rclk_in	=> 	SiSP_Rclk_In, 
								SBY_Sclk_out	=> 	SiSP_Sclk_Out,
								SBY_Broadcast_In=> 	Broadcast_Wire);
END ARCH_SiSP ; 

