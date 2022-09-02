--------------------------------------------------
-- Author        : Sabri Challouf               --
-- Creation date : 23 - 10 - 2016               --
--                                              --
-- File description: This file contains some 	--
-- declarations used on the hardware 		--
-- implemntation of the SiSP                    --
--------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


-- Package declaration
PACKAGE SiSP_Tools IS
	CONSTANT N : POSITIVE := 8;
	
	SUBTYPE SiSP_Vector is std_logic_vector(N-1 downto 0) ;
	TYPE  std_logic_array_vector IS ARRAY ( NATURAL RANGE <>) OF SiSP_Vector;
	
	CONSTANT	UnInit	:	SiSP_Vector:=(others => 'U');
	CONSTANT 	Unknown	: 	SiSP_Vector:=(others => 'X');
	CONSTANT 	Full_0	: 	SiSP_Vector:=(others => '0');
	CONSTANT 	Full_1	: 	SiSP_Vector:=(others => '1');
	
	FUNCTION resolved_vector ( sources : std_logic_array_vector) RETURN SiSP_Vector;
END PACKAGE SiSP_Tools;



--Package Implementation
PACKAGE BODY SiSP_Tools IS
	FUNCTION resolved_vector ( sources : std_logic_array_vector ) RETURN SiSP_Vector IS
	VARIABLE result : SiSP_Vector; -- weakest state default
	BEGIN
		IF (sources'LENGTH = 1) THEN RETURN sources(sources'LOW);
		ELSE
			FOR i IN sources'RANGE LOOP
				result := std_logic_vector(to_unsigned(2 ** (i - (sources'LENGTH + 1)),N) * unsigned(sources(i)));
			END LOOP;
			--result := result + sclk / (2 ** (sources'LENGTH + 1));
		END IF;
		RETURN result;
	END resolved_vector;
END PACKAGE BODY SiSP_Tools;
