`include "inc.v"

`timescale 1ns/100ps

module MT29F8G08ABACAWP (
    nCE, CLE, ALE, nWE, nRE, nWP,
    IOH, IOT,
    RB, nRST, TYPE
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
    TYPE: [7:0] for host to select incoming I/O is 0: command, 1: address, 2: data

*/

input  RB, nRST, TYPE;
output nCE, CLE, ALE, nWE, nRE, nWP;
inout  IOH, IOT;

wire [1:0] TYPE;
wire [7:0] IOH, IOT; // IO to host and IO to target
reg nCE, CLE, ALE, nWE, nRE, nWP;
reg [7:0] buff;

always @( negedge nRST) begin
    command_cycle(`CMD_RESET);
end

always @(IOH)begin
    case (TYPE)
        2'b00: command_cycle(IOH);
        2'b01: address_cycle(IOH);
        2'b10: data_cycle(IOH);
        default: command_cycle(IOH);
    endcase
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

