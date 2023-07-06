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
    // APB Inputs
    PADDR,
    PCLK,
    PENABLE,
    PRESETN,
    PSEL,
    PWDATA,
    PWRITE,
    
    // APB Outputs
    PRDATA,
    PREADY,
    PSLVERR,
    // Controller Outputs
    nCE, 
    CLE, 
    ALE, 
    nWE, 
    nRE, 
    nWP,
    IO
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
output       PREADY;
output       PSLVERR;
output       nCE; 
output       CLE; 
output       ALE; 
output       nWE; 
output       nRE; 
output       nWP;
output [7:0] IO;
//<statements>

endmodule

