module apb_uart#(
parameter   FCLK      = 100000000
)(
    input  wire         aclk     ,
    input  wire         aresetn  ,
    input  wire  [ 7:0] drpaddr  ,
    input  wire  [31:0] drpwdata ,
    output wire  [31:0] drprdata ,
    input  wire         drpwen   ,
    input  wire         drpren   ,
    output wire         drprdy   ,
    output wire  [ 7:0] id       ,
    output wire         req      ,
    input  wire         enable   ,
    output wire         intr     ,
    input  wire         rxd      ,
    output wire         txd
);
localparam  BAND      = 9600   ;
localparam  RBUF_ADDR = 8'h00  ;
localparam  SBUF_ADDR = 8'h04  ;
localparam  STAT_ADDR = 8'h08  ;
localparam  SCON_ADDR = 8'h0c  ;
localparam  PRES_ADDR = 8'h10  ;
localparam  ID_ADDR   = 8'h14  ;
wire        sbuf_wen           ;
wire        scon_wen           ;
wire        scon_ren           ;
wire        pres_wen           ;
wire        pres_ren           ;
wire        stat_ren           ;
wire        rbuf_ren           ;

assign      sbuf_wen = drpwen & (drpaddr == SBUF_ADDR) ;
assign      scon_wen = drpwen & (drpaddr == SCON_ADDR) ;
assign      scon_ren = drpren & (drpaddr == SCON_ADDR) ;
assign      pres_wen = drpwen & (drpaddr == PRES_ADDR) ;
assign      pres_ren = drpren & (drpaddr == PRES_ADDR) ;
assign      stat_ren = drpren & (drpaddr == STAT_ADDR) ;
assign      rbuf_ren = drpren & (drpaddr == RBUF_ADDR) ;
assign      id_wen   = drpren & (drpaddr == ID_ADDR) ;
assign      id_ren   = drpren & (drpaddr == ID_ADDR) ;

wire        snd_fifo_tready    ;
wire        snd_fifo_empty     ;
wire        snd_fifo_tvalid    ;
wire        rcv_fifo_tready    ;
wire        rcv_fifo_tvalid    ;
wire [ 7:0] rcv_fifo_tdata     ;
reg  [11:0] rcnt    = 'd0;
reg  [11:0] scnt    = 'd0;
reg         int_en  = 'd0;

always @( posedge aclk)begin
    if (scon_wen)
        int_en <= drpwdata[4];
