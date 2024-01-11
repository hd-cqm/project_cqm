module mlvds_arbter0(
    input  wire         aclk     ,
    input  wire         aresetn  ,
    output wire         de       ,
    output wire         re       ,
    input  wire         req      ,
    input  wire         txd1   ,   
    output  wire         rxd1  , 
    input  wire         rxd  , 
    output  wire         txd   
);


wire        idle;
reg  [19:0] wait_cnt = 'd0;
always @( posedge aclk)begin
    if (~rxd)
        wait_cnt <= 'd0;
    else if(conflict_tvalid & conflict_tdata)
        wait_cnt <= 'd0;
    else if(~idle)
        wait_cnt <= wait_cnt + 'd1;
end
assign      idle = (wait_cnt > 'd5000);

wire        snd_wait_gap;
reg         grant_arbter = 'd0;
reg  [19:0] snd_wait_cnt    = 'd0;
always @( posedge aclk)begin
    if (grant_arbter)
        snd_wait_cnt <= 'd0;
    else if(snd_wait_gap)
        snd_wait_cnt <= snd_wait_cnt + 'd1;
end
assign      snd_wait_gap = (snd_wait_cnt < 'd10000);


always @( posedge aclk)begin
    if(~aresetn)
        grant_arbter <= 'd0;
    else if(conflict_tvalid & conflict_tdata)
        grant_arbter <= 'd0;
    else if (idle & req & (~snd_wait_gap))
        grant_arbter <= 'd1;
    else if(~req)
        grant_arbter <= 'd0;
end

reg         snd_enble = 'd0;
always @( posedge aclk)begin
    if(~aresetn)
        snd_enble <= 'd0;
    else if (grant_arbter & conflict_tvalid & (~conflict_tdata))
        snd_enble <= 'd1;
    else if(~req)
        snd_enble <= 'd0;
end

assign      de = snd_enble;
assign      re = 1'b0;

mlvds_idle_frame  mlvds_idle_frame_u0 (
    .aclk   ( aclk        ),
    .aresetn  ( aresetn    ),
    .id   ( id ),
    .tpos ( grant_arbter   ),
    .tvalid ( conflict_tvalid   ),
    .tdata ( conflict_tdata   ),
    .de1  ( snd_enble   ),
    .txd1  ( txd1 ),
    .rxd1  ( rxd1  ),
    .txd ( txd ),
	.rxd ( rxd       ),
    .de ( de ),
	.re ( re       )
);
endmodule
