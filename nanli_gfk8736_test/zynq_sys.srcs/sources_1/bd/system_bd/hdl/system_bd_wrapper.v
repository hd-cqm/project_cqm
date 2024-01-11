//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1.3 (win64) Build 2644227 Wed Sep  4 09:45:24 MDT 2019
//Date        : Wed Jan  3 15:22:30 2024
//Host        : DESKTOP-CQM running 64-bit major release  (build 9200)
//Command     : generate_target system_bd_wrapper.bd
//Design      : system_bd_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module system_bd_wrapper
   (UART_0_0_rxd,
    UART_0_0_txd,
    ddr_addr,
    ddr_ba,
    ddr_cas_n,
    ddr_ck_n,
    ddr_ck_p,
    ddr_cke,
    ddr_cs_n,
    ddr_dm,
    ddr_dq,
    ddr_dqs_n,
    ddr_dqs_p,
    ddr_odt,
    ddr_ras_n,
    ddr_reset_n,
    ddr_we_n,
    dsp_io_0,
    ema_a_0,
    ema_ba_0,
    ema_clk_p_0,
    ema_csn_0,
    ema_d_i_0,
    ema_d_o_0,
    ema_oen_0,
    ema_wen_0,
    ema_wen_dqm_0,
    fclk0_aclk,
    fclk0_resetn,
    fixed_io_ddr_vrn,
    fixed_io_ddr_vrp,
    fixed_io_mio,
    fixed_io_ps_clk,
    fixed_io_ps_porb,
    fixed_io_ps_srstb,
    m0_axi_lite_araddr,
    m0_axi_lite_arprot,
    m0_axi_lite_arready,
    m0_axi_lite_arvalid,
    m0_axi_lite_awaddr,
    m0_axi_lite_awprot,
    m0_axi_lite_awready,
    m0_axi_lite_awvalid,
    m0_axi_lite_bready,
    m0_axi_lite_bresp,
    m0_axi_lite_bvalid,
    m0_axi_lite_rdata,
    m0_axi_lite_rready,
    m0_axi_lite_rresp,
    m0_axi_lite_rvalid,
    m0_axi_lite_wdata,
    m0_axi_lite_wready,
    m0_axi_lite_wstrb,
    m0_axi_lite_wvalid,
    m_axi_lite_aclk,
    m_axi_lite_aresetn,
    zynq_req_0);
  input UART_0_0_rxd;
  output UART_0_0_txd;
  inout [14:0]ddr_addr;
  inout [2:0]ddr_ba;
  inout ddr_cas_n;
  inout ddr_ck_n;
  inout ddr_ck_p;
  inout ddr_cke;
  inout ddr_cs_n;
  inout [3:0]ddr_dm;
  inout [31:0]ddr_dq;
  inout [3:0]ddr_dqs_n;
  inout [3:0]ddr_dqs_p;
  inout ddr_odt;
  inout ddr_ras_n;
  inout ddr_reset_n;
  inout ddr_we_n;
  output dsp_io_0;
  input [15:0]ema_a_0;
  input [1:0]ema_ba_0;
  input ema_clk_p_0;
  input ema_csn_0;
  input [15:0]ema_d_i_0;
  output [15:0]ema_d_o_0;
  input ema_oen_0;
  input ema_wen_0;
  input [1:0]ema_wen_dqm_0;
  output fclk0_aclk;
  output fclk0_resetn;
  inout fixed_io_ddr_vrn;
  inout fixed_io_ddr_vrp;
  inout [53:0]fixed_io_mio;
  inout fixed_io_ps_clk;
  inout fixed_io_ps_porb;
  inout fixed_io_ps_srstb;
  output [31:0]m0_axi_lite_araddr;
  output [2:0]m0_axi_lite_arprot;
  input m0_axi_lite_arready;
  output m0_axi_lite_arvalid;
  output [31:0]m0_axi_lite_awaddr;
  output [2:0]m0_axi_lite_awprot;
  input m0_axi_lite_awready;
  output m0_axi_lite_awvalid;
  output m0_axi_lite_bready;
  input [1:0]m0_axi_lite_bresp;
  input m0_axi_lite_bvalid;
  input [31:0]m0_axi_lite_rdata;
  output m0_axi_lite_rready;
  input [1:0]m0_axi_lite_rresp;
  input m0_axi_lite_rvalid;
  output [31:0]m0_axi_lite_wdata;
  input m0_axi_lite_wready;
  output [3:0]m0_axi_lite_wstrb;
  output m0_axi_lite_wvalid;
  input m_axi_lite_aclk;
  input m_axi_lite_aresetn;
  output zynq_req_0;

  wire UART_0_0_rxd;
  wire UART_0_0_txd;
  wire [14:0]ddr_addr;
  wire [2:0]ddr_ba;
  wire ddr_cas_n;
  wire ddr_ck_n;
  wire ddr_ck_p;
  wire ddr_cke;
  wire ddr_cs_n;
  wire [3:0]ddr_dm;
  wire [31:0]ddr_dq;
  wire [3:0]ddr_dqs_n;
  wire [3:0]ddr_dqs_p;
  wire ddr_odt;
  wire ddr_ras_n;
  wire ddr_reset_n;
  wire ddr_we_n;
  wire dsp_io_0;
  wire [15:0]ema_a_0;
  wire [1:0]ema_ba_0;
  wire ema_clk_p_0;
  wire ema_csn_0;
  wire [15:0]ema_d_i_0;
  wire [15:0]ema_d_o_0;
  wire ema_oen_0;
  wire ema_wen_0;
  wire [1:0]ema_wen_dqm_0;
  wire fclk0_aclk;
  wire fclk0_resetn;
  wire fixed_io_ddr_vrn;
  wire fixed_io_ddr_vrp;
  wire [53:0]fixed_io_mio;
  wire fixed_io_ps_clk;
  wire fixed_io_ps_porb;
  wire fixed_io_ps_srstb;
  wire [31:0]m0_axi_lite_araddr;
  wire [2:0]m0_axi_lite_arprot;
  wire m0_axi_lite_arready;
  wire m0_axi_lite_arvalid;
  wire [31:0]m0_axi_lite_awaddr;
  wire [2:0]m0_axi_lite_awprot;
  wire m0_axi_lite_awready;
  wire m0_axi_lite_awvalid;
  wire m0_axi_lite_bready;
  wire [1:0]m0_axi_lite_bresp;
  wire m0_axi_lite_bvalid;
  wire [31:0]m0_axi_lite_rdata;
  wire m0_axi_lite_rready;
  wire [1:0]m0_axi_lite_rresp;
  wire m0_axi_lite_rvalid;
  wire [31:0]m0_axi_lite_wdata;
  wire m0_axi_lite_wready;
  wire [3:0]m0_axi_lite_wstrb;
  wire m0_axi_lite_wvalid;
  wire m_axi_lite_aclk;
  wire m_axi_lite_aresetn;
  wire zynq_req_0;

  system_bd system_bd_i
       (.UART_0_0_rxd(UART_0_0_rxd),
        .UART_0_0_txd(UART_0_0_txd),
        .ddr_addr(ddr_addr),
        .ddr_ba(ddr_ba),
        .ddr_cas_n(ddr_cas_n),
        .ddr_ck_n(ddr_ck_n),
        .ddr_ck_p(ddr_ck_p),
        .ddr_cke(ddr_cke),
        .ddr_cs_n(ddr_cs_n),
        .ddr_dm(ddr_dm),
        .ddr_dq(ddr_dq),
        .ddr_dqs_n(ddr_dqs_n),
        .ddr_dqs_p(ddr_dqs_p),
        .ddr_odt(ddr_odt),
        .ddr_ras_n(ddr_ras_n),
        .ddr_reset_n(ddr_reset_n),
        .ddr_we_n(ddr_we_n),
        .dsp_io_0(dsp_io_0),
        .ema_a_0(ema_a_0),
        .ema_ba_0(ema_ba_0),
        .ema_clk_p_0(ema_clk_p_0),
        .ema_csn_0(ema_csn_0),
        .ema_d_i_0(ema_d_i_0),
        .ema_d_o_0(ema_d_o_0),
        .ema_oen_0(ema_oen_0),
        .ema_wen_0(ema_wen_0),
        .ema_wen_dqm_0(ema_wen_dqm_0),
        .fclk0_aclk(fclk0_aclk),
        .fclk0_resetn(fclk0_resetn),
        .fixed_io_ddr_vrn(fixed_io_ddr_vrn),
        .fixed_io_ddr_vrp(fixed_io_ddr_vrp),
        .fixed_io_mio(fixed_io_mio),
        .fixed_io_ps_clk(fixed_io_ps_clk),
        .fixed_io_ps_porb(fixed_io_ps_porb),
        .fixed_io_ps_srstb(fixed_io_ps_srstb),
        .m0_axi_lite_araddr(m0_axi_lite_araddr),
        .m0_axi_lite_arprot(m0_axi_lite_arprot),
        .m0_axi_lite_arready(m0_axi_lite_arready),
        .m0_axi_lite_arvalid(m0_axi_lite_arvalid),
        .m0_axi_lite_awaddr(m0_axi_lite_awaddr),
        .m0_axi_lite_awprot(m0_axi_lite_awprot),
        .m0_axi_lite_awready(m0_axi_lite_awready),
        .m0_axi_lite_awvalid(m0_axi_lite_awvalid),
        .m0_axi_lite_bready(m0_axi_lite_bready),
        .m0_axi_lite_bresp(m0_axi_lite_bresp),
        .m0_axi_lite_bvalid(m0_axi_lite_bvalid),
        .m0_axi_lite_rdata(m0_axi_lite_rdata),
        .m0_axi_lite_rready(m0_axi_lite_rready),
        .m0_axi_lite_rresp(m0_axi_lite_rresp),
        .m0_axi_lite_rvalid(m0_axi_lite_rvalid),
        .m0_axi_lite_wdata(m0_axi_lite_wdata),
        .m0_axi_lite_wready(m0_axi_lite_wready),
        .m0_axi_lite_wstrb(m0_axi_lite_wstrb),
        .m0_axi_lite_wvalid(m0_axi_lite_wvalid),
        .m_axi_lite_aclk(m_axi_lite_aclk),
        .m_axi_lite_aresetn(m_axi_lite_aresetn),
        .zynq_req_0(zynq_req_0));
endmodule
