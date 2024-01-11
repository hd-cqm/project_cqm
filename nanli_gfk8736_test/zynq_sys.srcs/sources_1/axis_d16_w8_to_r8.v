module axis_d16_w8_to_r8#(
parameter   FI   = 7,
parameter   L    = 11,
parameter   FCNT = 511
)(
    input  wire         aclk          ,
    input  wire         aresetn       ,
    output wire         full          ,
    output wire  [ L:0] counter       ,
    output wire         s_axis_tready ,
    input  wire         s_axis_tvalid ,
    input  wire  [FI:0] s_axis_tdata  ,
    input  wire         s_axis_tlast  ,
    input  wire         m_axis_tready ,
    output wire         m_axis_tvalid ,
    output wire  [FI:0] m_axis_tdata  ,
    output wire         m_axis_tlast
);
localparam  IA = FI + 1 ;
wire [IA:0] sfifo_idata ;
wire        sfifo_wen   ;
wire        sfifo_ren   ;
wire        sfifo_full  ;
wire        sfifo_empty ;
wire [IA:0] sfifo_odata ;
wire  [ L:0] count;
assign      sfifo_idata   = {s_axis_tlast, s_axis_tdata};
assign      sfifo_wen     = s_axis_tready & s_axis_tvalid;
assign      s_axis_tready = (~sfifo_full) & aresetn;

sfifo_d2k_w9_to_r9  sfifo_d4k_w9_to_r9_u0 (
    .clk   ( aclk        ),
    .srst  ( ~aresetn    ),
    .din   ( sfifo_idata ),
    .wr_en ( sfifo_wen   ),
    .rd_en ( sfifo_ren   ),
    .dout  ( sfifo_odata ),
    .full  ( sfifo_full  ),
    .empty ( sfifo_empty ),
	.data_count ( count       )
);
reg         m_axis_tvalid_reg = 'd0;
reg  [FI:0] m_axis_tdata_reg  = 'd0;
reg         m_axis_tlast_reg  = 'd0;
always @( posedge aclk)begin
    if (~aresetn)
        m_axis_tvalid_reg <= 'd0;
    else if (m_axis_tready | ((~m_axis_tvalid) & (~sfifo_empty)))
        m_axis_tvalid_reg <= sfifo_ren;
end

assign      sfifo_ren     = (m_axis_tready | (~m_axis_tvalid)) & (~sfifo_empty);
assign      m_axis_tvalid = m_axis_tvalid_reg;
assign      m_axis_tdata  = sfifo_odata[FI:0];
assign      m_axis_tlast  = sfifo_odata[IA];

reg     full_reg = 'd0;
always @( posedge aclk)begin
    if (~aresetn)
        full_reg <= 'd0;
    else
        full_reg  <= (count > (FCNT-2));
end
assign      full    = full_reg;
assign      counter = count;

//--debug---------------------------------------------------------------
reg  [FI:0] debug_m_axis_tdata = 'd0;
reg  [FI:0] debug_diff         = 'd0;
always @( posedge aclk)begin
    if (m_axis_tvalid & m_axis_tready)begin
        debug_m_axis_tdata <= m_axis_tdata;
        debug_diff         <= m_axis_tdata - debug_m_axis_tdata;
    end
end
endmodule
