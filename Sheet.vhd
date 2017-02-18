------------------------------------------------------------
-- VHDL Sheet
-- 2016 7 15 16 51 27
-- Created By "DXP VHDL Generator"
-- "Copyright (c) 2002-2004 Altium Limited"
------------------------------------------------------------

------------------------------------------------------------
-- VHDL Sheet
------------------------------------------------------------

Library IEEE;
Use     IEEE.std_logic_1164.all;

--synthesis translate_off
Library GENERIC_LIB;
Use     GENERIC_LIB.all;

--synthesis translate_on
Entity Sheet Is
  port
  (
    CLK_BRD  : In    STD_LOGIC;                              -- ObjectKind=Port|PrimaryId=CLK_BRD
    HA3      : InOut STD_LOGIC;                              -- ObjectKind=Port|PrimaryId=HA3
    HA5      : Out   STD_LOGIC;                              -- ObjectKind=Port|PrimaryId=HA5
    SW_USER0 : In    STD_LOGIC;                              -- ObjectKind=Port|PrimaryId=SW_USER0
    SW_USER1 : In    STD_LOGIC                               -- ObjectKind=Port|PrimaryId=SW_USER1
  );
  attribute MacroCell : boolean;

End Sheet;
------------------------------------------------------------

------------------------------------------------------------
architecture structure of Sheet is
   Component CDIV10                                          -- ObjectKind=Part|PrimaryId=U1|SecondaryId=1
      port
      (
        CLKDV : out STD_LOGIC;                               -- ObjectKind=Pin|PrimaryId=U1-CLKDV
        CLKIN : in  STD_LOGIC                                -- ObjectKind=Pin|PrimaryId=U1-CLKIN
      );
   End Component;

   Component Configurable_U4                                 -- ObjectKind=Part|PrimaryId=U4|SecondaryId=1
      port
      (
        AckError        : in STD_LOGIC;                      -- ObjectKind=Pin|PrimaryId=U4-AckError
        ActualState     : in STD_LOGIC_VECTOR(7 downto 0);   -- ObjectKind=Pin|PrimaryId=U4-ActualState[7..0]
        BitsReceivedHum : in STD_LOGIC_VECTOR(15 downto 0);  -- ObjectKind=Pin|PrimaryId=U4-BitsReceivedHum[15..0]
        BitsReceivedTem : in STD_LOGIC_VECTOR(15 downto 0);  -- ObjectKind=Pin|PrimaryId=U4-BitsReceivedTem[15..0]
        CRC             : in STD_LOGIC_VECTOR(7 downto 0);   -- ObjectKind=Pin|PrimaryId=U4-CRC[7..0]
        HumIteration    : in STD_LOGIC;                      -- ObjectKind=Pin|PrimaryId=U4-HumIteration
        SCL             : in STD_LOGIC;                      -- ObjectKind=Pin|PrimaryId=U4-SCL
        SDA             : in STD_LOGIC                       -- ObjectKind=Pin|PrimaryId=U4-SDA
      );
   End Component;

   Component Configurable_U6                                 -- ObjectKind=Part|PrimaryId=U6|SecondaryId=1
      port
      (
        Hum  : in STD_LOGIC_VECTOR(31 downto 0);             -- ObjectKind=Pin|PrimaryId=U6-Hum[31..0]
        Temp : in STD_LOGIC_VECTOR(15 downto 0)              -- ObjectKind=Pin|PrimaryId=U6-Temp[15..0]
      );
   End Component;

   Component debounce                                        -- ObjectKind=Sheet Symbol|PrimaryId=U_debounce
      port
      (
        button : in  STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=debouncer.vhd-button
        clk    : in  STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=debouncer.vhd-clk
        result : out STD_LOGIC                               -- ObjectKind=Sheet Entry|PrimaryId=debouncer.vhd-result
      );
   End Component;

   Component INV                                             -- ObjectKind=Part|PrimaryId=U5|SecondaryId=1
      port
      (
        I : in  STD_LOGIC;                                   -- ObjectKind=Pin|PrimaryId=U5-I
        O : out STD_LOGIC                                    -- ObjectKind=Pin|PrimaryId=U5-O
      );
   End Component;

   Component sht11_uc                                        -- ObjectKind=Sheet Symbol|PrimaryId=U_sht11_uc
      port
      (
        ack_error_out     : out   STD_LOGIC;                 -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-ack_error_out
        Button_1_in       : in    STD_LOGIC;                 -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-Button_1_in
        Clock_Board_in    : in    STD_LOGIC;                 -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-Clock_Board_in
        crc_binary_out    : out   STD_LOGIC_VECTOR(7 downto 0); -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-crc_binary_out[7..0]
        hum_binary_out    : out   STD_LOGIC_VECTOR(15 downto 0); -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-hum_binary_out[15..0]
        hum_decimal_out   : out   STD_LOGIC_VECTOR(31 downto 0); -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-hum_decimal_out[31..0]
        hum_iteration_out : out   STD_LOGIC;                 -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-hum_iteration_out
        scl_i2c           : out   STD_LOGIC;                 -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-scl_i2c
        sda_i2c           : inout STD_LOGIC;                 -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-sda_i2c
        Start_Button_in   : in    STD_LOGIC;                 -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-Start_Button_in
        state_out         : out   STD_LOGIC_VECTOR(7 downto 0); -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-state_out[7..0]
        tem_binary_out    : out   STD_LOGIC_VECTOR(15 downto 0); -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-tem_binary_out[15..0]
        tem_decimal_out   : out   STD_LOGIC_VECTOR(15 downto 0) -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-tem_decimal_out[15..0]
      );
   End Component;


    Signal PinSignal_U_debounce_result            : STD_LOGIC; -- ObjectKind=Net|PrimaryId=result
    Signal PinSignal_U_sht11_uc_ack_error_out     : STD_LOGIC; -- ObjectKind=Net|PrimaryId=NetU4_AckError
    Signal PinSignal_U_sht11_uc_crc_binary_out    : STD_LOGIC_VECTOR(7 downto 0); -- ObjectKind=Net|PrimaryId=NetU4_CRC[7..0]
    Signal PinSignal_U_sht11_uc_hum_binary_out    : STD_LOGIC_VECTOR(15 downto 0); -- ObjectKind=Net|PrimaryId=NetU4_BitsReceivedHum[15..0]
    Signal PinSignal_U_sht11_uc_hum_decimal_out   : STD_LOGIC_VECTOR(31 downto 0); -- ObjectKind=Net|PrimaryId=NetU6_Hum[31..0]
    Signal PinSignal_U_sht11_uc_hum_iteration_out : STD_LOGIC; -- ObjectKind=Net|PrimaryId=NetU4_HumIteration
    Signal PinSignal_U_sht11_uc_scl_i2c           : STD_LOGIC; -- ObjectKind=Net|PrimaryId=NetU4_SDA
    Signal PinSignal_U_sht11_uc_state_out         : STD_LOGIC_VECTOR(7 downto 0); -- ObjectKind=Net|PrimaryId=NetU4_ActualState[7..0]
    Signal PinSignal_U_sht11_uc_tem_binary_out    : STD_LOGIC_VECTOR(15 downto 0); -- ObjectKind=Net|PrimaryId=NetU4_BitsReceivedTem[15..0]
    Signal PinSignal_U_sht11_uc_tem_decimal_out   : STD_LOGIC_VECTOR(15 downto 0); -- ObjectKind=Net|PrimaryId=NetU6_Temp[15..0]
    Signal PinSignal_U1_CLKDV                     : STD_LOGIC; -- ObjectKind=Net|PrimaryId=NetU1_CLKDV
    Signal PinSignal_U2_CLKDV                     : STD_LOGIC; -- ObjectKind=Net|PrimaryId=NetU2_CLKDV
    Signal PinSignal_U3_CLKDV                     : STD_LOGIC; -- ObjectKind=Net|PrimaryId=NetU3_CLKDV
    Signal PinSignal_U5_O                         : STD_LOGIC; -- ObjectKind=Net|PrimaryId=NetU5_O
    Signal PinSignal_U7_O                         : STD_LOGIC; -- ObjectKind=Net|PrimaryId=NetU7_O

