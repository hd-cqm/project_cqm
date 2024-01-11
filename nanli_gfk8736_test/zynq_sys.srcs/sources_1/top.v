module top(
    input                               ema_clk_p                  ,
    input                               rst_n                      ,
    input              [   5:2]         ema_csn                    ,
    input              [   1:0]         ema_ba                     ,
    input              [  15:0]         ema_a                      ,
    input              [   1:0]         ema_wen_dqm                ,
    input                               ema_a_rwn                  ,
    input                               ema_oen                    ,
    inout              [  15:0]         ema_d                      ,
    input                               ema_wen                    ,
    output             [   0:0]         dsp_io                     ,
    inout  wire        [  14:0]         ddr_addr                   ,
    inout  wire        [   2:0]         ddr_ba                     ,
    inout  wire                         ddr_cas_n                  ,
    inout  wire                         ddr_ck_n                   ,
    inout  wire                         ddr_ck_p                   ,
    inout  wire                         ddr_cke                    ,
    inout  wire                         ddr_cs_n                   ,
    inout  wire        [   3:0]         ddr_dm                     ,
    inout  wire        [  31:0]         ddr_dq                     ,
    inout  wire        [   3:0]         ddr_dqs_n                  ,
    inout  wire        [   3:0]         ddr_dqs_p                  ,
    inout  wire                         ddr_odt                    ,
    inout  wire                         ddr_ras_n                  ,
    inout  wire                         ddr_reset_n                ,
    inout  wire                         ddr_we_n                   ,
    inout  wire                         fixed_io_ddr_vrn           ,
    inout  wire                         fixed_io_ddr_vrp           ,
    inout  wire        [  53:0]         fixed_io_mio               ,
    inout  wire                         fixed_io_ps_clk            ,
    inout  wire                         fixed_io_ps_porb           ,
    inout  wire                         fixed_io_ps_srstb          ,
    output wire        [   1:0]         mlvds_de                   ,
    output wire        [   1:0]         mlvds_re                   ,
    output wire        [   1:0]         mlvds_tx                   ,
    input  wire        [   1:0]         mlvds_rx                   ,
    output wire                         mlvds_clk                  ,
    output wire        [   2:0]         rs422_tx                   ,
    input  wire        [   2:0]         rs422_rx                   ,
    output wire                         rs232_dbg_tx               ,
    input  wire                         rs232_dbg_rx               


);
assign      mlvds_clk = 'hf;
//variable
wire            dsp_io_0        ;
wire [15:0 ]    ema_a_0         ;
wire            ema_a_rwn_0     ;
wire [ 1:0 ]    ema_ba_0        ;
wire            ema_clk_p_0     ;
wire            ema_csn_0       ;
wire            ema_oen_0       ;
wire            ema_wen_0       ;
wire [ 1:0 ]    ema_wen_dqm_0   ;
wire [15:0 ]    ema_d_i         ;
wire [15:0 ]    ema_d_o         ;