end
reg  [ 1:0] snd_buf_aresetn = 'd0;
always @( posedge aclk)begin
    if (~aresetn)
        snd_buf_aresetn <= 'd0;
    else if (scon_wen & drpwdata[0])
        snd_buf_aresetn <= 'd0;
    else
        snd_buf_aresetn <= {snd_buf_aresetn[0],1'd1};
end
reg  [ 1:0] rcvbuf_aresetn = 'd0;
always @( posedge aclk)begin
    if (~aresetn)
        rcvbuf_aresetn <= 'd0;
    else if (scon_wen & drpwdata[1])
        rcvbuf_aresetn <= 'd0;
    else
        rcvbuf_aresetn <= {rcvbuf_aresetn[0],1'd1};
end
reg  [15:0] presc_data = FCLK/BAND/16-1;
always @( posedge aclk)begin
    if (pres_wen)
        presc_data <= drpwdata[15:0];
end
reg  [ 7:0] id_reg = 'd2;
always @( posedge aclk)begin
    if (id_wen)
        id_reg <= drpwdata[ 7:0];
end
assign  id = id_reg;
//--reg read --------------------------------------------------------//
reg  [31:0] drprdata_reg   = 'd0;
reg         drprdy_reg = 'd0;
always @( posedge aclk)begin
    if (stat_ren)
        drprdata_reg <= {scnt,rcnt,3'd0,int_en,~snd_fifo_tready,snd_fifo_empty,~rcv_fifo_tready,rcv_fifo_tvalid};
    else if (rbuf_ren)
        drprdata_reg <= {24'd0,rcv_fifo_tdata};
    else if(pres_ren)
        drprdata_reg <= {16'd0,presc_data};
    else if(scon_ren)
        drprdata_reg <= {24'd0,3'd0,int_en,4'd0};
    else if(id_ren)
        drprdata_reg <= {24'd0,id_reg};
    drprdy_reg <= stat_ren | rbuf_ren | pres_ren | scon_ren | id_ren; 
end
assign      drprdy   = drprdy_reg;
assign      drprdata = drprdata_reg;
//--uart sample clk-----------------------------------------------------//
reg  [15:0] cnt_presc = 'd0;
always @( posedge aclk)begin
    if (cnt_presc == presc_data)
        cnt_presc <= 'd0;
    else
        cnt_presc <= cnt_presc + 'd1;
end
wire        uart_clk_pos       ;
assign      uart_clk_pos = (cnt_presc == presc_data);
//--sending-------------------------------------------------------------//
wire        snd_start       ;
wire        snd_stop        ;
wire [ 7:0] snd_fifo_tdata  ;
axis_d16_w8_to_r8 axis_d16_w8_to_r8_u0(
    .aclk          ( aclk               ),
    .aresetn       ( snd_buf_aresetn[1] ),
    .full          (                    ),
    .counter       (                 ),  
    .s_axis_tready ( snd_fifo_tready    ),
    .s_axis_tvalid ( sbuf_wen           ),
    .s_axis_tdata  ( drpwdata[7:0]      ),
    .s_axis_tlast  ( 'd0                ),
    .m_axis_tready ( snd_start          ),
    .m_axis_tvalid ( snd_fifo_tvalid    ),
    .m_axis_tdata  ( snd_fifo_tdata     ),
    .m_axis_tlast  (                    )
);
reg         sending = 'd0;
always @( posedge aclk)begin
    if (~aresetn)
        sending <= 'd0;
    else if (snd_start)
        sending <= 'd1;
    else if (snd_stop)
        sending <= 'd0;
end
assign      snd_fifo_empty = (~snd_fifo_tvalid) & (~sending);
reg  [ 3:0] snd_cnt            = 'd0;
wire        snd_cnt_pos  ;
assign      snd_start = snd_fifo_tvalid & (~sending) & enable;
assign      snd_stop  = ((snd_cnt == 4'h9) & snd_cnt_pos);
assign      req = snd_fifo_tvalid | sending;
// prescaler sending
reg  [ 3:0] snd_presc = 'd0;
always @( posedge aclk)begin
    if (snd_start)
        snd_presc     <= 'd0;
    else if (sending & uart_clk_pos)begin
        if (snd_presc == 4'hf)
            snd_presc <= 'd0;
        else
            snd_presc <= snd_presc + 'd1;
    end
end

assign      snd_cnt_pos = sending & (snd_presc == 4'hf) & uart_clk_pos;
always @( posedge aclk)begin
    if (~aresetn)
        snd_cnt <= 4'h0;
    else if (snd_stop)
        snd_cnt <= 4'h0;
    else if (snd_cnt_pos)
        snd_cnt <= snd_cnt + 4'h1;
end
wire        snd_shift          ;
assign      snd_shift = snd_cnt_pos & ((snd_cnt > 4'h0) & (snd_cnt < 4'h8));
reg  [ 7:0] tbuf      = 'd0;
always @( posedge aclk)begin
    if (snd_start)
        tbuf <= snd_fifo_tdata;
    else if (snd_shift)
        tbuf <= {1'b0, tbuf[7:1]};
end
reg         txd_reg = 'd1;
always @( posedge aclk)begin
    if (sending & (snd_cnt == 'd0))
        txd_reg <= 'd0;
    else if (sending & (snd_cnt == 'd9))
        txd_reg <= 'd1;
    else if (sending)
        txd_reg <= tbuf[0];
    else
        txd_reg <= 'd1;
end

assign      txd = txd_reg;
//--receiving-----------------------------------------------------//
// detect falling edge of rxd
reg         receiving = 'd0;
reg  [ 8:0] rxd_seq   = 'd0;
always @( posedge aclk)begin
    if (~aresetn)
        rxd_seq <= 'd0;
    else if (uart_clk_pos)
        rxd_seq <= {rxd_seq[7:0], rxd};
end
wire        rcv_start          ;
wire        rcv_stop           ;
assign      rcv_start = (rxd_seq == 'h100) & (~receiving);               //not receiving or receiving the last bit done
always @( posedge aclk)begin
    if (~aresetn)
        receiving <= 'd0;
    else if (rcv_start)
        receiving <= 'd1;
    else if (rcv_stop)
        receiving <= 'd0;
end
wire        rcv_cnt_pos        ;
reg  [ 3:0] rcv_cnt;
always @( posedge aclk)begin
    if (~aresetn)
        rcv_cnt <= 4'h0;
    else if (rcv_stop)
        rcv_cnt <= 4'h0;
    else if (rcv_cnt_pos)
        rcv_cnt <= rcv_cnt + 4'h1;
end

assign      rcv_stop  = (rcv_cnt == 4'h9) & uart_clk_pos;              // the last bit High
reg  [ 3:0] rcv_presc = 'd0;
always @( posedge aclk)begin
    if (rcv_start)
        rcv_presc     <= 'd0;
    else if (uart_clk_pos)begin
        if (rcv_presc == 4'hf)
            rcv_presc <= 'd0;
        else
            rcv_presc <= rcv_presc + 'd1;
    end
end
assign      rcv_cnt_pos = receiving & (rcv_presc == 4'hf) & uart_clk_pos;//the last only use for one aclk enable
wire        rcv_shift          ;
assign      rcv_shift = rcv_cnt_pos & (rcv_cnt < 4'h8);
reg  [ 7:0] rbuf      = 'd0;
always @( posedge aclk)begin
    if (rcv_shift)
        rbuf <= {rxd, rbuf[7:1]};
end
axis_d16_w8_to_r8 axis_d16_w8_to_r8_u1(
    .aclk          ( aclk               ),
    .aresetn       ( rcvbuf_aresetn[1]  ),
    .counter       (                 ),  
    .full          (                    ),
    .s_axis_tready ( rcv_fifo_tready    ),
    .s_axis_tvalid ( rcv_stop           ),
    .s_axis_tdata  ( rbuf               ),
    .s_axis_tlast  ( 'd0                ),
    .m_axis_tready ( rbuf_ren           ),
    .m_axis_tvalid ( rcv_fifo_tvalid    ),
    .m_axis_tdata  ( rcv_fifo_tdata     ),
    .m_axis_tlast  (                    )
);
always @( posedge aclk)begin
    if(~rcvbuf_aresetn[1])
        rcnt <= 'd0;
    else if (rcv_stop & rcv_fifo_tready & rbuf_ren & rcv_fifo_tvalid)
        rcnt <= rcnt;
    else if (rcv_stop & rcv_fifo_tready)
        rcnt <= rcnt + 'd1;
    else if(rbuf_ren & rcv_fifo_tvalid)
        rcnt <= rcnt - 'd1;
end
always @( posedge aclk)begin
    if(~snd_buf_aresetn[1])
        scnt <= 'd0;
    else if (sbuf_wen & snd_fifo_tready & snd_stop)
        scnt <= scnt;
    else if (sbuf_wen & snd_fifo_tready)
        scnt <= scnt + 'd1;
    else if(snd_stop)
        scnt <= scnt - 'd1;
end
assign      intr = (((~snd_fifo_tvalid) & snd_stop) | rcv_stop) & int_en;
//-------------------------------debug-----------------------------
reg  [ 7:0] debug_rcv_data = 'd0;
reg  [ 7:0] debug_rcv_dif = 'd0;
always @( posedge aclk)begin
    if (rcv_stop)begin
        debug_rcv_data <= rbuf;
        debug_rcv_dif <= rbuf - debug_rcv_data;
    end
end
endmodule
