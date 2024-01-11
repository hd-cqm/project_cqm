module mlvds_wrapper(
    input  wire         aclk     ,
    input  wire         aresetn  ,
    input  wire  [15:0] drpaddr  ,
    input  wire  [31:0] drpwdata ,
    output wire  [31:0] drprdata ,
    input  wire         drpwen   ,
    input  wire         drpren   ,
    output wire         drprdy   ,
    output wire  [ 1:0] de       ,
    output wire  [ 1:0] re       ,
    input  wire  [ 1:0] rxd      ,
    output wire  [ 1:0] txd
);
wire [ 1:0] mlvds_drprdy    ;
wire [ 63:0] mlvds_drprdata ;
mlvds_top mlvds_top_u0(
    .aclk     ( aclk                                 ),
    .aresetn  ( aresetn                              ),
    .drpaddr  ( drpaddr[7:0]                         ),
    .drpwen   ( drpwen & ( drpaddr[15:8] == 'h10 ) ),
    .drpwdata ( drpwdata                             ),
    .drpren   ( drpren & ( drpaddr[15:8] == 'h10 ) ),
    .drprdy   ( mlvds_drprdy[0]                      ),
    .drprdata ( mlvds_drprdata[32*0+:32]             ),
    .de       ( de[0]                                ),
    .re       ( re[0]                                ),
    .rxd      ( rxd[0]                               ),
    .txd      ( txd[0]                               )
);
mlvds_top mlvds_top_u1(
    .aclk     ( aclk                                 ),
    .aresetn  ( aresetn                              ),
    .drpaddr  ( drpaddr[7:0]                         ),
    .drpwen   ( drpwen & ( drpaddr[15:8] == 'h11 ) ),
    .drpwdata ( drpwdata                             ),
    .drpren   ( drpren & ( drpaddr[15:8] == 'h11 ) ),
    .drprdy   ( mlvds_drprdy[1]                      ),
    .drprdata ( mlvds_drprdata[32*1+:32]             ),
    .de       ( de[1]                                ),
    .re       ( re[1]                                ),
    .rxd      ( rxd[1]                               ),
    .txd      ( txd[1]                               )
);
reg         drprdy_reg   = 'd0;
reg  [31:0] drprdata_reg = 'd0;
always @( posedge aclk)begin
    if (mlvds_drprdy[0])
        drprdata_reg <= mlvds_drprdata[32*0+:32];
    else if (mlvds_drprdy[1])
        drprdata_reg <= mlvds_drprdata[32*1+:32];
    drprdy_reg       <= | mlvds_drprdy;
end

assign      drprdy   = drprdy_reg;
assign      drprdata = drprdata_reg;
endmodule
