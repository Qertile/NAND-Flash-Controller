`include "inc.v"

`timescale 1ns/100ps

module MT29F8G08ABACAWP (
    nCE, CLE, ALE, nWE, nRE, nWP,
    IOH, IOT,
    RB, nRST, MODE
);
/*
    nCE:  chip(die, LUN) enable, low actived
    CLE:  command latch enable
    ALE:  address latch enable
    nWE:  write enable, low actived
    nRE:  read enable, low actived
    nWP:  write protect, low actived
    IOH:  [7:0] data I/O to Host
    IOT:  [7:0] data I/O to Target
    RB:   ready/busy
    nRST: reset trigger, low actived
    MODE: [7:0] for host to select incoming I/O is 0: command, 1: address, 2: data

*/

input  RB, nRST, MODE;
output nCE, CLE, ALE, nWE, nRE, nWP;
inout  IOH, IOT;

wire [2:0] MODE;
wire [7:0] IOH, IOT; // IO to host and IO to target
reg nCE, CLE, ALE, nWE, nRE, nWP;
reg [7:0] buff;

always @( negedge nRST) begin
    command_cycle(`CMD_RESET);
    address_cycle(8'hAA);
    address_cycle(8'hAB);
    address_cycle(8'hAC);
    address_cycle(8'hAD);
    address_cycle(8'hAE);
    address_cycle(8'hAF);
    data_cycle(8'h00);
    data_cycle(8'h01);
    data_cycle(8'h02);
    data_cycle(8'h03);
    data_cycle(8'h04);
    data_cycle(8'h05);
    data_cycle(8'h06);
    data_cycle(8'h07);
    data_cycle(8'h08);
    data_cycle(8'h09);
    data_cycle(8'h0A);
    data_cycle(8'h0B);
    data_cycle(8'h0C);
    data_cycle(8'h0D);
    data_cycle(8'h0E);
    data_cycle(8'h0F);
end
assign IOT = buff;

task command_cycle;
    input [7:0] cmd;
    begin: command_cycle

        CLE = (`HIGH);
        nCE = (`LOW);
        nWE = (`LOW);
        ALE = (`LOW);
        buff <= cmd;
        
        # (`T_CS) // # 15
        nWE = ~nWE;

        # (`T_CH) // # 5
        nCE = ~nCE; 
        CLE = ~CLE;
        ALE = ~ALE;
    end
endtask


task address_cycle;
    input [7:0] addr;
    begin: address_cycle

        CLE = (`LOW);
        nCE = (`LOW);
        nWE = (`LOW);
        ALE = (`HIGH);
        buff <= addr;
        
        # (`T_WP) // # 10
        nWE = ~nWE;

        # (`T_WH); // # 7
    end
endtask

task data_cycle;
    input [7:0] data;
    begin: data_cycle

        CLE = (`LOW);
        nCE = (`LOW);
        ALE = (`LOW);
        nWE = (`LOW);
        buff <= data;
        
        # (`T_WP) // # 10
        nWE = ~nWE;

        # (`T_WH); // # 7
    end
endtask
endmodule