begin
    U_sht11_uc : sht11_uc                                    -- ObjectKind=Sheet Symbol|PrimaryId=U_sht11_uc
      Port Map
      (
        ack_error_out     => PinSignal_U_sht11_uc_ack_error_out, -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-ack_error_out
        Button_1_in       => PinSignal_U_debounce_result,    -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-Button_1_in
        Clock_Board_in    => PinSignal_U3_CLKDV,             -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-Clock_Board_in
        crc_binary_out    => PinSignal_U_sht11_uc_crc_binary_out, -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-crc_binary_out[7..0]
        hum_binary_out    => PinSignal_U_sht11_uc_hum_binary_out, -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-hum_binary_out[15..0]
        hum_decimal_out   => PinSignal_U_sht11_uc_hum_decimal_out, -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-hum_decimal_out[31..0]
        hum_iteration_out => PinSignal_U_sht11_uc_hum_iteration_out, -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-hum_iteration_out
        scl_i2c           => PinSignal_U_sht11_uc_scl_i2c,   -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-scl_i2c
        sda_i2c           => HA3,                            -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-sda_i2c
        Start_Button_in   => PinSignal_U5_O,                 -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-Start_Button_in
        state_out         => PinSignal_U_sht11_uc_state_out, -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-state_out[7..0]
        tem_binary_out    => PinSignal_U_sht11_uc_tem_binary_out, -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-tem_binary_out[15..0]
        tem_decimal_out   => PinSignal_U_sht11_uc_tem_decimal_out -- ObjectKind=Sheet Entry|PrimaryId=SHT11_uC.vhd-tem_decimal_out[15..0]
      );

    U_debounce : debounce                                    -- ObjectKind=Sheet Symbol|PrimaryId=U_debounce
      Port Map
      (
        button => PinSignal_U7_O,                            -- ObjectKind=Sheet Entry|PrimaryId=debouncer.vhd-button
        clk    => CLK_BRD,                                   -- ObjectKind=Sheet Entry|PrimaryId=debouncer.vhd-clk
        result => PinSignal_U_debounce_result                -- ObjectKind=Sheet Entry|PrimaryId=debouncer.vhd-result
      );

    U7 : INV                                                 -- ObjectKind=Part|PrimaryId=U7|SecondaryId=1
      Port Map
      (
        I => SW_USER1,                                       -- ObjectKind=Pin|PrimaryId=U7-I
        O => PinSignal_U7_O                                  -- ObjectKind=Pin|PrimaryId=U7-O
      );

    U6 : Configurable_U6                                     -- ObjectKind=Part|PrimaryId=U6|SecondaryId=1
      Port Map
      (
        Hum  => PinSignal_U_sht11_uc_hum_decimal_out,        -- ObjectKind=Pin|PrimaryId=U6-Hum[31..0]
        Temp => PinSignal_U_sht11_uc_tem_decimal_out         -- ObjectKind=Pin|PrimaryId=U6-Temp[15..0]
      );

    U5 : INV                                                 -- ObjectKind=Part|PrimaryId=U5|SecondaryId=1
      Port Map
      (
        I => SW_USER0,                                       -- ObjectKind=Pin|PrimaryId=U5-I
        O => PinSignal_U5_O                                  -- ObjectKind=Pin|PrimaryId=U5-O
      );

    U4 : Configurable_U4                                     -- ObjectKind=Part|PrimaryId=U4|SecondaryId=1
      Port Map
      (
        AckError        => PinSignal_U_sht11_uc_ack_error_out, -- ObjectKind=Pin|PrimaryId=U4-AckError
        ActualState     => PinSignal_U_sht11_uc_state_out,   -- ObjectKind=Pin|PrimaryId=U4-ActualState[7..0]
        BitsReceivedHum => PinSignal_U_sht11_uc_hum_binary_out, -- ObjectKind=Pin|PrimaryId=U4-BitsReceivedHum[15..0]
        BitsReceivedTem => PinSignal_U_sht11_uc_tem_binary_out, -- ObjectKind=Pin|PrimaryId=U4-BitsReceivedTem[15..0]
        CRC             => PinSignal_U_sht11_uc_crc_binary_out, -- ObjectKind=Pin|PrimaryId=U4-CRC[7..0]
        HumIteration    => PinSignal_U_sht11_uc_hum_iteration_out, -- ObjectKind=Pin|PrimaryId=U4-HumIteration
        SCL             => HA3,                              -- ObjectKind=Pin|PrimaryId=U4-SCL
        SDA             => PinSignal_U_sht11_uc_scl_i2c      -- ObjectKind=Pin|PrimaryId=U4-SDA
      );

    U3 : CDIV10                                              -- ObjectKind=Part|PrimaryId=U3|SecondaryId=1
      Port Map
      (
        CLKDV => PinSignal_U3_CLKDV,                         -- ObjectKind=Pin|PrimaryId=U3-CLKDV
        CLKIN => PinSignal_U2_CLKDV                          -- ObjectKind=Pin|PrimaryId=U3-CLKIN
      );

    U2 : CDIV10                                              -- ObjectKind=Part|PrimaryId=U2|SecondaryId=1
      Port Map
      (
        CLKDV => PinSignal_U2_CLKDV,                         -- ObjectKind=Pin|PrimaryId=U2-CLKDV
        CLKIN => PinSignal_U1_CLKDV                          -- ObjectKind=Pin|PrimaryId=U2-CLKIN
      );

    U1 : CDIV10                                              -- ObjectKind=Part|PrimaryId=U1|SecondaryId=1
      Port Map
      (
        CLKDV => PinSignal_U1_CLKDV,                         -- ObjectKind=Pin|PrimaryId=U1-CLKDV
        CLKIN => CLK_BRD                                     -- ObjectKind=Pin|PrimaryId=U1-CLKIN
      );

    -- Signal Assignments
    ---------------------
    HA5 <= PinSignal_U_sht11_uc_scl_i2c; -- ObjectKind=Net|PrimaryId=NetU4_SDA

end structure;
------------------------------------------------------------