wire        tpos                ;
wire [31:0] m0_axi_lite_araddr  ;
wire [ 2:0] m0_axi_lite_arprot  ;
wire        m0_axi_lite_arready ;
wire        m0_axi_lite_arvalid ;
wire [31:0] m0_axi_lite_awaddr  ;
wire [ 2:0] m0_axi_lite_awprot  ;
wire        m0_axi_lite_awready ;
wire        m0_axi_lite_awvalid ;
wire        m0_axi_lite_bready  ;
wire [ 1:0] m0_axi_lite_bresp   ;
wire        m0_axi_lite_bvalid  ;
wire [31:0] m0_axi_lite_rdata   ;
wire        m0_axi_lite_rready  ;
wire [ 1:0] m0_axi_lite_rresp   ;
wire        m0_axi_lite_rvalid  ;
wire [31:0] m0_axi_lite_wdata   ;
wire        m0_axi_lite_wready  ;
wire [ 3:0] m0_axi_lite_wstrb   ;
wire        m0_axi_lite_wvalid  ;
wire [15:0] apb_drpaddr         ;
wire        apb_drpwen          ;
wire [31:0] apb_drpwdata        ;
wire        apb_drpren          ;
wire        apb_drprdy          ;
wire [31:0] apb_drprdata        ;
wire        fclk_100mhz         ;
wire        fclk_resetn         ;
axi_lite_to_drp_wrapper axi_lite_to_drp_wrapper_u0(
    .aclk                ( fclk_100mhz         ),
    .aresetn             ( fclk_resetn         ),
    .s_axi_lite_araddr   ( m0_axi_lite_araddr  ),
    .s_axi_lite_arprot   ( m0_axi_lite_arprot  ),
    .s_axi_lite_arready  ( m0_axi_lite_arready ),
    .s_axi_lite_arvalid  ( m0_axi_lite_arvalid ),
    .s_axi_lite_awaddr   ( m0_axi_lite_awaddr  ),
    .s_axi_lite_awprot   ( m0_axi_lite_awprot  ),
    .s_axi_lite_awready  ( m0_axi_lite_awready ),
    .s_axi_lite_awvalid  ( m0_axi_lite_awvalid ),
    .s_axi_lite_bready   ( m0_axi_lite_bready  ),
    .s_axi_lite_bresp    ( m0_axi_lite_bresp   ),
    .s_axi_lite_bvalid   ( m0_axi_lite_bvalid  ),
    .s_axi_lite_rdata    ( m0_axi_lite_rdata   ),
    .s_axi_lite_rready   ( m0_axi_lite_rready  ),
    .s_axi_lite_rresp    ( m0_axi_lite_rresp   ),
    .s_axi_lite_rvalid   ( m0_axi_lite_rvalid  ),
    .s_axi_lite_wdata    ( m0_axi_lite_wdata   ),
    .s_axi_lite_wready   ( m0_axi_lite_wready  ),
    .s_axi_lite_wstrb    ( m0_axi_lite_wstrb   ),
    .s_axi_lite_wvalid   ( m0_axi_lite_wvalid  ),
    .apb_drpaddr         ( apb_drpaddr         ),
    .apb_drpwen          ( apb_drpwen          ),
    .apb_drpwdata        ( apb_drpwdata        ),
    .apb_drpren          ( apb_drpren          ),
    .apb_drprdy          ( apb_drprdy          ),
    .apb_drprdata        ( apb_drprdata        )
);
wire [ 1:0] mlvds_txd      ;
wire        mlvds_drprdy   ;
wire [31:0] mlvds_drprdata ;
mlvds_wrapper mlvds_wrapper_u0(
    .aclk                ( fclk_100mhz         ),
    .aresetn             ( fclk_resetn         ),
    .drpaddr             ( apb_drpaddr         ),
    .drpwen              ( apb_drpwen          ),
    .drpwdata            ( apb_drpwdata        ),
    .drpren              ( apb_drpren          ),
    .drprdy              ( mlvds_drprdy        ),
    .drprdata            ( mlvds_drprdata      ),
    .de                  ( mlvds_de            ),
    .re                  ( mlvds_re            ),
    .rxd                 ( ~mlvds_rx           ),
    .txd                 ( mlvds_txd           )
);
assign      mlvds_tx = ~mlvds_txd;
wire        rs422_drprdy   ;
wire [31:0] rs422_drprdata ;
rs422_wrapper rs422_wrapper_u0(
    .aclk                ( fclk_100mhz         ),
    .aresetn             ( fclk_resetn         ),
    .drpaddr             ( apb_drpaddr         ),
    .drpwen              ( apb_drpwen          ),
    .drpwdata            ( apb_drpwdata        ),
    .drpren              ( apb_drpren          ),
    .drprdy              ( rs422_drprdy        ),
    .drprdata            ( rs422_drprdata      ),
    .rxd                 ( rs422_rx            ),
    .txd                 ( rs422_tx            )
);
reg         drprdy_reg    = 'd0;
reg  [31:0] drprdata_reg  = 'd0;
always @( posedge fclk_100mhz)begin
    if (mlvds_drprdy)
        drprdata_reg <= mlvds_drprdata;
    else if (rs422_drprdy)
        drprdata_reg <= rs422_drprdata;
    drprdy_reg       <= mlvds_drprdy | rs422_drprdy;
end

assign      apb_drprdy   = drprdy_reg;
assign      apb_drprdata = drprdata_reg;

reg  [ 9:0] wait1_cnt = 'd0;
always @( posedge fclk_100mhz)begin
    if (tpos)
        wait1_cnt <= 'd0;
    else
        wait1_cnt <= wait1_cnt + 'd1;
end

