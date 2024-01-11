`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/15 11:35:26
// Design Name: 
// Module Name: zynq_dsp_emif
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module zynq_dsp_emif(
    input           aclk                ,
    input           ema_clk_p           ,
    input           reset               ,
    input [ 5:2 ]   ema_csn             ,
    input [ 1:0 ]   ema_ba              ,
    input [15:0 ]   ema_a               ,
    input [ 1:0 ]   ema_wen_dqm         ,
//    input           ema_a_rwn           ,
    input           ema_oen             ,
    output [15:0 ]   ema_d_o             ,
    input [15:0 ]   ema_d_i             ,
    input           ema_wen             ,
//  input           mlvds_rx            ,//mlvds_rx			U7
//	output          mlvds_de            ,//mlvds_de			V5
//	output          mlvds_re            ,//mlvds_de			U10
//  output          mlvds_tx            ,//mlvds_tx			V7
    output          rxff_dsp_zynq_empty ,
    input           rxff_dsp_zynq_rd_en , 
    output [31:0 ]  rxff_dsp_zynq_dout  ,
    input  [31:0 ]  txff_zynq_dsp_din   ,
    input           txff_zynq_dsp_wr_en ,
    output          txff_zynq_dsp_full  
    );

//parameter
localparam  W16 = 16                    ;
//variable
wire                eclk                ;
reg     [15:0 ]     ema_rd_addr         ;
reg     [15:0 ]     ema_rd_data         ;
wire    [15:0 ]     ema_wr_data_w       ;
wire    [31:0 ]     txff_zynq_dsp_do    ;
reg     [15:0 ]     reg3_w              ;
reg                 txff_zynq_dsp_rd_flag   ;
reg                 txff_zynq_dsp_rden_flag ;
reg                 ema_oen_d1          ;
reg                 ema_oen_d2          ;
reg                 ema_oen_pos         ;
wire                txff_zynq_dsp_rd_en ;
wire                txff_zynq_dsp_empty ;
wire                rxff_dsp_zynq_full  ;


//main
assign eclk             =   ema_clk_p       ;
assign ema_d_o          =   ema_rd_data     ;
assign ema_wr_data_w    =   ema_d_i         ;

//zynq --> dsp
always@(posedge eclk) begin
    ema_oen_d1  <=  ema_oen         ;
    ema_oen_d2  <=  ema_oen_d1      ;
end

always@(posedge eclk) begin
    ema_oen_pos <=  !ema_oen_d2 && ema_oen_d1   ;
end

assign  txff_zynq_dsp_rd_en     =   ema_oen_pos ;

always@(posedge eclk) begin
    if (!ema_csn && !ema_oen) begin
        ema_rd_addr     <=  ema_a   ;
    end
end

always@(posedge eclk) begin
    case (ema_rd_addr)
    'h2 :   begin
                txff_zynq_dsp_rd_flag       <= 1'b1     ;
                txff_zynq_dsp_rden_flag     <= 1'b0     ;
            end
    'h3 :   begin
                txff_zynq_dsp_rd_flag       <= 1'b0     ;
                txff_zynq_dsp_rden_flag     <= 1'b1     ;
            end
        default: begin
            txff_zynq_dsp_rd_flag       <= 1'b0     ;
            txff_zynq_dsp_rden_flag     <= 1'b0     ;
        end
    endcase
end

always@(posedge eclk) begin
    reg3_w  =   {14'h0,!rxff_dsp_zynq_full,txff_zynq_dsp_empty};
end

always@(posedge eclk) begin
    if (!ema_csn && !ema_oen && txff_zynq_dsp_rd_flag) begin
        ema_rd_data     <=  txff_zynq_dsp_do[0+:W16]    ;
    end else if (!ema_csn && !ema_oen && txff_zynq_dsp_rden_flag) begin
        ema_rd_data     <=  reg3_w    ;
    end
end

fifo_zynq_dsp u0_fifo_zynq_dsp (
    .rst                (reset                  ),        // input wire rst
    .wr_clk             (aclk                   ),  // input wire wr_clk
    .rd_clk             (eclk                   ),  // input wire rd_clk
    .din                (txff_zynq_dsp_din      ),        // input wire [31 : 0] din
    .wr_en              (txff_zynq_dsp_wr_en    ),    // input wire wr_en
    .rd_en              (txff_zynq_dsp_rd_en    ),    // input wire rd_en
    .dout               (txff_zynq_dsp_do       ),      // output wire [31 : 0] dout
    .full               (txff_zynq_dsp_full     ),      // output wire full
    .empty              (txff_zynq_dsp_empty    )    // output wire empty
);

//dsp --> zynq
wire    [31:0 ]     rxff_dsp_zynq_di            ;
reg     [15:0 ]     ema_wr_addr                 ;
reg     [15:0 ]     ema_wr_data                 ;
reg                 rxff_dsp_zynq_wr_en_pre1    ;
reg                 rxff_dsp_zynq_wr_en_pre2    ;
reg                 rxff_dsp_zynq_wr_en_pre3    ;
reg                 rxff_dsp_zynq_wr_en         ;

always@(posedge eclk) begin
    if (!ema_csn && !ema_wen) begin
        ema_wr_addr     <=  ema_a               ;
    end
end

always@(posedge eclk) begin
    if (!ema_csn && !ema_wen) begin
        ema_wr_data     <=  ema_wr_data_w       ;
    end
end

assign  rxff_dsp_zynq_di    =   {ema_wr_addr,ema_wr_data}   ;

always@(posedge eclk) begin
    rxff_dsp_zynq_wr_en_pre1    <= (!ema_csn && !ema_wen) ;
    rxff_dsp_zynq_wr_en_pre2    <=  rxff_dsp_zynq_wr_en_pre1            ;
    rxff_dsp_zynq_wr_en_pre3    <=  rxff_dsp_zynq_wr_en_pre2            ;
end

always@(posedge eclk) begin
    rxff_dsp_zynq_wr_en     <= rxff_dsp_zynq_wr_en_pre3 && !rxff_dsp_zynq_wr_en_pre2 ;
end

    fifo_dsp_zynq u0_fifo_dsp_zynq (
        .rst                (reset                  ),        // input wire rst
        .wr_clk             (eclk                   ),  // input wire wr_clk
        .rd_clk             (aclk                   ),  // input wire rd_clk
        .din                (rxff_dsp_zynq_di       ),        // input wire [31 : 0] din
        .wr_en              (rxff_dsp_zynq_wr_en    ),    // input wire wr_en
        .rd_en              (rxff_dsp_zynq_rd_en    ),    // input wire rd_en
        .dout               (rxff_dsp_zynq_dout     ),      // output wire [31 : 0] dout
        .full               (rxff_dsp_zynq_full     ),      // output wire full
        .empty              (rxff_dsp_zynq_empty    )    // output wire empty
      );



endmodule
