library ieee;
    use ieee.std_logic_1164.all;
    use IEEE.numeric_std.all;

package functions is

    FUNCTION divide  (a : UNSIGNED; b : UNSIGNED) return UNSIGNED;

end;

package body functions is

    FUNCTION divide  (a : UNSIGNED; b : UNSIGNED) return UNSIGNED is
        variable a1 : unsigned(a'length-1 downto 0):=a;
        variable b1 : unsigned(b'length-1 downto 0):=b;
        variable p1 : unsigned(b'length downto 0):= (others => '0');
        variable i : integer:=0;
    BEGIN
        FOR i IN 0 TO b'length-1 LOOP
            p1(b'length-1 downto 1) := p1(b'length-2 downto 0);
            p1(0) := a1(a'length-1);
            a1(a'length-1 downto 1) := a1(a'length-2 downto 0);
            p1 := p1-b1;
            IF(p1(b'length-1) ='1') THEN
                a1(0) :='0';
                p1 := p1+b1;
            ELSE
                a1(0) :='1';
                END IF;
        END loop;
        RETURN a1;
    END divide;

end package body;

