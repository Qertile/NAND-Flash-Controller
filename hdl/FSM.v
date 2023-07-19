`include "inc.v"
module fsm (
    /* APB Inputs */
    PCLK,
    PRESETN,

    /* Controller Inputs */
    C_Cmd,
    C_Addr,
    C_Length,
    C_Status,
    
    /* Controller Outputs */
    F_nCE, 
    F_CLE, 
    F_ALE, 
    F_nWE, 
    F_nRE, 
    F_nWP,
    F_nRB,
    F_DIO
);

/* APB Inputs */
input       PCLK;
input       PRESETN;

/* Controller Inputs */
input       C_Cmd;
input       C_Addr;
input       C_Length;
input       C_Status;
input       F_nRB; 

/* Controller output */
output       F_nCE; 
output       F_CLE; 
output       F_ALE; 
output       F_nWE; 
output       F_nRE; 
output       F_nWP;
output       F_DIO;


/* Control registers and Status register  */
wire    [15:0]  C_Cmd;
wire    [39:0]  C_Addr;
wire    [7:0]   C_Length;
wire    [7:0]   C_Status;

/* Controller output */
reg F_nCE;
reg F_CLE;
reg F_ALE;
reg F_nWE;
reg F_nRE;
reg F_nWP;
reg [7:0] F_DIO;


/* Internal signals */
reg state;
reg next_state;


parameter   STATE_REST  = 3'b111;
parameter   STATE_IDLE  = 3'b000;
parameter   STATE_READ  = 3'b001;
parameter   STATE_WRIT  = 3'b010;
parameter   STATE_ERAS  = 3'b011;
parameter   STATE_RX    = 3'b100;



always @(posedge PCLK or negedge PRESETN) begin
    if (!PRESETN) begin
        state <= STATE_REST;
    end 
    else begin
        state <= STATE_IDLE;
    end
end
always @(*) begin
    case (state)
    STATE_REST: begin
        if (C_Cmd == 1) begin
            next_state <= 2'b01;
        end 
        else begin
        next_state <= STATE_IDLE;
    end
    STATE_IDLE: begin
        next_state <= STATE_IDLE;
    end
    STATE_READ: begin
        if (C_Cmd == 1) begin
            next_state <= 2'b01;
        end 
        else begin
            next_state <= 2'b00;
        end
    end
    STATE_WRIT: begin
        if (C_Cmd == 1) begin
            next_state <= 2'b01;
        end 
        else begin
            next_state <= 2'b00;
        end
    end
    STATE_ERAS: begin
        if (C_Cmd == 1) begin
            next_state <= 2'b01;
        end else begin
            next_state <= 2'b00;
        end
    end
    STATE_RX: begin
        if (C_Cmd == 1) begin
            next_state <= 2'b01;
        end 
        else begin
            next_state <= 2'b00;
        end
    end
    default: begin
        next_state <= STATE_IDLE;
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
        // buff <= cmd;
        
        # (`T_CS) // # 15
        F_nWE = ~F_nWE;

        # (`T_CH) // # 5
        F_nCE = ~F_nCE; 
        F_CLE = ~F_CLE;
        F_ALE = ~F_ALE;
    end
endtask


task address_cycle;
    input [7:0] addr;
    begin: address_cycle

        F_CLE = (`LOW);
        F_nCE = (`LOW);
        F_nWE = (`LOW);
        F_ALE = (`HIGH);
        // buff <= addr;
        
        # (`T_WP) // # 10
        F_nWE = ~F_nWE;

        # (`T_WH); // # 7
    end
endtask

task datain_cycle;
    input [7:0] data;
    begin: datain_cycle

        F_CLE = (`LOW);
        F_nCE = (`LOW);
        F_ALE = (`LOW);
        F_nWE = (`LOW);
        // buff <= data;
        
        # (`T_WP) // # 10
        F_nWE = ~F_nWE;

        # (`T_WH); // # 7
    end
endtask

task dataout_cycle;
    output [7:0] data;
    if (F_nRB) begin
        
        begin: dataout_cycle

            F_nCE = (`LOW);
            F_nRE = (`LOW);
            // buff <= data;
            
            # (`T_RP) // # 10
            F_nWE = ~F_nWE;

            # (`T_REH); // # 7
        end
    end
endtask

task reset_cycle;
    output [7:0] data;
    if (F_nRB) begin
        
        begin: dataout_cycle

            F_nCE = (`LOW);
            F_nRE = (`LOW);
            // buff <= data;
            
            # (`T_RP) // # 10
            F_nWE = ~F_nWE;

            # (`T_REH); // # 7
        end
    end
endtask
endmodule