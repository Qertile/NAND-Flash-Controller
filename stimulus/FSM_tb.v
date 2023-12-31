
`timescale 1ns/100ps

module FSM_tb;

parameter SYSCLK_PERIOD = 1;// 100MHZ

/* --- external signals --- */
reg SYSCLK;
reg NSYSRESET;

// /* APB Inputs */
// reg       P_clk;
// reg       P_nrst;

/* Controller Inputs */
reg [7:0]  C_Cmd;
reg [7:0]  C_Addr;
reg [7:0]  C_Length;
reg [7:0]  C_Status;
reg [7:0]  C_WrData;
reg        F_nRB; 


/* Controller output */
wire        F_nCE; 
wire        F_CLE; 
wire        F_ALE; 
wire        F_nWE; 
wire        F_nRE; 
wire        F_nWP;
wire [7:0]  C_RdData;
wire [7:0]  F_DIO;


initial
begin
    SYSCLK = 1'b0;
    NSYSRESET = 1'b0;
end

//////////////////////////////////////////////////////////////////////
// Reset Pulse
//////////////////////////////////////////////////////////////////////
initial
begin
    NSYSRESET = 1'b1;
    #(SYSCLK_PERIOD * 5 )
    NSYSRESET = 1'b0;
    #(SYSCLK_PERIOD * 5 )
    NSYSRESET = 1'b1;
end

//////////////////////////////////////////////////////////////////////
// Host Simulator
//////////////////////////////////////////////////////////////////////

/* Command Signal */
initial begin
    #(SYSCLK_PERIOD * 40 )
    C_Cmd = 8'h60;
    #(SYSCLK_PERIOD * 2 )
    C_Cmd = 8'hD0;
end

/* Address Signal */
initial begin
    #(SYSCLK_PERIOD * 40 )
    C_Addr = 8'hA0;
    #(SYSCLK_PERIOD * 2 )
    C_Addr = 8'hA1;
    #(SYSCLK_PERIOD * 2 )
    C_Addr = 8'hA2;
    // #(SYSCLK_PERIOD * 2 )
    // C_Addr = 8'hA3;
    // #(SYSCLK_PERIOD * 2 )
    // C_Addr = 8'hA4;
end

/* Data Signal */
// initial begin
//     #(SYSCLK_PERIOD * 40 )
//     C_WrData = 8'h94;
//     C_Length = 8'h08;
//     #(SYSCLK_PERIOD * 2 )
//     C_WrData = 8'h87;
//     #(SYSCLK_PERIOD * 2 )
//     C_WrData = 8'h94;
//     #(SYSCLK_PERIOD * 2 )
//     C_WrData = 8'h78;
//     #(SYSCLK_PERIOD * 2 )
//     C_WrData = 8'hAA;
//     #(SYSCLK_PERIOD * 2 )
//     C_WrData = 8'hAB;
//     #(SYSCLK_PERIOD * 2 )
//     C_WrData = 8'hAC;
//     #(SYSCLK_PERIOD * 2 )
//     C_WrData = 8'hAD;
//     #(SYSCLK_PERIOD * 2 )
//     C_WrData = 8'hAE;
//     #(SYSCLK_PERIOD * 2 )
//     C_WrData = 8'hAF;
// end

//always @(posedge SYSCLK) begin
//
//
//
//end

//////////////////////////////////////////////////////////////////////
// Clock Driver
//////////////////////////////////////////////////////////////////////
always @(SYSCLK)
    #(SYSCLK_PERIOD / 2.0) SYSCLK <= !SYSCLK;

//////////////////////////////////////////////////////////////////////
// Instantiate Unit Under Test:  fsm
//////////////////////////////////////////////////////////////////////
fsm fsm_0 (
    /* APB Inputs */
    .P_clk(SYSCLK),
    .P_nrst(NSYSRESET),

    /* Controller Inputs */
    .C_Cmd(C_Cmd),
    .C_Addr(C_Addr),
    .C_Length(C_Length),
    .C_Status(C_Status),
    .C_RdData(C_RdData),
    .C_WrData(C_WrData),
    
    /* Controller Outputs */
    .F_nCE(F_nCE), 
    .F_CLE(F_CLE), 
    .F_ALE(F_ALE), 
    .F_nWE(F_nWE), 
    .F_nRE(F_nRE), 
    .F_nWP(F_nWP),
    .F_nRB(F_nRB),
    /* Controller I/O */
    .F_DIO(F_DIO)
);

endmodule

