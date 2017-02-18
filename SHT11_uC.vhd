LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.functions.ALL;

ENTITY SHT11_uC IS

    PORT (
        Clock_Board_in    : IN std_logic; -- divided board clock
        Start_Button_in   : IN std_logic; -- wcisnij aby zmierzyc
        Button_1_in       : IN std_logic;
        sda_i2c           : INOUT std_logic; -- i2c data
        scl_i2c           : OUT std_logic; -- i2c clock
        tem_binary_out    : OUT std_logic_vector(15 downto 0); -- otrzymane bity
        hum_binary_out    : OUT std_logic_vector(15 downto 0); -- otrzymane bity
        crc_binary_out    : OUT std_logic_vector(7 downto 0); -- otrzymane bity
        tem_decimal_out   : OUT std_logic_vector(15 downto 0); -- temperatura jako liczba dziesietna
        hum_decimal_out   : OUT std_logic_vector(31 downto 0); -- wilgotnosc jako liczba dziesietna
        ack_error_out     : OUT std_logic; -- jezeli ACK error to 1
        state_out         : OUT std_logic_vector(7 downto 0); -- aktualny stan do podgladu
        hum_iteration_out : OUT std_logic -- czy aktualnie mierzona wilgotnosc (a nie temperatura)
    );

END SHT11_uC;


ARCHITECTURE arch OF SHT11_uC IS

    -- stany
    TYPE     FSM_STATE IS (DELAYING, RESETPARAMS, START1, START2, START3, START4, START5, START6, SENDCMD1, SENDCMD2, GETACK1, GETACK2, MEASURING1, MEASURING2, GETFIRSTBYTE1, GETFIRSTBYTE2, SENDACK1, SENDACK2, SENDACK3, GETSECONDBYTE1, GETSECONDBYTE2, SENDACK4, SENDACK5, SENDACK6, GETCRC1, GETCRC2, FINISH);

    -- sygnaly wewnetrzne
    SIGNAL   state         : FSM_STATE := DELAYING; -- aktualny stan
    SIGNAL   sda           : std_logic; -- wewnetrzny sygnal sda_i2c, ale operujacy na 0/1 (a nie 0/Z)
    SIGNAL   tem_binary    : std_logic_vector(15 downto 0); -- otrzymane bity
    SIGNAL   hum_binary    : std_logic_vector(15 downto 0); -- otrzymane bity
    SIGNAL   crc_binary    : std_logic_vector(7 downto 0); -- otrzymane bity
    SIGNAL   hum_iteration : std_logic := '0'; -- czy aktualnie mierzona wilgotnosc (a nie temperatura)

    -- Komendy wysylane do SHT11
    CONSTANT tem_command   : std_logic_vector(7 downto 0) := "00000011"; -- komenda-zapytanie o temperature
    CONSTANT hum_command   : std_logic_vector(7 downto 0) := "00000101"; -- komenda-zapytanie o wilgotnosc

