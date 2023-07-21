module NAND_controller(
    /* APB Inputs */
    PADDR,
    PCLK,
    PENABLE,
    PRESETN,
    PSEL,
    PWDATA,
    PWRITE,
    
    /* APB Outputs */
    PRDATA,
    PREADY_S0,
    PSLVERR_S0,
    
    /* Controller Outputs to Flash  */
    F_nCE, 
    F_CLE, 
    F_ALE, 
    F_nWE, 
    F_nRE, 
    F_nWP,
    F_nRB,
    /* Controller Inout  */
    F_DIO
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
/* APB Input */
input  [4:0] PADDR;
input        PCLK;
input        PENABLE;
input        PRESETN;
input        PSEL;
input  [7:0] PWDATA;
input        PWRITE;
/* Flash Input */
input        F_nRB; 

//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
/* APB Output */
output [7:0] PRDATA;
output       PREADY_S0;
output       PSLVERR_S0;
/* Controller Output */
output      F_nCE; 
output      F_CLE; 
output      F_ALE; 
output      F_nWE; 
output      F_nRE; 
output      F_nWP;
/* Controller Inout */
output      F_DIO;

//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------

/* APB wires */
wire   [4:0] PADDR;
wire         PENABLE;
wire         PSEL;
wire   [7:0] PWDATA;
wire         PWRITE;
wire         PCLK;
wire         PRESETN;

/* Controller wires */
wire    [7:0]   C_tx_data;
wire    [7:0]   C_rx_data;
wire            C_wr_enable;
wire            C_rd_enable;
wire            C_tx_ready;
wire            C_rx_ready;

/* Internal signals and array */
reg [2:0]   i_state;
reg [2:0]   i_next_state;
reg [7:0]   i_cmd  [1:0];
reg [7:0]   i_addr [4:0];
reg         icmd_ptr;
reg [2:0]   iaddr_ptr ;

//<statements>
assign C_wr_enable = (PENABLE && PWRITE && PSEL);
assign C_rd_enable = (!PWRITE && PSEL);
assign PREADY = (C_tx_ready && C_rx_ready && F_nRB);
endmodule