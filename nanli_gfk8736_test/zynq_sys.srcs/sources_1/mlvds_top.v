module mlvds_top(
    input  wire         aclk     ,
    input  wire         aresetn  ,
    input  wire  [ 7:0] drpaddr  ,
    input  wire  [31:0] drpwdata ,
    output wire  [31:0] drprdata ,
    input  wire         drpwen   ,
    input  wire         drpren   ,
    output wire         drprdy   ,
    output wire         de       ,
    output wire         re       ,
    input  wire         rxd      ,
    output wire         txd
);
wire        req;
wire        txd1;
wire        rxd1;
wire [ 7:0] id;
apb_uart apb_uart_u0(
    .aclk     ( aclk     ),
    .aresetn  ( aresetn  ),
    .drpaddr  ( drpaddr  ),
    .drpwen   ( drpwen   ),
    .drpwdata ( drpwdata ),
    .drpren   ( drpren   ),
    .drprdy   ( drprdy   ),
    .drprdata ( drprdata ),
    .intr     (          ),
    .id       ( id       ),
    .req      ( req      ),
    .enable   ( de       ),
    .rxd      ( rxd1     ),
    .txd      ( txd1     )
);
mlvds_arbter mlvds_arbter_u0(
    .aclk     ( aclk     ),
    .aresetn  ( aresetn  ),
    .id       ( id       ),
    .de       ( de       ),
    .re       ( re       ),
    .req      ( req      ),    
    .txd1     ( txd1     ),
    .rxd1     ( rxd1     ),
    .txd      ( txd      ),
    .rxd      ( rxd      )
);   
endmodule