BEGIN

    sda_i2c           <= 'Z' WHEN sda = '1' ELSE '0'; -- przepisanie 0/1 na 0/Z
    tem_binary_out    <= tem_binary;
    hum_binary_out    <= hum_binary;
    crc_binary_out    <= crc_binary;
    hum_iteration_out <= hum_iteration;

    -- normalizacja wyniku
    tem_decimal_out <= std_logic_vector(signed(tem_binary) - to_signed(3970, 16));
    hum_decimal_out <= std_logic_vector(divide(unsigned(hum_binary) * to_unsigned(36700, 16), to_unsigned(10000, 32)));


    finite_state_machine:
    PROCESS(Clock_Board_in, Start_Button_in)
        VARIABLE send_bit_iter : integer; -- iterator wysylanych bitow
        VARIABLE recv_bit_iter : integer; -- iterator odbieranych bitow
        VARIABLE crc_bit_iter  : integer; -- iterator bitow crc
        VARIABLE delaying_iter : integer := 40000; -- iterator opozniajacej petli w automacie
    BEGIN

        IF(Start_Button_in = '1') THEN
            scl_i2c <= '1';
            sda <= '1';
            state <= RESETPARAMS;

        ELSIF rising_edge(Clock_Board_in) THEN

            CASE state IS

                WHEN DELAYING =>
                    delaying_iter := delaying_iter - 1;
                    IF delaying_iter < 1 THEN
                        state <= RESETPARAMS;
                    END IF;

                WHEN RESETPARAMS =>
                    scl_i2c <= '0';
                    sda <= '1';
                    ack_error_out <= '0';
                    send_bit_iter := 7;
                    recv_bit_iter := 15;
                    crc_bit_iter := 7;
                    delaying_iter := 40000;
                    state <= START1;

                WHEN START1 =>
                    scl_i2c <= '1';
                    state <= START2;

                WHEN START2 =>
                    sda <= '0';
                    state <= START3;

                WHEN START3 =>
                    scl_i2c <= '0';
                    state <= START4;

                WHEN START4 =>
                    scl_i2c <= '1';
                    state <= START5;

                WHEN START5 =>
                    sda <= '1';
                    state <= START6;

                WHEN START6 =>
                    scl_i2c <= '0';
                    state <= SENDCMD1;

                WHEN SENDCMD1 =>
                    scl_i2c <= '0';
                    IF hum_iteration='1' THEN
                        sda <= hum_command(send_bit_iter);
                    ELSE
                        sda <= tem_command(send_bit_iter);
                    END IF;
                    state <= SENDCMD2;

                WHEN SENDCMD2 =>
                    scl_i2c <= '1';
                    IF send_bit_iter > 0 THEN
                        send_bit_iter := send_bit_iter - 1;
                        state <= SENDCMD1;
                    ELSE
                        state <= GETACK1;
                    END IF;

                WHEN GETACK1 =>
                    scl_i2c <= '0';
                    sda <= '1';
                    state <= GETACK2;

                WHEN GETACK2 =>
                    scl_i2c <= '1';
                    IF sda_i2c='0' THEN
                        state <= MEASURING1;
                    ELSE
                        ack_error_out <= '1';
                        state <= RESETPARAMS;
                    END IF;

                WHEN MEASURING1 =>
                    scl_i2c <= '0';
                    state <= MEASURING2;

                WHEN MEASURING2 =>
                    IF sda_i2c='0' THEN
                        state <= GETFIRSTBYTE1;
                    ELSE
                        state <= MEASURING2;
                    END IF;

                WHEN GETFIRSTBYTE1 =>
                    scl_i2c <= '1';
                    IF hum_iteration='1' THEN
                        hum_binary(recv_bit_iter) <= sda_i2c;
                    ELSE
                        tem_binary(recv_bit_iter) <= sda_i2c;
                    END IF;
                    recv_bit_iter := recv_bit_iter - 1;
                    state <= GETFIRSTBYTE2;

                WHEN GETFIRSTBYTE2 =>
                    scl_i2c <= '0';
                    IF recv_bit_iter > 7 THEN
                        state <= GETFIRSTBYTE1;
                    ELSE
                        state <= SENDACK1;
                    END IF;

                WHEN SENDACK1 =>
                    sda <= '0';
                    state <= SENDACK2;

                WHEN SENDACK2 =>
                    scl_i2c <= '1';
                    state <= SENDACK3;

                WHEN SENDACK3 =>
                    scl_i2c <= '0';
                    sda <= '1';
                    state <= GETSECONDBYTE1;

                WHEN GETSECONDBYTE1 =>
                    scl_i2c <= '1';
                    IF hum_iteration='1' THEN
                        hum_binary(recv_bit_iter) <= sda_i2c;
                    ELSE
                        tem_binary(recv_bit_iter) <= sda_i2c;
                    END IF;
                    recv_bit_iter := recv_bit_iter - 1;
                    state <= GETSECONDBYTE2;

                WHEN GETSECONDBYTE2 =>
                    scl_i2c <= '0';
                    IF recv_bit_iter > -1 THEN
                        state <= GETSECONDBYTE1;
                    ELSE
                        sda <= '1';
                        state <= SENDACK4;
                    END IF;

                WHEN SENDACK4 =>
                    sda <= '0';
                    state <= SENDACK5;

                WHEN SENDACK5 =>
                    scl_i2c <= '1';
                    state <= SENDACK6;
                WHEN SENDACK6 =>
                    scl_i2c <= '0';
                    sda <= '1';
                    state <= GETCRC1;

                WHEN GETCRC1 =>
                    scl_i2c <= '1';
                    crc_binary(crc_bit_iter) <= sda_i2c;
                    crc_bit_iter := crc_bit_iter - 1;
                    state <= GETCRC2;

                WHEN GETCRC2 =>
                    scl_i2c <= '0';
                    IF crc_bit_iter > -1 THEN
                        state <= GETCRC1;
                    ELSE
                        sda <= '1';
                        state <= FINISH;
                    END IF;

                WHEN FINISH =>
                    scl_i2c <= '1';
                    hum_iteration <= NOT hum_iteration;
                    state <= DELAYING;

                WHEN OTHERS =>
                    state <= RESETPARAMS;

            END CASE;

        END IF;

    END PROCESS;

    -- aktualizacja podgladu stanu
    PROCESS(state)
    BEGIN
        CASE state IS
            WHEN    DELAYING       => state_out <= x"00";
            WHEN    RESETPARAMS    => state_out <= x"01";
            WHEN    START1         => state_out <= x"02";
            WHEN    START2         => state_out <= x"03";
            WHEN    START3         => state_out <= x"04";
            WHEN    START4         => state_out <= x"05";
            WHEN    START5         => state_out <= x"06";
            WHEN    START6         => state_out <= x"07";
            WHEN    SENDCMD1       => state_out <= x"08";
            WHEN    SENDCMD2       => state_out <= x"09";
            WHEN    GETACK1        => state_out <= x"0A";
            WHEN    GETACK2        => state_out <= x"0B";
            WHEN    MEASURING1     => state_out <= x"0C";
            WHEN    MEASURING2     => state_out <= x"0D";
            WHEN    GETFIRSTBYTE1  => state_out <= x"0E";
            WHEN    GETFIRSTBYTE2  => state_out <= x"0F";
            WHEN    SENDACK1       => state_out <= x"10";
            WHEN    SENDACK2       => state_out <= x"11";
            WHEN    SENDACK3       => state_out <= x"12";
            WHEN    GETSECONDBYTE1 => state_out <= x"13";
            WHEN    GETSECONDBYTE2 => state_out <= x"14";
            WHEN    SENDACK4       => state_out <= x"15";
            WHEN    SENDACK5       => state_out <= x"16";
            WHEN    SENDACK6       => state_out <= x"17";
            WHEN    GETCRC1        => state_out <= x"18";
            WHEN    GETCRC2        => state_out <= x"19";
            WHEN    FINISH         => state_out <= x"1A";
        END CASE;
    END PROCESS;


END arch;

