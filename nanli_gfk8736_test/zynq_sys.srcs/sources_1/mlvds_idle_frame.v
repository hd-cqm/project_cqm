module mlvds_idle_frame(
    input  wire         aclk    ,
    input  wire         aresetn ,
    input  wire  [ 7:0] id      ,
    input  wire         tpos    ,
    output wire         tvalid  ,
    output wire         tdata   ,
    input  wire         de1     ,
    input  wire         txd1    ,
    output wire         rxd1    ,
    output wire         txd     ,
    input  wire         rxd     ,
    output wire         de      ,
    output wire         re
);
reg  [ 2:0] snd_cnt = 'd0;
always @( posedge aclk)begin
    if (~aresetn)
        snd_cnt <= 'd0;
    else if (tpos)
        snd_cnt <= 'd0;
    else
        snd_cnt <= snd_cnt + 'd1;
end
reg  [ 9:0] time_cnt = 'd0;
always @( posedge aclk)begin
    if (~aresetn)
        time_cnt <= 'd0;
    else if (tpos)
        time_cnt <= 'd0;
    else if (( & idle) & detect_en)
        time_cnt <= time_cnt + 'd1;
end

assign      detect_en = ~time_cnt[9];
reg  [ 7:0] tbuf      = 'd0;
always @( posedge aclk)begin
    if (tpos)
        tbuf <= id;
    else if ( & snd_cnt)
        tbuf <= {1'b0, tbuf[7:1]};
end
wire        txd0 ;
assign      txd0     = tbuf[0];
reg         conflict = 'd0;
always @( posedge aclk)begin
    if (tpos)
        conflict <= 'd0;
    else if ((~conflict) & (snd_cnt == 'd4) & detect_en)
        conflict <= rxd ^ txd;
end

assign      tvalid = ~detect_en;
assign      tdata  = conflict;
assign      txd    = detect_en ? txd0:txd1;
assign      rxd1   = de1 | detect_en | rxd;
assign      de     = detect_en | de1;
assign      re     = 'd0;
endmodule
