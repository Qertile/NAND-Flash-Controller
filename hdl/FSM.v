
`timescale 1ns/100ps
`include "inc.v"
module fsm (
    /* APB Inputs */
    P_clk,
    P_nrst,

    /* Controller Inputs */
    C_Cmd,
    C_Addr,
    C_Length,
    C_Status,
    C_RdData,
    C_WrData,
    
    /* Controller Outputs */
    F_nCE, 
    F_CLE, 
    F_ALE, 
    F_nWE, 
    F_nRE, 
    F_nWP,
    F_nRB,
    /* Controller I/O */
    F_DIO
);

/* APB Inputs */
input       P_clk;
input       P_nrst;

/* Controller Inputs */
input       C_Cmd;
input       C_Addr;
input       C_Length;
input       C_Status;
input       C_WrData; // from Tx FIFO to controller buffer
input       F_nRB; 

/* Controller output */
output      F_nCE; 
output      F_CLE; 
output      F_ALE; 
output      F_nWE; 
output      F_nRE; 
output      F_nWP;
output      C_RdData; // from controller buffer to Rx FIFO
inout       F_DIO;


/* Controller Inputs */
wire    [7:0]   C_Cmd;
wire    [7:0]   C_Addr;
wire    [7:0]   C_Length;
wire    [7:0]   C_Status;
wire    [7:0]   C_WrData; 
wire    [7:0]   F_DIO;


/* Controller output */
reg F_nCE;
reg F_CLE;
reg F_ALE;
reg F_nWE;
reg F_nRE;
reg F_nWP;
reg [7:0]   C_RdData;


/* Internal signals and array */
reg [2:0]   i_state;
reg [2:0]   i_next_state;
reg [7:0]   i_cmd  [1:0];
reg [7:0]   i_addr [4:0];
reg         i_cmd_ptr;
reg [2:0]   i_addr_ptr;
reg [7:0]   i_wrdata_buffer;
reg [7:0]   i_rddata_buffer;
wire        i_go_state;


/* Custom define states for state machine */
parameter   STATE_RSET  = 3'b111;
parameter   STATE_IDLE  = 3'b000;
parameter   STATE_READ  = 3'b001;
parameter   STATE_WRIT  = 3'b010;
parameter   STATE_ERAS  = 3'b011;
parameter   STATE_RX    = 3'b100;

/* command for state machine */
parameter   CMD_RSET  = 8'hFF;
parameter   CMD_READ  = 8'h00;
parameter   CMD_WRIT  = 8'h80;
parameter   CMD_ERAS  = 8'h60;


assign F_DIO = i_wrdata_buffer;

always @(posedge P_clk or negedge P_nrst) begin
    if (!P_nrst) begin
        /* reset NAND flash */
        i_state <= STATE_RSET;
        /* reset command buffer */
        i_cmd_ptr <= 0;
        i_addr_ptr <= 0;
    end 
    else begin
        case (C_Cmd)
        CMD_RSET: begin
            i_state = STATE_RSET;
        end
        CMD_READ: begin
            i_state = STATE_READ;
        end
        CMD_WRIT: begin
            i_state = STATE_WRIT;
        end
        CMD_ERAS: begin
            i_state = STATE_ERAS;
        end
            default: i_state = i_state;
    endcase
    end
end

always @(C_Cmd) begin
    i_cmd[i_cmd_ptr] <= C_Cmd;
    i_cmd_ptr = ~i_cmd_ptr;
end

