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
    
    /* Controller Outputs to Flash  */
    F_nCE, 
    F_CLE, 
    F_ALE, 
    F_nWE, 
    F_nRE, 
    F_nWP,
    F_nRB,
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
output      F_DIO;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [4:0] PADDR;
wire         PENABLE;
wire         PSEL;
wire   [7:0] PWDATA;
wire         PWRITE;
wire         PCLK;
wire         PRESETN;

wire    [7:0]   C_tx_data;
wire    [7:0]   C_rx_data;
wire            C_wr_enable;
wire            C_rd_enable;
wire            C_tx_ready;
wire            C_rx_ready;

/* Control registers and Status register  */
reg     [7:0]   F_DIO;
reg     [15:0]  C_Cmd;
reg     [39:0]  C_Addr;
reg     [7:0]   C_Length;
reg     [7:0]   C_Status;

//<statements>
assign C_wr_enable = (PENABLE && PWRITE && PSEL);
assign C_rd_enable = (!PWRITE && PSEL);
assign PREADY = (C_tx_ready && C_rx_ready && F_nRB);

/* ========== FIFO ========== */
fifo TX_FIFO(
    // Input
    .clk(PCLK),
    .reset(PRESETN),
    .din(PWDATA),
    .write_en(C_wr_enable),
    .read_en(),

    // Output
    .dout(C_tx_data),
    .full(C_tx_ready),
    .empty()
);

fifo RX_FIFO(
    // Input
    .clk(PCLK),
    .reset(PRESETN),
    .din(C_rx_data),
    .write_en(),
    .read_en(C_rd_enable),

    // Output
    .dout(PRDATA),
    .full(C_rx_ready),
    .empty()
);
/* ========== FIFO ========== */

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

