--------------------------------------------------
-- Author        : Sabri Challouf               --
-- Creation date : 23 - 10 - 2016               --
--                                              --
-- File description:                            --
--------------------------------------------------

LIBRARY 	IEEE;
USE 		IEEE.STD_LOGIC_1164.ALL;
USE 		IEEE.STD_LOGIC_UNSIGNED.ALL;
USE 		IEEE.NUMERIC_STD.ALL;
USE		WORK.SiSP_Tools.ALL;


ENTITY SiSP_Body IS

	PORT (
				SBY_Clock		:IN		STD_LOGIC		;
				SBY_Broadcast_In:IN		STD_LOGIC		;	
				SBY_Rclk_in  	:IN		SiSP_Vector		;	                    
				SBY_Sclk_out 	:OUT	SiSP_Vector		);	
				
			
	SHARED	VARIABLE  Sclk: SiSP_Vector	:=	Full_0		;
			
END SiSP_Body; 

 
ARCHITECTURE ARCH_SiSP_Body OF SiSP_Body IS
BEGIN		
								
	-- Update Sclk with Rclk_In  & Increment Sclk
	PROCESS(SBY_Clock , SBY_Rclk_in)
		VARIABLE  	Sclk_Temp 		: SiSP_Vector	:= Full_0	;
		VARIABLE	Edge_From_RclkIn: Boolean 		:= TRUE	 	;
	BEGIN		
	
		IF (SBY_Clock = '0')
		THEN	Edge_From_RclkIn 	:= TRUE	;
		ELSE	IF (rising_edge(SBY_Clock))
				THEN	IF (Sclk = Full_1) 
						THEN Sclk := Full_0		;
						ELSE Sclk := Sclk + 1	;
						END IF;
						Edge_From_RclkIn 	:= FALSE	;
				END IF;
		END IF;
				
				
		IF(Edge_From_RclkIn = TRUE)
		THEN	IF (SBY_Rclk_in /= Unknown) and (SBY_Rclk_in /= UnInit)
				THEN 	
					-- Calculate new shared sclk
					Sclk_Temp 	:= Sclk ;
					Sclk_Temp 	:= std_logic_vector(unsigned(Sclk_Temp) + unsigned(SBY_Rclk_in));
					Sclk_Temp 	:= std_logic_vector(to_unsigned(0,Sclk_Temp'length)) + Sclk_Temp(N-1 downto 1);
					Sclk 			:= Sclk_Temp ;
				END IF;
		END IF;
	
	END PROCESS;
		
	-- Broadcast Sclk
	PROCESS (SBY_Broadcast_In)
	BEGIN
			SBY_Sclk_out <= Sclk ;
	END PROCESS; 
	
END ARCH_SiSP_Body ; 
