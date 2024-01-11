set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ema_clk_p_IBUF]

create_clock -period 7.092 -name ema_clk_p -waveform {0.000 3.546} [get_ports ema_clk_p]




set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets fclk_100mhz]
