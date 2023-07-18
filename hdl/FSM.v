`include "inc.v"
module fsm (
    /* APB Inputs */
    PCLK,

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

reg F_nCE;
reg F_CLE;
reg F_ALE;
reg F_nWE;
reg F_nRE;
reg F_nWP;
reg [7:0] F_DIO;

/*
always @(posedge clk or posedge reset) begin
    if (reset) begin
    state <= 2'b00;
    end else begin
    state <= next_state;
    end
end
always @(*) begin
    case (state)
    2'b00: begin
        if (input == 1) begin
        next_state <= 2'b01;
        end else begin
        next_state <= 2'b00;
        end
    end
    2'b01: begin
        if (input == 1) begin
        next_state <= 2'b01;
        end else begin
        next_state <= 2'b00;
        end
    end
    default: begin
        next_state <= 2'b00;
    end
    endcase
end
*/
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

task data_cycle;
    input [7:0] data;
    begin: data_cycle

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
endmodule