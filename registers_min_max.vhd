----------------------------------------------------------------------------------

-- Company: 

-- Engineer: 

-- 

-- Create Date:    18:45:02 11/06/2021 

-- Design Name: 

-- Module Name:    registers_min_max - Behavioral 

-- Project Name: 

-- Target Devices: 

-- Tool versions: 

-- Description: 

--

-- Dependencies: 

--

-- Revision: 

-- Revision 0.01 - File Created

-- Additional Comments: 

--

----------------------------------------------------------------------------------

library IEEE;

use IEEE.STD_LOGIC_1164.ALL;



-- Uncomment the following library declaration if using

-- arithmetic functions with Signed or Unsigned values

--use IEEE.NUMERIC_STD.ALL;



-- Uncomment the following library declaration if instantiating

-- any Xilinx primitives in this code.

--library UNISIM;

--use UNISIM.VComponents.all;



entity registers_min_max is

port( 

din	: in std_logic_vector(3 downto 0);  

reset : in std_logic; 

clk	: in std_logic;

sel	: in std_logic_vector(1 downto 0);   

MAX_OUT : out std_logic_vector(3 downto 0);  

MIN_OUT : out std_logic_vector(3 downto 0);  

reg_out : out std_logic_vector(3 downto 0));   

end registers_min_max ;





architecture Behavioral of registers_min_max is



	  signal  R0,R1,R2,R3: std_logic_vector (3 downto 0):="1000";
          signal  max_reg :std_logic_vector (3 downto 0):="0000";
          signal min_reg:std_logic_vector (3 downto 0):="1111";
	  signal   max_temp, min_temp : std_logic_vector (3 downto 0);

begin







combinational: process (sel,R0, R1,R2,R3,min_temp,max_temp) is
begin 
		
		
		
			if (R0>R1 and  R0>R2 and R0>R3 and   R0 > max_temp ) then

					max_temp<=R0; 
				

				elsif (R1>R0 and R1>R2 and R1>R3 and  R1> max_temp) then

					max_temp<=R1;
		

				elsif (R2>R0 and R2>R1 and R2>R3  and R2> max_temp) then

					max_temp<=R2;
					
				elsif (R3>R0 and R3>R1 and R3>R2 and R3> max_temp) then

					max_temp<=R3;
					
                 else 
                 max_temp<=max_temp;
				

				end if;
				

			



------- minimum combination logic --------------



				

			if (R0<R1 and R0<R2 and R0<R3  and R0<min_temp) then

					min_temp<=R0;
					

				elsif (R1<R0 and R1<R2 and R1<R3 and R1<min_temp ) then

					min_temp<=R1;

				elsif (R2<R0 and R2<R1 and R2<R3 and R2<min_temp) then

					min_temp<=R2;

				elsif (R3<R0 and R3<R1 and R3<R2  and R3<min_temp ) then

					min_temp<=R3;
				else 
				min_temp<=min_temp;

				end if;

			
		case (sel) is
			
			when "11" => reg_out<= R3;
                        when "10" => reg_out<= R2;
                        when "01" => reg_out<= R1;
                        when others => reg_out<= R0;
			
		end case; 
end process combinational; 


shift_register_min_max: process(clk, reset)
begin

if(reset = '1') then
-- reset the registers 

            R0 <= "1000";

			R1 <= "1000";

			R2 <= "1000";

			R3 <= "1000";

-- reset the DFF

         max_reg <= "0000";

         min_reg <= "1111";

 

elsif(rising_edge(clk)) then

R0<=din;

R1 <= R0;
R2<=R1;

R3<=R2;

--for the max_reg

      if( max_temp > max_reg) then

      max_reg<=max_temp;
      else 
       max_reg<=max_reg; 
      end if;
--for the min_reg

      if(min_temp < min_reg) then

      min_reg<=min_temp; 
      
      else 
     
      min_reg<=min_reg; 

      end if;

end if;
end process shift_register_min_max ;


	  -- output the results in the LEDS
max_out <= max_reg;

min_out <= min_reg;







end Behavioral;



