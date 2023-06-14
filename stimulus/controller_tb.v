//////////////////////////////////////////////////////////////////////
// Created by Microsemi SmartDesign Tue Jun 13 17:22:46 2023
// Testbench Template
// This is a basic testbench that instantiates your design with basic 
// clock and reset pins connected.  If your design has special
// clock/reset or testbench driver requirements then you should 
// copy this file and modify it. 
//////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: controller_tb.v
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

`timescale 1ns/100ps

module controller_tb;

parameter SYSCLK_PERIOD = 1;// 1000MHZ

/* --- external signals --- */
reg SYSCLK;
reg NSYSRESET;
reg [1:0] type;

wire [7:0] IO_Target, IO_Host;
wire nCE, CLE, ALE, nWE, nRE, nWP;

/* --- internal signals --- */
reg [7:0] buff;
reg [7:0] count;

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
initial begin
    #(SYSCLK_PERIOD * 10 )
    
    type = 2'b00;
    buff = 8'hFF;
    count = 8'b0;
    
end

always @(posedge SYSCLK) begin
    if (buff != 1'bz) begin
        count = count +1;
    end
    if (count % 20 == 0) begin
        buff = buff+1;
    end
    if (count % 50 == 0) begin
        type = type+1;
    end
end

assign IO_Host = buff;
//////////////////////////////////////////////////////////////////////
// Clock Driver
//////////////////////////////////////////////////////////////////////
always @(SYSCLK)
    #(SYSCLK_PERIOD / 2.0) SYSCLK <= !SYSCLK;


//////////////////////////////////////////////////////////////////////
// Instantiate Unit Under Test:  MT29F8G08ABACAWP
//////////////////////////////////////////////////////////////////////
MT29F8G08ABACAWP MT29F8G08ABACAWP_0 (
    // Inputs
    .RB(),
    .nRST(NSYSRESET),

    // Outputs
    .nCE(nCE),
    .CLE(CLE),
    .ALE(ALE),
    .nWE(nWE),
    .nRE(nRE),
    .nWP(nWP),
    .TYPE(type),

    // Inouts
    .IOH( IO_Host ),
    .IOT( IO_Target )

);

endmodule

