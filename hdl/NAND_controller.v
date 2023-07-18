///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: NAND_controller.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::SmartFusion2> <Die::M2S010> <Package::484 FBGA>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

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
    /* Controller Outputs  */
    nCE, 
    CLE, 
    ALE, 
    nWE, 
    nRE, 
    nWP,
    FLASH_IO
);
//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [4:0] PADDR;
input        PCLK;
input        PENABLE;
input        PRESETN;
input        PSEL;
input  [7:0] PWDATA;
input        PWRITE;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [7:0] PRDATA;
output       PREADY_S0;
output       PSLVERR_S0;
output       nCE; 
output       CLE; 
output       ALE; 
output       nWE; 
output       nRE; 
output       nWP;
output [7:0] FLASH_IO;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [4:0] PADDR;
wire         PENABLE;
wire   [7:0] APB_bif_PRDATA;
wire         APB_bif_PREADY;
wire         PSEL;
wire         APB_bif_PSLVERR;
wire   [7:0] PWDATA;
wire         PWRITE;
wire         PCLK;
wire         PRESETN;
wire   [7:0] APB_bif_PRDATA_net_0;
wire         APB_bif_PREADY_net_0;
wire         APB_bif_PSLVERR_net_0;

wire         wr_enable;
wire         rd_enable;

/* Control registers and Status register  */
reg     [15:0]  Cmd;
reg     [39:0]  Addr;
reg     [7:0]   Length;
reg     [7:0]   Status;

//<statements>
assign wr_enable = (PENABLE && PWRITE && PSEL);
assign rd_enable = (!PWRITE && PSEL);

fifo TX_FIFO;(
    // Input
    .clk(PCLK)
    .reset(PRESETN)
    .din
    .write_en
    .read_en

    // Output
    .dout
    .full
    .empty
)


fifo RX_FIFO;

/* ----- FSM ----- 

if (PADDR == Tx_FIFO_addr){
    FSM = WRITE
}
else if (PADDR == Rx_FIFO_addr){
    FSM = READ
}
else FSM = IDLE

switch (FSM){
    WRITE:
        if (wr_enable){
            PREADY = HIGH

            --- UART_send ---
            ( PWDATA into FIFO )
            
            FIFO to FLASH_IO

            PREADY = LOW
        }
            

    READ:
        if (rd_enable){
            PREADY = HIGH

            ( FIFO to FLASH_IO )
            
            --- UART_get_rx ---
            FIFO into PRDATA
            
            PREADY = LOW
        }

    IDLE:
    
        PREADY = LOW


}






*/



endmodule

