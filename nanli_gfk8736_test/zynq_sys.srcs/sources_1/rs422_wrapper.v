module rs422_wrapper(
    input  wire         aclk     ,
    input  wire         aresetn  ,
    input  wire  [15:0] drpaddr  ,
    input  wire  [31:0] drpwdata ,
    output wire  [31:0] drprdata ,
    input  wire         drpwen   ,
    input  wire         drpren   ,
    output wire         drprdy   ,
    input  wire  [ 2:0] rxd      ,
    output wire  [ 2:0] txd
);
wire [ 3:0] rs422_drprdy    ;
wire [127:0] rs422_drprdata ;
apb_uart apb_uart_u0(
    .aclk     ( aclk                                 ),
    .aresetn  ( aresetn                              ),
    .drpaddr  ( drpaddr[7:0]                         ),
    .drpwen   ( drpwen & ( drpaddr[15:8] == 'h18 ) ),
    .drpwdata ( drpwdata                             ),
    .drpren   ( drpren & ( drpaddr[15:8] == 'h18 ) ),
    .drprdy   ( rs422_drprdy[0]                         ),
    .drprdata ( rs422_drprdata[32*0+:32]                ),
    .intr     (                                      ),
    .req      (                                      ),
    .enable   ( 1'd1                                 ),
    .rxd      ( rxd[0]                               ),
    .txd      ( txd[0]                               )
);
apb_uart apb_uart_u1(
    .aclk     ( aclk                                 ),
    .aresetn  ( aresetn                              ),
    .drpaddr  ( drpaddr[7:0]                         ),
    .drpwen   ( drpwen & ( drpaddr[15:8] == 'h19 ) ),
    .drpwdata ( drpwdata                             ),
    .drpren   ( drpren & ( drpaddr[15:8] == 'h19 ) ),
    .drprdy   ( rs422_drprdy[1]                         ),
    .drprdata ( rs422_drprdata[32*1+:32]                ),
    .intr     (                                      ),
    .req      (                                      ),
    .enable   ( 1'd1                                 ),
    .rxd      ( rxd[1]                               ),
    .txd      ( txd[1]                               )
);
apb_uart apb_uart_u2(
    .aclk     ( aclk                                 ),
    .aresetn  ( aresetn                              ),
    .drpaddr  ( drpaddr[7:0]                         ),
    .drpwen   ( drpwen & ( drpaddr[15:8] == 'h1a ) ),
    .drpwdata ( drpwdata                             ),
    .drpren   ( drpren & ( drpaddr[15:8] == 'h1a ) ),
    .drprdy   ( rs422_drprdy[2]                         ),
    .drprdata ( rs422_drprdata[32*2+:32]                ),
    .intr     (                                      ),
    .req      (                                      ),
    .enable   ( 1'd1                                 ),
    .rxd      ( rxd[2]                               ),
    .txd      ( txd[2]                               )
);
apb_uart apb_uart_u3(
    .aclk     ( aclk                                 ),
    .aresetn  ( aresetn                              ),
    .drpaddr  ( drpaddr[7:0]                         ),
    .drpwen   ( drpwen & ( drpaddr[15:8] == 'h1b ) ),
    .drpwdata ( drpwdata                             ),
    .drpren   ( drpren & ( drpaddr[15:8] == 'h1b ) ),
    .drprdy   ( rs422_drprdy[3]                         ),
    .drprdata ( rs422_drprdata[32*3+:32]                ),
    .intr     (                                      ),
    .req      (                                      ),
    .enable   ( 1'd1                                 ),
    .rxd      ( rxd[3]                               ),
    .txd      ( txd[3]                               )
);
reg         drprdy_reg   = 'd0;
reg  [31:0] drprdata_reg = 'd0;
always @( posedge aclk)begin
    if (rs422_drprdy[0])
        drprdata_reg <= rs422_drprdata[32*0+:32];
    else if (rs422_drprdy[1])
        drprdata_reg <= rs422_drprdata[32*1+:32];
    else if (rs422_drprdy[2])
        drprdata_reg <= rs422_drprdata[32*2+:32];
    else if (rs422_drprdy[3])
        drprdata_reg <= rs422_drprdata[32*3+:32];
    drprdy_reg       <= | rs422_drprdy;
end

assign      drprdy   = drprdy_reg;
assign      drprdata = drprdata_reg;
endmodule
