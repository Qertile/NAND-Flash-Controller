`ifndef _INC_V
`define _INC_V

`define HIGH    1'b1
`define LOW     1'b0

/* ----- command, data, address input (3.3V) ----- 
    based on MT29F8G08ABACAWP datasheet unit in ns
    if (max) define max
    else     define min     
*/
`define T_ADL   7'd70
`define T_ALH   3'd5
`define T_ALS   4'd10
`define T_CH    3'd5
`define T_CLH   3'd5
`define T_CLS   4'd10
`define T_CS    4'd15
`define T_DH    3'd5
`define T_DS    3'd7
`define T_WC    5'd20
`define T_WH    3'd7
`define T_WP    4'd10
`define T_WW    7'd100

/* ----- normal operation (3.3V) ----- 
    based on MT29F8G08ABACAWP datasheet unit in ns
    if (max) define max
    else     define min     
*/
`define T_AR    4'd10
`define T_CEA   5'd25
`define T_CHZ   6'd30
`define T_CLR   4'd10
`define T_COH   4'd15
`define T_RC    5'd20
`define T_REA   5'd16
`define T_REH   3'd7
`define T_RHOH  4'd15
`define T_RHW   7'd100
`define T_RHZ   7'd100
`define T_LOH   3'd5
`define T_RP    4'd10
`define T_RR    5'd20
`define T_RST_R     16'd5000
`define T_RST_P     16'd10000
`define T_RST_E     20'd500000
`define T_WB    7'd100
`define T_WHR   7'd60

/* ----- program / erase operation ----- 
    based on MT29F8G08ABACAWP datasheet unit in us
    if (max) define max
    else     define min     
*/
`define T_NOP   3'd4 // cycle
`define T_BERS  16'd10000
`define T_CBSY  12'd600
`define T_DBSY  1'd1
`define T_RCBSY 5'd25
`define T_FEAT  1'd1
`define T_OBSY  5'd30
`define T_LBSY  5'd3
`define T_PROG  12'd600
`define T_POR   1'd1
`define T_R     5'd25


/* ----- commands ----- 
    based on MT29F8G08ABACAWP datasheet
*/
`define CMD_RESET   8'hFF


`endif