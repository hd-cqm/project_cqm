module axi_lite_to_drp_wrapper#(
parameter   N  = 0         ,
parameter   W1 = (N+1)*16-1,
parameter   W2 = (N+1)*32-1
)(
    input  wire         aclk               ,
    input  wire         aresetn            ,
    input  wire  [31:0] s_axi_lite_awaddr  ,
    input  wire  [ 2:0] s_axi_lite_awprot  ,
    output wire  [ 0:0] s_axi_lite_awready ,
    input  wire  [ 0:0] s_axi_lite_awvalid ,
    output wire  [ 0:0] s_axi_lite_wready  ,
    input  wire  [31:0] s_axi_lite_wdata   ,
    input  wire  [ 3:0] s_axi_lite_wstrb   ,
    input  wire  [ 0:0] s_axi_lite_wvalid  ,
    input  wire  [ 0:0] s_axi_lite_bready  ,
    output wire  [ 1:0] s_axi_lite_bresp   ,
    output wire  [ 0:0] s_axi_lite_bvalid  ,
    input  wire  [31:0] s_axi_lite_araddr  ,
    input  wire  [ 2:0] s_axi_lite_arprot  ,
    output wire  [ 0:0] s_axi_lite_arready ,
    input  wire  [ 0:0] s_axi_lite_arvalid ,
    input  wire  [ 0:0] s_axi_lite_rready  ,
    output wire  [ 1:0] s_axi_lite_rresp   ,
    output wire  [31:0] s_axi_lite_rdata   ,
    output wire  [ 0:0] s_axi_lite_rvalid  ,
    output wire  [15:0] apb_drpaddr        ,
    output wire         apb_drpwen         ,
    output wire  [31:0] apb_drpwdata       ,
    output wire         apb_drpren         ,
    input  wire         apb_drprdy         ,
    input  wire  [31:0] apb_drprdata
);
axi_lite_to_apb register_u0 (
    .aclk               ( aclk               ),
    .aresetn            ( aresetn            ),
    .s_axi_lite_awaddr  ( s_axi_lite_awaddr  ),
    .s_axi_lite_awprot  ( s_axi_lite_awprot  ),
    .s_axi_lite_awready ( s_axi_lite_awready ),
    .s_axi_lite_awvalid ( s_axi_lite_awvalid ),
    .s_axi_lite_wdata   ( s_axi_lite_wdata   ),
    .s_axi_lite_wready  ( s_axi_lite_wready  ),
    .s_axi_lite_wstrb   ( s_axi_lite_wstrb   ),
    .s_axi_lite_wvalid  ( s_axi_lite_wvalid  ),
    .s_axi_lite_bready  ( s_axi_lite_bready  ),
    .s_axi_lite_bresp   ( s_axi_lite_bresp   ),
    .s_axi_lite_bvalid  ( s_axi_lite_bvalid  ),
    .s_axi_lite_araddr  ( s_axi_lite_araddr  ),
    .s_axi_lite_arprot  ( s_axi_lite_arprot  ),
    .s_axi_lite_arready ( s_axi_lite_arready ),
    .s_axi_lite_arvalid ( s_axi_lite_arvalid ),
    .s_axi_lite_rdata   ( s_axi_lite_rdata   ),
    .s_axi_lite_rready  ( s_axi_lite_rready  ),
    .s_axi_lite_rresp   ( s_axi_lite_rresp   ),
    .s_axi_lite_rvalid  ( s_axi_lite_rvalid  ),
    .drpaddr            ( apb_drpaddr        ),
    .drpwen             ( apb_drpwen         ),
    .drpwdata           ( apb_drpwdata       ),
    .drpren             ( apb_drpren         ),
    .drprdy             ( apb_drprdy         ),
    .drprdata           ( apb_drprdata       )
);
endmodule
