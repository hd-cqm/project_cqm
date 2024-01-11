module mlvds_arbter(
    input  wire         aclk    ,
    input  wire         aresetn ,
    output wire         de      ,
    output wire         re      ,
    input  wire  [ 7:0] id      ,
    input  wire         req     ,
    input  wire         txd1    ,
    output wire         rxd1    ,
    input  wire         rxd     ,
    output wire         txd
);
reg         grant_arbter = 'd0;
wire        flag_10ms ;
reg  [19:0] cnt_10ms = 'd0;
always @( posedge aclk)begin
    if (grant_arbter)
        cnt_10ms <= {8'd0,id,4'd0};
    else if (~rxd)
        cnt_10ms <= {8'd0,id,4'd0};
    else if (~flag_10ms)
        cnt_10ms <= cnt_10ms + 'd1;
end
assign      flag_10ms = (cnt_10ms > 20'hffff0);
always @( posedge aclk)begin
    if (~aresetn)
        grant_arbter <= 'd0;
    else if (flag_10ms & req)
        grant_arbter <= 'd1;
    else if (~req)
        grant_arbter <= 'd0;
end


assign      txd  = txd1;
assign      rxd1 = grant_arbter | rxd;
assign      de   = grant_arbter;
assign      re   = 1'b0;
endmodule