always @(C_Addr) begin
    i_addr[i_addr_ptr] <= C_Addr;
    i_addr_ptr = i_addr_ptr+1;
    if (i_cmd[0] != 8'h60 && i_addr_ptr == 3'd5) begin
        i_addr_ptr <= 0;
    end
    else if (i_addr_ptr == 3'd3)begin
        i_addr_ptr <= 0;
    end
end

assign i_go_state = (!i_cmd_ptr) & (!i_addr_ptr);

integer i;
always @(i_state or posedge i_go_state) begin

    case (i_state)
    STATE_RSET: begin
        if (!P_nrst) begin
            command_cycle(8'hFF);
        end 
        else begin
        end
    end
    STATE_IDLE: begin
        idle_cycle();
        i_next_state <= STATE_IDLE;
    end
    STATE_READ: begin
        if (i_cmd[0] == 8'h00 && i_cmd[1] == 8'h30) begin
            command_cycle (i_cmd[0]);
            for (i = 0; i<5; i=i+1) begin
                address_cycle (i_addr[i]);
            end
            command_cycle (i_cmd[1]);
                
            # (`T_R + `T_RR) // # 20+25
            
            for (i = 0; i<C_Length; i=i+1) begin
                rddata_cycle(F_DIO);
            end
        end 
        else begin
        end
    end
    STATE_WRIT: begin
        if (i_cmd[0] == 8'h80 && i_cmd[1] == 8'h10) begin
            command_cycle (i_cmd[0]);
            for (i = 0; i<5; i=i+1) begin
                address_cycle (i_addr[i]);
            end

            # (`T_ADL) // # 70
            
            for (i = 0; i<C_Length; i=i+1) begin
                wrdata_cycle(C_WrData);
            end

            command_cycle (i_cmd[1]);
        end 
        else begin
        end
    end
    STATE_ERAS: begin
        if (i_cmd[0] == 8'h60 && i_cmd[1] == 8'hD0) begin
            command_cycle(i_cmd[0]);
         
            for (i = 0; i<3; i=i+1) begin
                address_cycle (i_addr[i]);
            end
        
            command_cycle(i_cmd[1]);
        end
    end
    default: begin
        idle_cycle();
    end
    endcase
end

/* ----- Tasks of cycles ----- */

task command_cycle;
    input [7:0] cmd;
    begin: command_cycle

        F_CLE = (`HIGH);
        F_nCE = (`LOW);
        F_nWE = (`LOW);
        F_ALE = (`LOW);
        i_wrdata_buffer <= cmd;
        
        # (`T_CS) // # 15
        F_nWE = ~F_nWE;

        # (`T_CH) // # 5
        F_nCE = ~F_nCE; 
        F_CLE = ~F_CLE;
        F_ALE = ~F_ALE;
        F_nCE = (`HIGH);
    end
endtask


task address_cycle;
    input [7:0] addr;
    begin: address_cycle

        F_CLE = (`LOW);
        F_nCE = (`LOW);
        F_nWE = (`LOW);
        F_ALE = (`HIGH);
        i_wrdata_buffer <= addr;
        
        # (`T_WP) // # 10
        F_nWE = ~F_nWE;

        # (`T_WH); // # 7
        F_nCE = (`HIGH);
    end
endtask

task wrdata_cycle;
    input [7:0] data;
    begin: wrdata_cycle

        F_CLE = (`LOW);
        F_nCE = (`LOW);
        F_ALE = (`LOW);
        F_nWE = (`LOW);
        i_wrdata_buffer <= data;
        
        # (`T_WP) // # 10
        F_nWE = ~F_nWE;

        # (`T_WH); // # 7
        F_nCE = (`HIGH);
    end
endtask

task rddata_cycle;
    input [7:0] data;
    if (F_nRB) begin
        
        begin: rddata_cycle

            F_nCE = (`LOW);
            F_nRE = (`LOW);
            i_rddata_buffer <= data;
            
            # (`T_RP) // # 10
            F_nRE = ~F_nRE;

            # (`T_REH); // # 7
            F_nCE = (`HIGH);
        end
    end
endtask

task idle_cycle;        
    begin: idle_cycle

        F_nCE = (`HIGH);
        F_CLE = 1'bx;
        F_ALE = 1'bx;
        F_nWE = 1'bx;
        F_nRE = 1'bx;
        F_nWP = (`LOW);

    end
endtask
endmodule