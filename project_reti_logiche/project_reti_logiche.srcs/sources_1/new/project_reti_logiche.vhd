library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity project_reti_logiche is
    port(
        i_clk : in std_logic;
        i_rst : in std_logic;
        i_start : in std_logic;
        i_w : in std_logic;
        
        o_z0 : out std_logic_vector(7 downto 0);
        o_z1 : out std_logic_vector(7 downto 0);
        o_z2 : out std_logic_vector(7 downto 0);
        o_z3 : out std_logic_vector(7 downto 0);
        o_done : out std_logic;         
        
        o_mem_addr : out std_logic_vector(15 downto 0);
        i_mem_data : in std_logic_vector(7 downto 0);
        o_mem_we : out std_logic;
        o_mem_en : out std_logic
    );
end project_reti_logiche;

architecture Behavioral of project_reti_logiche is

type state is(RESET, READ_W, WRITE_TO_REG, EXTEND_BIT,  READ_MEM, WRITE_MSG);

begin

  process(i_clk)

    variable tmp : std_logic;
    variable count : INTEGER RANGE 0 to 2 := 0;
    variable prefix : std_logic_vector(1 downto 0);
    variable address : std_logic_vector(15 downto 0) := (15 downto 0 => '0');
    variable message : std_logic_vector(7 downto 0);
    variable next_state, curr_state : state := RESET;

    begin

        if(rising_edge(i_clk)) then
            if(i_rst = '1') then 
                curr_state := RESET;
            else
                curr_state := next_state; 
            end if;
        
            case curr_state is
                when RESET =>
                    o_z0 <= (7 downto 1 => '0');
                    o_z1 <= (7 downto 1 => '0');
                    o_z2 <= (7 downto 1 => '0');
                    o_z3 <= (7 downto 1 => '0');
                    o_done <= '0';
                    o_mem_we <= '0';
                    o_mem_en <= '0';
                    count := 0;
                    address := (15 downto 0 => '0');
                
                
                    if(i_start = '1') then 
                        next_state := READ_W;
                        prefix := (0 => i_w);    
                        count := count+1;
                    else
                        next_state := RESET;
                    end if;
                
                when READ_W =>
                    if(i_start = '1') then
                        if(count<2) then
                            prefix := std_logic_vector(shift_left(unsigned(prefix), 1));
                            prefix := (0 => i_w);
                            count := count+1;
                        else
                            address := std_logic_vector(shift_left(unsigned(address), 1));
                            address := (0 => i_w);
                        end if;
                    else 
                        next_state:= READ_MEM;
                        o_mem_addr <= address;
                    end if;
                
                when READ_MEM =>
                  
                
                                 
                    
                
                    
                    
                
                
                
                
                
                
             end case;
        end if;
      
 
    end process;

end Behavioral;