assign      tpos = (wait1_cnt == 'd651);
ila_uart ila_uart_u0 (
    .clk                 ( fclk_100mhz         ), 
    .probe0              ( tpos                ), 
    .probe1              ( mlvds_tx[0]         ), 
    .probe2              ( mlvds_rx[0]         ),
    .probe3              ( mlvds_tx[1]         ), 
    .probe4              ( mlvds_rx[1]         )
);
//system_bd system_bd_i(
//    .ddr_addr            ( ddr_addr            ),
//    .ddr_ba              ( ddr_ba              ),
//    .ddr_cas_n           ( ddr_cas_n           ),
//    .ddr_ck_n            ( ddr_ck_n            ),
//    .ddr_ck_p            ( ddr_ck_p            ),
//    .ddr_cke             ( ddr_cke             ),
//    .ddr_cs_n            ( ddr_cs_n            ),
//    .ddr_dm              ( ddr_dm              ),
//    .ddr_dq              ( ddr_dq              ),
//    .ddr_dqs_n           ( ddr_dqs_n           ),
//    .ddr_dqs_p           ( ddr_dqs_p           ),
//    .ddr_odt             ( ddr_odt             ),
//    .ddr_ras_n           ( ddr_ras_n           ),
//    .ddr_reset_n         ( ddr_reset_n         ),
//    .ddr_we_n            ( ddr_we_n            ),
//    .fixed_io_ddr_vrn    ( fixed_io_ddr_vrn    ),
//    .fixed_io_ddr_vrp    ( fixed_io_ddr_vrp    ),
//    .fixed_io_mio        ( fixed_io_mio        ),
//    .fixed_io_ps_clk     ( fixed_io_ps_clk     ),
//    .fixed_io_ps_porb    ( fixed_io_ps_porb    ),
//    .fixed_io_ps_srstb   ( fixed_io_ps_srstb   ),
//    .fclk0_aclk          ( fclk_100mhz         ),
//    .fclk0_resetn        ( fclk_resetn         ),
//    .m_axi_lite_aclk     ( fclk_100mhz         ),
//    .m_axi_lite_aresetn  ( fclk_resetn         ),
//    .m0_axi_lite_araddr  ( m0_axi_lite_araddr  ),
//    .m0_axi_lite_arprot  ( m0_axi_lite_arprot  ),
//    .m0_axi_lite_arready ( m0_axi_lite_arready ),
//    .m0_axi_lite_arvalid ( m0_axi_lite_arvalid ),
//    .m0_axi_lite_awaddr  ( m0_axi_lite_awaddr  ),
//    .m0_axi_lite_awprot  ( m0_axi_lite_awprot  ),
//    .m0_axi_lite_awready ( m0_axi_lite_awready ),
//    .m0_axi_lite_awvalid ( m0_axi_lite_awvalid ),
//    .m0_axi_lite_bready  ( m0_axi_lite_bready  ),
//    .m0_axi_lite_bresp   ( m0_axi_lite_bresp   ),
//    .m0_axi_lite_bvalid  ( m0_axi_lite_bvalid  ),
//    .m0_axi_lite_rdata   ( m0_axi_lite_rdata   ),
//    .m0_axi_lite_rready  ( m0_axi_lite_rready  ),
//    .m0_axi_lite_rresp   ( m0_axi_lite_rresp   ),
//    .m0_axi_lite_rvalid  ( m0_axi_lite_rvalid  ),
//    .m0_axi_lite_wdata   ( m0_axi_lite_wdata   ),
//    .m0_axi_lite_wready  ( m0_axi_lite_wready  ),
//    .m0_axi_lite_wstrb   ( m0_axi_lite_wstrb   ),
//    .m0_axi_lite_wvalid  ( m0_axi_lite_wvalid  )
//);
wire    UART_0_0_rxd    ;
wire    UART_0_0_txd    ;

assign  rs232_dbg_tx    =   UART_0_0_txd    ;
assign  UART_0_0_rxd    =   rs232_dbg_rx    ;

  system_bd system_bd_i(
    .UART_0_0_rxd                      (UART_0_0_rxd              ),
    .UART_0_0_txd                      (UART_0_0_txd              ),
    .ddr_addr                          (ddr_addr                  ),
    .ddr_ba                            (ddr_ba                    ),
    .ddr_cas_n                         (ddr_cas_n                 ),
    .ddr_ck_n                          (ddr_ck_n                  ),
    .ddr_ck_p                          (ddr_ck_p                  ),
    .ddr_cke                           (ddr_cke                   ),
    .ddr_cs_n                          (ddr_cs_n                  ),
    .ddr_dm                            (ddr_dm                    ),
    .ddr_dq                            (ddr_dq                    ),
    .ddr_dqs_n                         (ddr_dqs_n                 ),
    .ddr_dqs_p                         (ddr_dqs_p                 ),
    .ddr_odt                           (ddr_odt                   ),
    .ddr_ras_n                         (ddr_ras_n                 ),
    .ddr_reset_n                       (ddr_reset_n               ),
    .ddr_we_n                          (ddr_we_n                  ),
    .dsp_io_0                          (dsp_io_0                  ),
    .ema_a_0                           (ema_a_0                   ),
    .ema_ba_0                          (ema_ba_0                  ),
    .ema_clk_p_0                       (ema_clk_p_0               ),
    .ema_csn_0                         (ema_csn_0                 ),
    .ema_d_i_0                         (ema_d_i                   ),
    .ema_d_o_0                         (ema_d_o                   ),
    .ema_oen_0                         (ema_oen_0                 ),
    .ema_wen_0                         (ema_wen_0                 ),
    .ema_wen_dqm_0                     (ema_wen_dqm_0             ),
    .fclk0_aclk                        (fclk_100mhz               ),
    .fclk0_resetn                      (fclk_resetn               ),
    .fixed_io_ddr_vrn                  (fixed_io_ddr_vrn          ),
    .fixed_io_ddr_vrp                  (fixed_io_ddr_vrp          ),
    .fixed_io_mio                      (fixed_io_mio              ),
    .fixed_io_ps_clk                   (fixed_io_ps_clk           ),
    .fixed_io_ps_porb                  (fixed_io_ps_porb          ),
    .fixed_io_ps_srstb                 (fixed_io_ps_srstb         ),
    .m0_axi_lite_araddr                (m0_axi_lite_araddr        ),
    .m0_axi_lite_arprot                (m0_axi_lite_arprot        ),
    .m0_axi_lite_arready               (m0_axi_lite_arready       ),
    .m0_axi_lite_arvalid               (m0_axi_lite_arvalid       ),
    .m0_axi_lite_awaddr                (m0_axi_lite_awaddr        ),
    .m0_axi_lite_awprot                (m0_axi_lite_awprot        ),
    .m0_axi_lite_awready               (m0_axi_lite_awready       ),
    .m0_axi_lite_awvalid               (m0_axi_lite_awvalid       ),
    .m0_axi_lite_bready                (m0_axi_lite_bready        ),
    .m0_axi_lite_bresp                 (m0_axi_lite_bresp         ),
    .m0_axi_lite_bvalid                (m0_axi_lite_bvalid        ),
    .m0_axi_lite_rdata                 (m0_axi_lite_rdata         ),
    .m0_axi_lite_rready                (m0_axi_lite_rready        ),
    .m0_axi_lite_rresp                 (m0_axi_lite_rresp         ),
    .m0_axi_lite_rvalid                (m0_axi_lite_rvalid        ),
    .m0_axi_lite_wdata                 (m0_axi_lite_wdata         ),
    .m0_axi_lite_wready                (m0_axi_lite_wready        ),
    .m0_axi_lite_wstrb                 (m0_axi_lite_wstrb         ),
    .m0_axi_lite_wvalid                (m0_axi_lite_wvalid        ),
    .m_axi_lite_aclk                   (fclk_100mhz               ),
    .m_axi_lite_aresetn                (fclk_resetn               ),
    .zynq_req_0                        (                          ) 
);

assign  ema_csn_0       =   ema_csn[2]      ;
assign  dsp_io          =   dsp_io_0        ;
assign  ema_a_0         =   ema_a           ;

assign  ema_a_rwn_0     =   ema_a_rwn       ;
assign  ema_oen_0       =   ema_oen         ;
assign  ema_wen_0       =   ema_wen         ;
assign  ema_wen_dqm_0   =   ema_wen_dqm     ;
assign  ema_ba_0        =   ema_ba          ;
assign  ema_clk_p_0     =   ema_clk_p       ;

genvar iobuf_i;
generate for ( iobuf_i = 0 ;iobuf_i <  16 ; iobuf_i = iobuf_i + 1 ) begin : iobuf_d
 // IOBUF: Single-ended Bi-directional Buffer
   //        All devices
   // Xilinx HDL Language Template, version 2019.1

IOBUF #(
    .DRIVE(12), // Specify the output drive strength
    .IBUF_LOW_PWR("TRUE"),  // Low Power - "TRUE", High Performance = "FALSE" 
    .IOSTANDARD("LVCMOS33"), // Specify the I/O standard
    .SLEW("FAST") // Specify the output slew rate
 ) IOBUF_inst (
    .O(ema_d_i[iobuf_i]),     // Buffer output
    .IO(ema_d[iobuf_i]),   // Buffer inout port (connect directly to top-level port)
    .I(ema_d_o[iobuf_i]),     // Buffer input
    .T(ema_oen_0)      // 3-state enable input, high=input, low=output
 );
end
endgenerate

endmodule
